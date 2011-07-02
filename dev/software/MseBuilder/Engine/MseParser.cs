/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: MseParser.cs 1157 2010-02-13 14:54:18Z craig $
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10189 : Catch all initials, and tidy them up appropriately.
 * CAM  24-Nov-2007  10188 : Remember the current Article and assign to each new paragraph within.
 * CAM  17-May-2008  10266 : Check for Errors during Parse.
 * CAM  15-Jun-2008  10271 : Handle Footnotes.
 * CAM  18-Jan-2010  10529 : Missed several references to Author!
 * CAM  23-Jan-2010  10553 : Handle JND's footnotes correctly.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Engine;

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

      if (text.StartsWith("."))
      {
        // Ignore the very first period if there is one
        start++;
      }

      // Look for any of the Constant Initials first
      foreach (string s in _constantIntials)
      {
        if ((text.Length >= s.Length) && (text.Substring(start, s.Length).Equals(s)))
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

          if (dotCount > 1)
          {
            inits = true;
          }
        }
      }

      if (inits && (i > 0))
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
      StreamReader sr = new StreamReader(_vol.GetFile().FullName);
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
        else
        {
          para++;
          calcPageNo = pageNo;

          //if ((buffer.Length >= 4) && buffer.Substring(0, 4).Equals("<sup"))
          //{
          //  // Footnote, add to the previous paragraph
          //  // (which is paraCurrent because its not reset until below)
          //  if ((paraFootnotes == null) && (paraCurrent != null))
          //  {
          //    paraFootnotes = paraCurrent;
          //  }
          //  paraFootnotes.Footnotes.Add(buffer);
          //  calcPageNo = paraFootnotes.PageNo;
          //  para = paraFootnotes.NextParaNo;
          //  footnote = true;
          //}
          //else
          //{
          //  // Not a footnote - close off the previous paragraph and reset paragraph counter
          //  if (paraFootnotes != null)
          //  {
          //    if (pageNo != paraFootnotes.PageNo) para = 1; // reset paragraph counter if we have changed page
          //    paraFootnotes = null;
          //  }
          //}

          inits = null;

          if (GetInitials(buffer, out initStart, out initFinish))
          {
            inits = TidyInitials(buffer.Substring(initStart, initFinish - initStart));
            buffer = buffer.Substring(initFinish, buffer.Length - initFinish).Trim();
          }

          paraCurrent = new Paragraph(_vol, calcPageNo, para, rows, inits, buffer);
          if (paraCurrent.AnyErrors) anyErrors = true;

          prevTitle = false;
          if (paraCurrent.IsTitle())
          {
            art = paraCurrent.Article;
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
            bool footnote = buffer.StartsWith("<sup>");

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
