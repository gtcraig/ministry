/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BibleFootnote.cs 1157 2010-02-13 14:54:18Z craig $
 *
 * Who  When         Why
 * CAM  15-Jun-2008  10409 : File created.
 * CAM  04-Apr-2009  10414 : Override equality.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

using FrontBurner.Ministry.MseBuilder.Engine;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class BibleFootnote : BibleVerse
  {
    private int _footnoteId;
    private char _symbol;
    private BibleFootnoteRefCollection _refs;

    public override string FullId
    {
      get
      {
        return String.Format("n_{0}?n={1}", Book.ShortCode, this.ShortCode);
      }
    }
    public int FoonoteId
    {
      get
      {
        return _footnoteId;
      }
    }
    public char Symbol
    {
      get
      {
        return _symbol;
      }
      set
      {
        _symbol = value;
      }
    }
    public BibleFootnoteRefCollection Refs
    {
      get
      {
        if (_refs == null)
        {
          _refs = new BibleFootnoteRefCollection();
        }
        return _refs;
      }
    }

    public BibleFootnote(BibleBook book, string shortCode, char symbol, string text)
      : base(book, shortCode, text)
    {
      _footnoteId = BusinessLayer.Instance.GetNextFootnoteId();
      _symbol = symbol;
    }

    public override bool Equals(BibleVerse other)
    {
      if (other == null) return false;
      if (!(other is BibleFootnote)) return false;

      BibleFootnote otherFootnote = other as BibleFootnote;
      if (_footnoteId.Equals(otherFootnote._footnoteId)) return true;
      return false;
    }
  }

  public class BibleFootnoteCollection : KeyedCollection<string, BibleFootnote>
  {
    private BibleBook _book;

    public BibleFootnoteCollection(BibleBook book)
      : base()
    {
      _book = book;
    }

    protected override string GetKeyForItem(BibleFootnote item)
    {
      return item.ShortCode;
    }

    protected override void InsertItem(int index, BibleFootnote item)
    {
      base.InsertItem(index, item);
      _book.Elements.Add(item);
    }
  }
}
