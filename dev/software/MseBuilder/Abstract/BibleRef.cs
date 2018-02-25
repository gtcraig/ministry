/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  15-Jan-2010  10528 : Use Properties rather than methods.
 * CAM  29-Aug-2015  163118 : Added Article Primary property.
 * CAM  22-Feb-2018  732482 : Tidied space after colon in Bible Refs.
 * CAM  25-Feb-2018  790063 : Used correct namespace for Data.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

using FrontBurner.Ministry.MseBuilder.Data;
using FrontBurner.Ministry.MseBuilder.Engine;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class BibleRef
  {
    protected BibleBook _book;
    protected string _chapter;
    protected string _vStart;
    protected string _vEnd;
    protected bool _articlePrimary; // This Scripture Reference is primary to the article - read at the beginning
    protected bool _refValid;
    protected char _errCode;

    protected int _verseStart;
    protected int _verseEnd;

    public BibleBook Book
    {
      get
      {
        return _book;
      }
    }
    public int Chapter
    {
      get
      {
        if (_book.SingleChap) return 0;
        return Int32.Parse(_chapter);
      }
    }
    public bool RefValid
    {
      get
      {
        return _refValid;
      }
    }
    public char ErrCode
    {
      get
      {
        return _errCode;
      }
    }
    public int VerseStart
    {
      get
      {
        return _verseStart;
      }
    }
    public int VerseEnd
    {
      get
      {
        return _verseEnd;
      }
    }
    public bool ArticlePrimary
    {
      get
      {
        return _articlePrimary;
      }
    }

    public BibleRef(string scripture, bool articlePrimary)
    {
      _chapter = "";
      _vStart = "";
      _vEnd = "";
      _articlePrimary = articlePrimary;
      _refValid = false;
      _errCode = ' ';

      ParseScripture(scripture);
    }

    public BibleRef(string scripture)
      : this(scripture, false)
    {
    }

    public string RemoveNonNumeric(string text)
    {
      char[] buffa = text.ToCharArray();
      int ouc;

      for (int i = buffa.Length - 1; i >= 0; i--)
      {
        ouc = (int)buffa[i];
        if (ouc >= 48 && ouc <= 57)
        {
          return text.Substring(0, i + 1).Trim();
        }
      }

      return "";
    }

    public void ParseScripture(string scripture)
    {
      Parse(scripture);

      if (_refValid)
      {
        _vStart = _vStart.Trim();
        _vEnd = _vEnd.Trim();

        _verseStart = 0;
        _verseEnd = 0;

        if (_vStart.Length > 0) _verseStart = Int32.Parse(_vStart);
        if (_vEnd.Length > 0) _verseEnd = Int32.Parse(_vEnd);
      }
    }

    protected void Parse(string scripture)
    {
      string start = scripture;
      string rem = "";
      BibleBookCollection books = BusinessLayer.Instance.Books;
      int ap = 0;
      int j = 0;
      bool colon;
      bool match;
      int ouc;
      int chp;
      string cv;

      for (j = 1; j <= books.Count; j++)
      {
        if (books[j].Matches(start))
        {
          _book = books[j];

          int len = 100;
          if ((start.Length) < len) len = start.Length;

          rem = start.Substring(_book.BookName.Length, len - _book.BookName.Length).Trim();

          if (rem.StartsWith("."))
          {
            rem = rem.Substring(1).Trim();
          }
          if ((ap = rem.IndexOf(".")) >= 0)
          {
            rem = rem.Substring(0, ap);
          }
          if ((ap = rem.IndexOf(")")) >= 0)
          {
            rem = rem.Substring(0, ap);
          }
          if ((ap = rem.IndexOf("(")) >= 0)
          {
            rem = rem.Substring(0, ap);
          }
          if ((ap = rem.IndexOf("\"")) >= 0)
          {
            rem = rem.Substring(0, ap);
          }
          if ((ap = rem.IndexOf(";")) >= 0)
          {
            rem = rem.Substring(0, ap);
          }

          break;
        }
      }

      colon = match = false;
      if (rem.Length > 0)
      {
        char[] buffa = rem.ToUpper().ToCharArray();
        int k = 0;

        for (k = 0; k < buffa.Length; k++)
        {
          ouc = buffa[k];

          if (ouc == ':')
          {
            if (colon)
            {
              match = true;
              break;
            }
            colon = true;
          }
          else if (ouc >= 65 && ouc <= 97)
          {
            match = true;
            break;
          }
        }

        if (match)
        {
          cv = rem.Substring(0, k).Trim();
        }
        else
        {
          cv = rem.Trim();
        }

        if (cv.Length == 0)
        {
          _refValid = false;
          return;
        }

        cv = RemoveNonNumeric(cv);

        if (cv.Length == 0)
        {
          _refValid = false;
          return;
        }

        if (_book.SingleChap)
        {
          // No chapter reference - look straight at the verses
          if ((chp = cv.IndexOf("-")) >= 0)
          {
            _vStart = cv.Substring(0, chp).Trim();
            _vEnd = cv.Substring(chp + 1);
          }
          else if ((chp = cv.IndexOf(",")) >= 0)
          {
            _vStart = cv.Substring(0, chp).Trim();
            _vEnd = cv.Substring(chp + 1);

          }
          else
          {
            _vStart = cv;
          }

          if (!DatabaseLayer.IsInteger(_vStart) || !DatabaseLayer.IsInteger(_vEnd))
          {
            // Non-numerics
            _errCode = 'S';
            _refValid = false;
            return;
          }

          _refValid = true;
          return;
        }

        if ((chp = cv.IndexOf(":")) >= 0)
        {
          _chapter = cv.Substring(0, chp).Trim();
          if (_chapter.IndexOf("-") >= 0)
          {
            // Range before colon is invalid
            _errCode = 'L';
            _refValid = false;
            return;
          }

          string vs = cv.Substring(chp + 1).Trim();

          if ((chp = vs.IndexOf("-")) >= 0)
          {
            _vStart = vs.Substring(0, chp).Trim();
            _vEnd = vs.Substring(chp + 1);

          }
          else if ((chp = vs.IndexOf(",")) >= 0)
          {
            _vStart = vs.Substring(0, chp).Trim();
            _vEnd = vs.Substring(chp + 1);
          }
          else
          {
            _vStart = vs;
          }

        }
        else
        {
          if ((chp = cv.IndexOf("-")) >= 0)
          {
            // Chapter range is invalid
            _errCode = 'C';
            _refValid = false;
            return;
          }

          _chapter = RemoveNonNumeric(cv.Trim());
        }

        if ((_chapter.Length == 0) || !DatabaseLayer.IsInteger(_chapter) || !DatabaseLayer.IsInteger(_vStart) || !DatabaseLayer.IsInteger(_vEnd))
        {
          // Non-numerics
          _errCode = 'N';
          _refValid = false;
          return;
        }

        _refValid = true;
      }
    }

    public override string ToString()
    {
      string rval = String.Format("{0} {1}", _book.BookName, _chapter);

      if (_vStart.Length > 0)
      {
        rval += ":" + _vStart;
      }

      if (_vEnd.Length > 0)
      {
        rval += "-" + _vEnd;
      }

      return rval;
    }
  }
}
