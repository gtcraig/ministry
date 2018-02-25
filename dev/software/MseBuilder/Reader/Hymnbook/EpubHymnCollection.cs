/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubHymnCollection.cs 1310 2011-01-03 16:41:38Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Class renames to make Hymn EPUB more obviously separate.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System.Collections.ObjectModel;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubHymnCollection : KeyedCollection<long, EpubHymn>
  {
    private EpubHymnbookDocument _doc;

    public EpubHymnCollection(EpubHymnbookDocument doc)
      : base()
    {
      _doc = doc;
    }

    protected override long GetKeyForItem(EpubHymn item)
    {
      return item.HymnNo;
    }

    public EpubHymn CreateHymn(long hymnNo)
    {
      EpubHymn hymn = new EpubHymn(_doc, hymnNo);
      Add(hymn);
      return hymn;
    }
  }
}
