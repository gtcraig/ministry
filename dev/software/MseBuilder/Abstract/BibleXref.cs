/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008,2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BibleXref.cs 1105 2009-12-29 21:14:28Z craig $
 *
 * Who  When         Why
 * CAM  15-Jun-2008  10409 : File added.
 * CAM  04-Apr-2009  10414 : Determine XrefType here.
 * CAM  29-Dec-2009  10516 : Remove UTF16 characters.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public enum XrefType
  {
    VerseToFootnote = 1,
    FootnoteToVerse = 2,
    FootnoteToFootnote = 3
  }

  public class BibleXref
  {
    #region Member Vars
    private string _xref;
    private string _word;
    private BibleBook _book;
    private string _fullId;
    private XrefType _type;
    private BibleVerse _refTo;
    private BibleVerse _refFrom;
    private int _instanceId;
    #endregion

    #region Properties
    public BibleBook Book
    {
      get
      {
        return _book;
      }
    }
    public string FullId
    {
      get
      {
        return _fullId;
      }
    }
    public XrefType Type
    {
      get
      {
        return _type;
      }
    }
    public string Word
    {
      get
      {
        return _word;
      }
      set
      {
        _word = value.Replace('ù', '~');
      }
    }
    public BibleVerse RefFrom
    {
      get
      {
        return _refFrom;
      }
    }
    public BibleVerse RefTo
    {
      get
      {
        return _refTo;
      }
    }
    public int InstanceId
    {
      get
      {
        return _instanceId;
      }
      set
      {
        _instanceId = value;
      }
    }
    #endregion

    public BibleXref(BibleVerse refFrom, XrefType type, string xref, string word)
    {
      _refFrom = refFrom;
      _type = type;
      _xref = xref;
      Word = word;
    }

    public BibleXref(BibleVerse refFrom, string xref, string word)
    {
      _refFrom = refFrom;
      _xref = xref;
      Word = word;

      if (RefFrom is BibleFootnote)
      {

        if (_xref.Contains("/br/"))
        {
          _type = XrefType.FootnoteToVerse;
        }
        else
        {
          _type = XrefType.FootnoteToFootnote;
        }
      }
      else
      {
        _type = XrefType.VerseToFootnote;
      }
    }

    public bool AddXref(BibleVersion version)
    {
      const string Slash = "/";
      const string FootnotePrefix = "n_";
      const string Separator = "?n=";
      int p;
      string bookCode = _xref;

      if ((p = bookCode.LastIndexOf(Slash)) >= 0)
      {
        bookCode = bookCode.Substring(p + 1, bookCode.Length - p - 1);
      }

      _fullId = bookCode; // Full Id is the Xref without the leading path and script name

      if (bookCode.StartsWith(FootnotePrefix))
      {
        bookCode = bookCode.Substring(FootnotePrefix.Length, bookCode.Length - FootnotePrefix.Length);
      }

      if ((p = bookCode.IndexOf(Separator)) >= 0)
      {
        _book = version.FindBookByShortCode(bookCode.Substring(0, p));
      }

      if (_book == null || _fullId.Length == 0 || _refFrom == null) return false;

      if (!_book.Elements.Contains(_fullId)) return false;
      _refTo = _book.Elements[_fullId];

      //bool alreadyLinked = false;
      //foreach (BibleXref xref in _refTo)
      //{
      //  if (xref._refTo.Equals(_refFrom)) 
      //    alreadyLinked = true;
      //}
      //if (!alreadyLinked) _refTo.Add(this);
      _refTo.Add(this);

      return true;
    }
  }
}