/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BibleVersion.cs 944 2009-04-04 15:50:08Z craig $
 *
 * Who  When         Why
 * CAM  15-Jun-2008  10409 : File added.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  /// <summary>
  /// Representation of a Bible Version.
  /// </summary>
  public class BibleVersion: KeyedCollection<string, BibleBook>
  {
    private int _verId;
    private string _verCode;
    private string _versionName;

    public int VersionId
    {
      get
      {
        return _verId;
      }
      set
      {
        _verId = value;
      }
    }
    public string VersionCode
    {
      get
      {
        return _verCode;
      }
      set
      {
        _verCode = value;
      }
    }
    public string VersionName
    {
      get
      {
        return _versionName;
      }
      set
      {
        _versionName = value;
      }
    }

    public BibleVersion(int verId, string verCode, string versionName)
      : base()
    {
      _verId = verId;
      _verCode = verCode;
      _versionName = versionName;
    }

    protected override string GetKeyForItem(BibleBook item)
    {
      return item.ShortCode;
    }

    protected override void InsertItem(int index, BibleBook item)
    {
      base.InsertItem(index, item);
      item.Version = this;
    }

    public BibleBook FindBookByShortCode(string shortCode)
    {
      if (shortCode.StartsWith("n_"))
      {
        shortCode = shortCode.Substring(2, shortCode.Length - 2);
      }

      foreach (BibleBook book in this.Items)
      {
        if (book.ShortCode.ToLower().Equals(shortCode.ToLower()))
        {
          return book;
        }
      }
      return null;
    }
  }

  public class BibleVersionCollection : KeyedCollection<int, BibleVersion>
  {
    public BibleVersionCollection()
      : base()
    {
    }
    
    protected override int GetKeyForItem(BibleVersion item)
    {
      return item.VersionId;
    }
  }
}
