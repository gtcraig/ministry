/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BibleFootnoteRef.cs 944 2009-04-04 15:50:08Z craig $
 *
 * Who  When         Why
 * CAM  04-Apr-2009  10413 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class BibleFootnoteRef : BibleVerse
  {
    private BibleFootnote _footnote;
    private long _refId;

    public BibleFootnote Footnote
    {
      get { return _footnote; }
      set { _footnote = value; }
    }
    public long RefId
    {
      get { return _refId; }
      set { _refId = value; }
    }
    public string Phrase
    {
      get { return Text; }
    }

    public BibleFootnoteRef(BibleFootnote footnote, long refId, string shortCode, string phrase)
      : base(footnote.Book, shortCode, phrase)
    {
      _footnote = footnote;
      _refId = refId;
    }
  }

  public class BibleFootnoteRefCollection : KeyedCollection<long, BibleFootnoteRef>
  {
    public BibleFootnoteRefCollection()
      : base()
    {
    }

    protected override long GetKeyForItem(BibleFootnoteRef item)
    {
      return item.RefId;
    }
  }
}
