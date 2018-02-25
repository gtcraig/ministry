/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  01-Oct-2007  File created.
 * CAM  24-Nov-2007  10188 : Added instance variable for Article.
 * CAM  24-Nov-2007  10208 : Added NewPages.
 * CAM  24-Nov-2007  10214 : Consider '>' to be an acceptable end paragraph character (html markup).
 * CAM  12-May-2008  10265 : Save page continuations.
 * CAM  17-May-2008  10266 : Added AnyErrors.
 * CAM  08-Jun-2008  10269 : Only include a new page marker if the abruptly ending paragraph was on a different physical page.
 * CAM  15-Jun-2008  10271 : Added Footnotes.
 * CAM  15-Jun-2008  10271 : Consider '"' to be an acceptable end paragraph character (end quote).
 * CAM  15-Jan-2010  10531 : Created a static version of IsTitle.
 * CAM  23-Jan-2010  10553 : Use GetTitle to remove extraneous formatting before checking whether a Paragraph is a Title.
 * CAM  29-Dec-2012  11151 : Use Properties as intended.
 * CAM  01-Jan-2013  11153 : Support for SubTitles (lines beginning %).
 * CAM  29-Aug-2015  163118 : Added the Article Primary property to ensure primary Scriptures are stamped.
 * CAM  25-Feb-2018  790063 : Used correct namespace for Data.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Windows.Forms;

using FrontBurner.Ministry.MseBuilder.Data;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class Paragraph : Collection<BibleRef>
  {
    protected Volume _vol;
    protected Article _art;
    protected Footnotes _footnotes;
    protected int _pageNo;
    protected int _para;
    protected int _localRow;
    protected string _inits;
    protected string _text;
    protected List<int> _newPages;
    protected bool _articlePrimary;
    protected bool _anyErrors;

    public string Id
    {
      get
      {
        return GetId(_vol, _para);
      }
    }
    public Volume Volume
    {
      get
      {
        return _vol;
      }
    }
    public int PageNo
    {
      get
      {
        return _pageNo;
      }
      set
      {
        _pageNo = value;
      }
    }
    public int Para
    {
      get
      {
        return _para;
      }
      set
      {
        _para = value;
      }
    }
    public int LocalRow
    {
      get
      {
        return _localRow;
      }
      set
      {
        _localRow = value;
      }
    }
    public string Inits
    {
      get
      {
        return _inits;
      }
      set
      {
        _inits = value;
      }
    }
    public string Text
    {
      get
      {
        return _text;
      }
      set
      {
        _text = value.Trim();
        if (_text.StartsWith("%"))
        {
          _text = String.Format("<h4>{0}</h4>", _text.Substring(1));
        }
      }
    }
    public string NewPages
    {
      get
      {
        string newPages = "";
        foreach (int cp in _newPages)
        {
          if (newPages.Length > 0) newPages += ",";
          newPages += cp.ToString().Trim();
        }
        return newPages;
      }
    }
    public bool AnyErrors
    {
      get
      {
        return _anyErrors;
      }
    }
    public Footnotes Footnotes
    {
      get
      {
        if (_footnotes == null)
        {
          _footnotes = new Footnotes();
        }
        return _footnotes;
      }
    }
    public int NextParaNo
    {
      get
      {
        return this.Para + Footnotes.Count;
      }
    }

    public Article Article
    {
      get
      {
        if (_art == null)
        {
          _art = new Article(_vol, _pageNo, _para, _localRow, _text);
        }
        return _art;
      }
      set
      {
        _art = value;
      }
    }

    public Paragraph(Volume vol, int pageNo, int para, int localRow, string inits, string text, bool articlePrimary)
      : base()
    {
      _vol = vol;
      PageNo = pageNo;
      Para = para;
      LocalRow = localRow;
      Inits = inits;
      Text = text;
      _articlePrimary = articlePrimary;

      _newPages = new List<int>();

      ParseBibleRefs();
    }

    protected void ParseBibleRefs()
    {
      // Parse Scriptures
      if (_text.IndexOf("@") >= 0)
      {
        string[] refs = _text.Split(new Char[] { '@' });

        for (int i = 1; i < refs.Length; i++)
        {
          BibleRef bref = new BibleRef(refs[i], _articlePrimary);

          if (bref.RefValid)
          {
            this.Add(bref);
          }
          else
          {
            DatabaseLayer.Instance.InsertBadBibleRef(_vol, _pageNo, _para, i, bref.ErrCode, refs[i]);
            _anyErrors = true;
          }
        }
      }
    }

    public void Augment(Paragraph previous)
    {
      foreach (int i in previous._newPages)
      {
        _newPages.Add(i);
      }

      if (_pageNo != previous._pageNo)
      {
        // Only add a new page marker if the page has changed
        _newPages.Add(previous.Text.Length);
      }

      _pageNo = previous._pageNo;
      _para = previous._para;
      _localRow = previous._localRow;
      _inits = previous._inits;

      _text = string.Format("{0} {1}", previous.Text, this.Text);

      foreach (BibleRef bref in previous)
      {
        this.InsertItem(0, bref);
      }
    }

    public bool EndsAbruptly(bool specialLine)
    {
      if (specialLine || (_text.Length == 0)) return false;

      if (_text.EndsWith(".\"")) return false;  // A sentence can end with a period in a quotation

      char[] lastChar = _text.Substring(_text.Length - 1).ToCharArray();
      switch (lastChar[0])
      {
        case '.':
        case '!':
        case '?':
        case '>':
        case '"':
        case '*': // footnote marker
          return false;

        // The following are not strictly the end of a sentence,
        // but a sufficent break - found many paragraphs continuing over several pages!
        // found
        case ',':
        case ';':
        case ':':
        case ')':
          return false;
      }
      return true;
    }

    public bool IsTitle()
    {
      return IsTitle(_text);
    }

    public bool IsSubTitle()
    {
      return IsSubTitle(_text);
    }

    public static bool IsTitle(string text)
    {
      int upper;
      int lower;
      int html;
      int other;
      int c;

      text = Article.GetTitle(text);

      upper = lower = html = other = 0;
      char[] buffa = text.ToCharArray();
      for (int i = 0; i < buffa.Length; i++)
      {
        c = (int)buffa[i];
        if (c >= 65 && c <= 90)
        {
          upper++;
        }
        else if (c >= 97 && c <= 122)
        {
          lower++;
        }
        else if (c == 60 || c == 62)
        {
          html++;
        }
        else if (c == 34 || c == 39 || c == 32 || c == 13 || c == 10 || c == 58 || c == 45)
        {
          // ignore quotes/ws in the 'other' count
        }
        else if (c == 46)
        {
          other++;
        }
        else
        {
          // other++;
        }
      }

      if (((upper + lower) > 0) && (html == 0) && (!text.Equals("PREFATORY NOTE")) && (!text.Equals("*NOTE*")))
      {
        if (((float)upper / (float)(upper + lower + other)) > 0.7f)
        {
          return true;
        }
      }
      return false;
    }

    public static bool IsSubTitle(string text)
    {
      return (text.StartsWith("<h4>"));
    }

    public void SaveToDatabase()
    {
      DatabaseLayer.Instance.InsertParagraph(this);

      int i = 1;
      foreach (BibleRef bref in this)
      {
        DatabaseLayer.Instance.InsertBibleRef(this, i++, bref);
      }
    }

    public static string GetId(Volume vol, int para)
    {
      return String.Format("{0}-{1}", vol.Id, para);
    }
  }
}
