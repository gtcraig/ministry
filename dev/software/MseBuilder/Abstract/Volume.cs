/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  12-May-2008  10265 : Added IsFullMarkup.
 * CAM  15-Jan-2010  10528 : Added Series and Title options.
 * CAM  15-Jan-2010  10529 : Converted Volume.Author from string to Author class.
 * CAM  15-Jan-2010  10529 : Missed a reference to Author.
 * CAM  18-Jan-2010  10539 : Include volume number prefix in title (for sorting in Calibre).
 * CAM  19-Jan-2010  10540 : Series is no longer require - based on logic.
 * CAM  24-Dec-2010  10902 : Smarter volume titles.
 * CAM  28-Dec-2011  gc005 : Removed redundant code.
 * CAM  29-Dec-2011  gc006 : Removed volume number from VolumeTitle.
 * CAM  29-Dec-2011  gc009 : Removed volume number from FullTitle for StandardEpub.
 * CAM  31-Dec-2015  886930 : Removed ancient SonyEpub references - no longer required.
 * CAM  22-Feb-2018  732482 : Ignore 'Author Name' for CollectionAuthor.
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