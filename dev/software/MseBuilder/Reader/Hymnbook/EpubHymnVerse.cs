/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2011 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubHymnVerse.cs 1313 2011-01-03 23:46:04Z craig $
 *
 * Who  When         Why
 * CAM  03-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10918 : Handle MOBI List Items without Paragraphs.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

using FrontBurner.Ministry.MseBuilder.Engine;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public enum VerseType
  {
    Verse,
    Chorus
  }

  public class EpubHymnVerse : EpubItem
  {
    private long _verseNo;
    private VerseType _verseType;

    public long VerseNo
    {
      get { return _verseNo; }
      set
      {
        _verseNo = value;

        _verseType = VerseType.Verse;
        if (_verseNo == 99)
        {
          _verseType = VerseType.Chorus;
        }
      }
    }
    public VerseType VerseType
    {
      get { return _verseType; }
    }

    public EpubHymnVerse(long verseNo)
      : base(String.Empty)
    {
      VerseNo = verseNo;
    }

    public override string RenderToXhtml()
    {
      if (VerseType == VerseType.Chorus)
      {
        return String.Format("        <p class=\"chorus\">{0}</p>{1}", Text, Newline());
      }

      // Standard EPUB (iPad etc)
      return String.Format("        <li value=\"{0}\"><p class=\"verse\">{1}</p></li>{2}", VerseNo, Text, Newline());
    }
  }
}
