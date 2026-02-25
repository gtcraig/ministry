/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2026 GoodTeaching.org
 * Author Craig McKay <craig@goodteacing.org>
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.IO;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class Volume
  {
    private Author _author;
    private int _vol;
    private string _title;
    private DateTime _added;
    private string _localFile;

    public string Id
    {
      get
      {
        return GetId(_author.Inits, _vol);
      }
    }
    public Author Author
    {
      get
      {
        return _author;
      }
      set
      {
        _author = value;
      }
    }
    public int Vol
    {
      get
      {
        return _vol;
      }
      set
      {
        _vol = value;
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
        _title = value;
      }
    }
    public string VolumeTitle
    {
      get
      {
        if ((Author == Author.ScriptureAuthor) || (Author == Author.CollectionAuthor))
        {
          return FullTitle;
        }

        if (Title.Length > 0)
        {
          return Title;
        }

        return String.Format("Volume {0}", Vol);
      }
    }
    public string FullTitle
    {
      get
      {
        string fullTitle = Author.Inits;

        if (Author == Author.ScriptureAuthor)
        {
          fullTitle = String.Format("Good Teaching by Scripture {0:00} - {1}", Vol, Title);
        }
        else if (Author == Author.CollectionAuthor)
        {
          fullTitle = String.Format("Good Teaching Collection #{0} - {1}", Vol, Title);
        }
        else if (Title.Length > 0)
        {
          fullTitle = String.Format("{0} {1}", fullTitle, Title);
        }
        else
        {
          fullTitle = String.Format("{0} Volume {1}", fullTitle, Vol);
        }

        return fullTitle;
      }
    }
    public string FullSeries
    {
      get
      {
        if (Author == Author.ScriptureAuthor)
        {
          return "Good Teaching by Scripture";
        }
        else if (Author == Author.CollectionAuthor)
        {
          return "Good Teaching Collection";
        }

        return String.Format("{0} {1}", Author.FullName, Series).Trim();
      }
    }
    public string Tag
    {
      get
      {
        if (Author == Author.ScriptureAuthor)
        {
          return "goodteachingbyscripture";
        }
        else if (Author == Author.CollectionAuthor)
        {
          return "goodteachingcollection";
        }

        return Author.Inits.ToLower();
      }
    }
    public string Filename
    {
      get
      {
        if (Author == Author.ScriptureAuthor)
        {
          return String.Format("gtscripture_{0:00}", Vol);
        }
        return String.Format("{0}_{1:000}", Author.Inits.ToLower(), Vol);
      }
    }
    public string Series
    {
      get
      {
        if (Author.Inits.Equals("JT"))
        {
          return "New Series";
        }

        return "";
      }
    }
    public DateTime Added
    {
      get
      {
        return _added;
      }
      set
      {
        _added = value;
      }
    }
    public string LocalFile
    {
      get
      {
        return _localFile;
      }
      set
      {
        _localFile = value.Replace("\\\\", "\\");
      }
    }

    public Volume(Author author, int vol)
    {
      _author = author;
      _vol = vol;
    }

    public FileInfo GetFile()
    {
      if (_localFile == null) return null;

      return new FileInfo(_localFile);
    }

    public static string GetId(string author, int vol)
    {
      return String.Format("{0}-{1:000}", author, vol);
    }
  }

  public class VolumeCollection : KeyedCollection<string, Volume>
  {
    public VolumeCollection()
      : base()
    {
    }

    protected override string GetKeyForItem(Volume vol)
    {
      return vol.Id;
    }
  }
}