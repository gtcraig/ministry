/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BibleBook.cs 944 2009-04-04 15:50:08Z craig $
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  28-Mar-2009  10409 : Added BibleVersion.
 * CAM  04-Apr-2009  10413 : Added ToString.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class BibleBook
  {
    protected BibleVersion _version;
    protected int _bookId;
    protected string _bookName;
    protected bool _singleChap;
    protected string _shortCode;
    protected BibleVerseCollection _verses;
    protected BibleFootnoteCollection _footnotes;
    protected BibleElementsCollection _elements;

    public BibleVersion Version
    {
      get
      {
        return _version;
      }
      set
      {
        _version = value;
      }
    }
    public int BookId
    {
      get
      {
        return _bookId;
      }
    }
    public string BookName
    {
      get
      {
        return _bookName;
      }
    }
    public bool SingleChap
    {
      get
      {
        return _singleChap;
      }
      set
      {
        _singleChap = value;
      }
    }
    public string ShortCode
    {
      get
      {
        return _shortCode;
      }
      set
      {
        _shortCode = value;
      }
    }
    public BibleVerseCollection Verses
    {
      get
      {
        if (_verses == null)
        {
          _verses = new BibleVerseCollection(this);
        }
        return _verses;
      }
    }
    public BibleFootnoteCollection Footnotes
    {
      get
      {
        if (_footnotes == null)
        {
          _footnotes = new BibleFootnoteCollection(this);
        }
        return _footnotes;
      }
    }
    public BibleElementsCollection Elements
    {
      get
      {
        if (_elements == null)
        {
          _elements = new BibleElementsCollection();
        }
        return _elements;
      }
    }
    
    public BibleBook(int bookId, string bookName)
      : this(bookId, bookName, false)
    {
    }

    public BibleBook(int bookId, string bookName, int singleChap)
      : this(bookId, bookName, (singleChap == 1))
    {
    }

    public BibleBook(int bookId, string bookName, bool singleChap)
    {
      _bookId = bookId;
      _bookName = bookName;
      _singleChap = singleChap;
    }

    public bool Matches(string text)
    {
      int len = _bookName.Length;
      if (text.Length < len) len = text.Length;

      return _bookName.ToUpper().Equals(text.Substring(0, len).ToUpper());
    }

    public BibleBook AddCopy(BibleVersion version)
    {
      BibleBook book = new BibleBook(_bookId, _bookName, _singleChap);
      version.Add(book);
      return book;
    }

    public override string ToString()
    {
      return BookName;
    }
  }

  public class BibleBookCollection : KeyedCollection<int, BibleBook>
  {

    public BibleBookCollection()
      : base()
    {
    }

    protected override int GetKeyForItem(BibleBook book)
    {
      return book.BookId;
    }

    public BibleBook FindByFullname(string fullName)
    {
      if (fullName.Equals("Psalms"))
      {
        fullName = "Psalm";
      }
      else if (fullName.Equals("Song of Solomon"))
      {
        fullName = "Song of Songs";
      }

      foreach (BibleBook book in this.Items)
      {
        if (book.BookName.ToLower().Equals(fullName.ToLower()))
        {
          return book;
        }
      }
      return null;
    }
  }
}
