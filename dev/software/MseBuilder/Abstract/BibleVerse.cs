/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008,2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BibleVerse.cs 1110 2009-12-30 13:44:04Z craig $
 *
 * Who  When         Why
 * CAM  15-Jun-2008  10409 : File created.
 * CAM  04-Apr-2009  10414 : Moved CrossReference here.
 * CAM  29-Dec-2009  10516 : Remove Hrefs with basic MseLinks (until #10517 is defined and completed).
 * CAM  29-Dec-2009  10521 : Don't abort if an Xref cannot be found.  Needs to be fixed - #10517.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  /// <summary>
  /// Representation of a Bible Verse.
  /// </summary>
  public class BibleVerse : Collection<BibleXref>, IEquatable<BibleVerse>
  {
    private const string AnchorStartOpen = "<A HREF=\"";
    private const string AnchorScriptureStartOpen = "/cgi-bin/br/BDB/";
    private const string AnchorFootnoteStartOpen = "/cgi-bin/dr/";
    private const string AnchorStartClose = "\">";
    private const string AnchorEnd = "</A>";

    private const string MseLinkStartClose = "]";
    private const string MseLinkScriptureStart = "[scripture ";
    private const string MseLinkScriptureEnd = "[/scripture]";
    private const string MseLinkFootnoteStart = "[footnote ";
    private const string MseLinkFootnoteEnd = "[/footnote]";

    private BibleBook _book;
    private string _shortCode;
    private int _chapter;
    private int _verse;
    private string _text;

    public BibleBook Book
    {
      get
      {
        return _book;
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
    public virtual string FullId
    {
      get
      {
        return String.Format("{0}?n={1}", _book.ShortCode, this._shortCode);
      }
    }
    public int Chapter
    {
      get
      {
        return _chapter;
      }
    }
    public int Verse
    {
      get
      {
        return _verse;
      }
    }
    public string Text
    {
      get
      {
        return _text;
      }
      set
      {
        _text = value.Replace("&amp;", "&");
      }
    }

    public BibleVerse(BibleBook book, string shortCode, string text)
    {
      _book = book;
      _shortCode = shortCode;

      int colon = shortCode.IndexOf(":");
      if (colon > 0)
      {
        _chapter = int.Parse(shortCode.Substring(0, colon).Trim());

        shortCode = shortCode.Substring(colon + 1, shortCode.Length - colon - 1).Trim();
        string verse = "";
        for (int i = 0; i < shortCode.Length; i++)
        {
          if (shortCode[i] >= 48 && shortCode[i] <= 57)
          {
            verse += shortCode[i];
          }
        }
        _verse = int.Parse(verse);
      }

      Text = text;
    }

    public bool CrossReference()
    {
      int p;
      int p2;
      string text;
      string rf;
      string word;
      string newLine;
      BibleXref xref;
      BibleVerse verse = this;
      XrefType xrefType;

      text = verse.Text;
      rf = word = newLine = "";

      while ((p = text.IndexOf(AnchorStartOpen)) >= 0)
      {
        newLine += text.Substring(0, p);

        if (text.Substring(p + AnchorStartOpen.Length, text.Length - p - AnchorStartOpen.Length).StartsWith(AnchorScriptureStartOpen))
        {
          xrefType = XrefType.FootnoteToVerse;
          newLine += MseLinkScriptureStart + "id=\"";  // TODO [#10517] Change id and value to convention
          text = text.Substring(p + AnchorStartOpen.Length + AnchorScriptureStartOpen.Length, text.Length - p - AnchorStartOpen.Length - AnchorScriptureStartOpen.Length);
        }
        else
        {
          xrefType = XrefType.FootnoteToFootnote;
          newLine += MseLinkFootnoteStart + "id=\""; // TODO [#10517] Change id and value to convention
          text = text.Substring(p + AnchorStartOpen.Length + AnchorFootnoteStartOpen.Length, text.Length - p - AnchorStartOpen.Length - AnchorFootnoteStartOpen.Length);
        }

        if ((p = text.IndexOf(AnchorStartClose)) >= 0)
        {
          rf = text.Substring(0, p);
          newLine += rf + "\"" + MseLinkStartClose; // TODO [#10517] Quotation end should be handled in line with convention

          if ((p2 = text.IndexOf(AnchorEnd)) >= 0)
          {
            word = text.Substring(p + AnchorStartClose.Length, p2 - p - AnchorStartClose.Length).Trim();
            newLine += word;
            if (xrefType == XrefType.FootnoteToVerse)
            {
              newLine += MseLinkScriptureEnd;
            }
            else
            {
              newLine += MseLinkFootnoteEnd;
            }

            text = text.Substring(p2 + AnchorEnd.Length, text.Length - p2 - AnchorEnd.Length);
          }
          else
          {
            text = text.Substring(p + AnchorStartClose.Length, text.Length - p - AnchorStartClose.Length);
          }
        }

        if (newLine.Length > 0)
        {
          xref = new BibleXref(verse, xrefType, rf, word);
          if (!xref.AddXref(Book.Version))
          {
            // TODO [#10517] Determine what ~a=1 means after ref - this is causing a failure to find the xref
            //return false;
          }
          verse.Text = newLine + text;
        }
      }

      return true;
    }

    protected override void InsertItem(int index, BibleXref item)
    {
      base.InsertItem(index, item);
      item.InstanceId = this.Count;
    }

    public virtual bool Equals(BibleVerse other)
    {
      if (other == null) return false;
      if (_book.BookId.Equals(other._book.BookId) &&
        _chapter.Equals(other._chapter) &&
        _verse.Equals(other._verse)) return true;
      return false;
    }
  }

  public class BibleVerseCollection : KeyedCollection<string, BibleVerse>
  {
    private BibleBook _book;

    public BibleVerseCollection(BibleBook book)
      : base()
    {
      _book = book;
    }

    protected override string GetKeyForItem(BibleVerse item)
    {
      return item.ShortCode;
    }

    protected override void InsertItem(int index, BibleVerse item)
    {
      base.InsertItem(index, item);
      _book.Elements.Add(item);
    }
  }

  public class BibleElementsCollection : KeyedCollection<string, BibleVerse>
  {
    public BibleElementsCollection()
      : base()
    {
    }

    protected override string GetKeyForItem(BibleVerse item)
    {
      return item.FullId;
    }
  }
}
