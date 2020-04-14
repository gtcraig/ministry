/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  26-Sep-2007  Early working version.
 * CAM  23-Jan-2010  10553 : Created GetTitle to remove extraneous formatting for display in TOC etc.
 * CAM  29-Dec-2012  11151 : Remove broken-bar footnotes from TOC.
 * CAM  31-Dec-2015  886930 : Added leading zeroes to Id to ensure better sorting.
 * CAM  14-Apr-2020  361011 : Added Article Group.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class Article
  {
    protected Volume _vol;
    protected ArticleGroup _group;

    protected int _pageNo;
    protected int _para;
    protected int _localRow;
    protected string _title;
    protected string _scriptures;

    public string Id
    {
      get
      {
        return GetId(_vol, _localRow);
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
      get { return _para; }
      set { _para = value; }
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
    public string Title
    {
      get
      {
        return _title;
      }
      set
      {
        _title = GetTitle(value);
      }
    }
    public string Scriptures
    {
      get
      {
        return _scriptures;
      }
      set
      {
        _scriptures = value;
      }
    }
    public ArticleGroup Group
    {
      get
      {
        return _group;
      }
      set
      {
        if (_group == null)
        {
          _group = value;
          if (_title.StartsWith(value.Title))
          {
            _title = _title.Substring(value.Title.Length).Trim();
            if (_title.StartsWith(@"\")) _title = _title.Substring(1).Trim();
          }
        }
      }
    }

    public static string GetTitle(string title)
    {
      const string SuperscriptStart = "<sup>";
      const string SuperscriptEnd = "</sup>";

      int p = title.IndexOf(SuperscriptStart);
      while (p >= 0)
      {
        int e = title.IndexOf(SuperscriptEnd, p);
        if (e > 0) title = title.Substring(0, p) + title.Substring(e + SuperscriptEnd.Length);

        p = title.IndexOf(SuperscriptStart);
      }

      title = title.Replace("¦", ""); // Remove broken-bar style footnotes too

      return title;
    }

    public Article(Volume vol, int pageNo, int para, int localRow, string title)
    {
      _vol = vol;
      PageNo = pageNo;
      Para = para;
      LocalRow = localRow;
      Title = title;
    }

    public override string ToString()
    {
      return String.Format("{0}-{1}: {2}", _vol.Id, _para, _title);
    }

    public static string GetId(Volume vol, int localRow)
    {
      return String.Format("{0}-{1:000000}", vol.Id, localRow);
    }
  }

  public class ArticleCollection : KeyedCollection<string, Article>
  {
    public ArticleCollection()
      : base()
    {
    }

    protected override string GetKeyForItem(Article article)
    {
      return article.Id;
    }
  }
}
