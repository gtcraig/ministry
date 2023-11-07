/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10189 : Catch all initials, and tidy them up appropriately.
 * CAM  24-Nov-2007  10188 : Remember the current Article and assign to each new paragraph within.
 * CAM  17-May-2008  10266 : Check for Errors during Parse.
 * CAM  15-Jun-2008  10271 : Handle Footnotes.
 * CAM  18-Jan-2010  10529 : Missed several references to Author!
 * CAM  23-Jan-2010  10553 : Handle JND's footnotes correctly.
 * CAM  29-Dec-2012  11151 : Treat broken-bars as footnotes.
 * CAM  01-Jan-2013  11153 : Support for SubTitles (lines beginning %).
 * CAM  29-Aug-2015  163118 : Passed the Article Primary property to Paragraph to ensure primary Scriptures are stamped.
 * CAM  25-Feb-2018  790063 : Used correct namespace for Data.
 * CAM  14-Apr-2020  361011 : Consider for Article Groups when parsing.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;
using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Data;

namespace FrontBurner.Ministry.MseBuilder.Engine
{
  class MseParser
  {
    protected Volume _vol;
    protected List<string> _constantIntials;

    public MseParser(Volume vol)
    {
      _vol = vol;
    }

    protected bool GetInitials(string text, out int start, out int finish)
    {
      bool halt = false;
      bool inits = false;
      bool upper = false;
      int dotCount = 0;
      int c = 0;
      int i = 0;
      int window = 11;
      start = 0;
      finish = 0;

      if (_constantIntials == null)
      {
        _constantIntials = new List<string>();
        _constantIntials.Add("Rem.");
        _constantIntials.Add("Ques.");
        _constantIntials.Add("*Rem*.");
        _constantIntials.Add("*Ques*.");
      }

      if (text.Length <= 3)
      {
        // Don't look for initials in very short lines
        return false;
      }
      else if (text.Length <= 25 && text[text.Length-1] != '.')
      {
        // Don't look for initials in lines that are likely to be author's names on a single line
        return false;
      }

      if (text.StartsWith("."))
      {
        // Ignore the very first period if there is one
        start++;
      }

      // Look for any of the Constant Initials first
      foreach (string s in _constantIntials)
      {
        if ((text.Length > s.Length) && (text.Substring(start, s.Length).Equals(s)))
        {
          finish = s.Length;
          return true;
        }
      }

      char[] buffa = text.ToCharArray();
      for (i = start; i < buffa.Length && !halt && (i < window); i++)
      {
        c = (int)buffa[i];

        if (c == 46)
        {
          dotCount++;
        }
        else if (c == 32)
        {
          halt = true;

          if ((dotCount > 1) || (dotCount == 1 && i == 2))
          {
            inits = true;
          }
        }
        else if ((c >= 'A' && c <= 'Z') )
        {
          // At least one upper case
          upper = true;
        }
        else if ((c >= 'a' && c <= 'z') || c == '\'' || c == '-')
        {
          // Other valid characters
        }
        else
        {
          // Stop if any other non initials characters are found
          halt = true;
        }
      }

      if (inits && upper && (i > 0))
      {
        text = text.Substring(0, i).Trim();

        if (!text.StartsWith(".."))
        {
          finish = i;
          return true;
        }
      }

      return false;
    }

    public string TidyInitials(string inits)
    {
      string rval = inits.Replace(".", "").Replace(" ", "").Replace("*", "").Replace(",", "");

      while (rval.StartsWith("-"))
      {
        rval = rval.Substring(1);
      }

      return rval;
    }

    public bool ParseText()
    {
      StreamReader sr = new StreamReader(_vol.GetFile().FullName, System.Text.Encoding.Default, true);
      string buffer;
      int rows = 0;
      int cb = 0;
      int pageNo = 0;
      int calcPageNo = 0;
      int para = 0;
      int initStart = 0;
      int initFinish = 0;
      string inits;
      bool prevTitle = false;
      bool scriptures = false;
      bool anyErrors = false;
      Paragraph paraPrevious = null;
      Paragraph paraCurrent = null;
      //Paragraph paraFootnotes = null;
      Article art = null;
      ArticleGroupCollection articleGroups = new ArticleGroupCollection();

      while ((buffer = sr.ReadLine()) != null)
      {
        rows++;
        //MessageBox.Show(string.Format("{0}\n{1}", rows, buffer));

        buffer = buffer.Trim();

        scriptures = false;
        if ((buffer.StartsWith("@")) && prevTitle)
        {
          art = BusinessLayer.Instance.Articles[Article.GetId(_vol, (rows - 1))];
          art.Scriptures = buffer;
          DatabaseLayer.Instance.UpdateArticle(art);
          scriptures = true;
        }

        if (buffer.Length == 0)
        {
          // Ignore empty rows
        }
        else if ((buffer.Length > 0) && (buffer.StartsWith("{")) && (!buffer.Substring(0, 2).Equals("{#")))
        {
          //if (buffer.Substring(0, 2).Equals("{*"))
          //{
          //  MessageBox.Show(String.Format("You have not corrected a footnote: {0} Vol {1} page {2}\n\n{3}",
          //    _vol.Author.Inits, _vol.Vol, pageNo, buffer), "Bad Footnote");
          //}
          //else
          //{
          if ((cb = buffer.IndexOf("}")) >= 0)
          {
            pageNo = int.Parse(buffer.Substring(1, cb - 1));
          }

          para = 0;
          //}
        }
        else if ((buffer.Length > 1) && buffer.Substring(0, 2).Equals("{#"))
        {
          // Volume title - do nothing
        }
        else if ((buffer.Length > 1) && buffer.Substring(0, 1).Equals("$"))
        {
          // Article Grouping
          if (paraPrevious != null)
          {
            // Write out the previous paragraph
            paraPrevious.SaveToDatabase();
            paraPrevious = null;
          }
          string title = buffer;
          string locationDate = sr.ReadLine(); // Location, Date
          string summary = sr.ReadLine(); // Summary

          // [TODO:361011 - Parse LocationDate and split into City and Date, and enable this on any article]
          ArticleGroup articleGroup = new ArticleGroup(_vol, buffer, locationDate, locationDate, summary, rows);
          DatabaseLayer.Instance.CreateArticleGroup(articleGroup);
          articleGroups.Add(articleGroup);
        }
        else
        {
          para++;
          calcPageNo = pageNo;

          inits = null;

          if (GetInitials(buffer, out initStart, out initFinish))
          {
            inits = TidyInitials(buffer.Substring(initStart, initFinish - initStart));
            buffer = buffer.Substring(initFinish, buffer.Length - initFinish).Trim();
          }

          paraCurrent = new Paragraph(_vol, calcPageNo, para, rows, inits, buffer, scriptures);
          if (paraCurrent.AnyErrors) anyErrors = true;

          prevTitle = false;
          if (paraCurrent.IsSubTitle())
          {
            if (paraPrevious != null)
            {
              // Write out the previous paragraph
              paraPrevious.SaveToDatabase();
              paraPrevious = null;
            }

            if (art != null) paraCurrent.Article = art;
            DatabaseLayer.Instance.InsertParagraph(paraCurrent);
          }
          else if (paraCurrent.IsTitle())
          {
            art = paraCurrent.Article;

            // Add the Article to a matching Group in the Volume (if any)
            articleGroups.Add(art);
            // Ensure the Paragraph is reset to match the Article Title, accounting for any Groups or other changes
            paraCurrent.Text = art.Title;

            BusinessLayer.Instance.Articles.Add(art);
            DatabaseLayer.Instance.UpdateArticle(art);
            DatabaseLayer.Instance.InsertParagraph(paraCurrent);

            prevTitle = true;
            paraPrevious = null;
          }
          else
          {
            // Set the Article
            if (art != null) paraCurrent.Article = art;
            bool footnote = (buffer.StartsWith("<sup>") || buffer.StartsWith("¦"));

            if (paraPrevious != null)
            {
              if (footnote)
              {
                // Write out the previous paragraph
                paraPrevious.SaveToDatabase();
                paraPrevious = null;
              }
              else
              {
                // If the previous paragraph was not written out, add to it
                paraCurrent.Augment(paraPrevious);
              }
            }

            if (paraCurrent.EndsAbruptly(scriptures) && !footnote)
            {
              // The paragraph is not complete, so remember it for next iteration
              paraPrevious = paraCurrent;
            }
            else
            {
              // The paragraph ends normally - save it
              paraCurrent.SaveToDatabase();
              paraPrevious = null;
            }
          }
        }
      }
      sr.Close();
      return anyErrors;
    }
  }
}
