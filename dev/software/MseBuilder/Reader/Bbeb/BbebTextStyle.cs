/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebTextStyle.cs 1121 2010-01-15 22:56:23Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10531 : Added ArticleScriptures and BbebFont/s.
 * CAM  15-Jan-2010  10533 : Increased size of the medium title slightly.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public enum TextPurpose
  {
    CoverTitleLarge,
    CoverTitleMedium,
    CoverTitleSmall,
    ArticleTitle,
    ArticleScriptures,
    ArticleText
  }

  public enum TextPosition
  {
    LeftAligned,
    Centred
  }

  public enum BbebFont
  {
    Roman,
    Swiss,
    Courier
  }

  public class BbebFonts
  {
    public static string GetFont(BbebFont font)
    {
      switch (font)
      {
        case BbebFont.Courier:
          return "Courier10 BT Roman";
        case BbebFont.Swiss:
          return "Swis721 BT Roman";
      }
      return "Dutch801 Rm BT Roman";
    }
  }

  public class BbebTextStyle : BbebStyle
  {
    private TextPurpose _textPurpose;
    private int _fontSize;
    private TextPosition _textPosition;
    private BbebFont _font;

    public TextPurpose TextPurpose
    {
      get { return _textPurpose; }
      set { _textPurpose = value; }
    }
    public int FontSize
    {
      get { return _fontSize; }
      set { _fontSize = value; }
    }
    public TextPosition TextPosition
    {
      get { return _textPosition; }
      set { _textPosition = value; }
    }
    public BbebFont Font
    {
      get { return _font; }
      set { _font = value; }
    }

    public BbebTextStyle(BbebDocument doc, TextPurpose textPurpose, int fontSize, TextPosition textPosition, BbebFont font)
      : base(doc, "TextStyle")
    {
      TextPurpose = textPurpose;
      FontSize = fontSize;
      TextPosition = textPosition;
      Font = font;
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      AppendAttribute("fontsize", FontSize);
      AppendAttribute("fontwidth", -10);
      AppendAttribute("fontescapement", 0);
      AppendAttribute("fontorientation", 0);
      AppendAttribute("fontweight", 400);
      AppendAttribute("fontfacename", BbebFonts.GetFont(Font));
      AppendAttribute("textcolor", "0x00000000");
      AppendAttribute("textbgcolor", "0xff000000");
      AppendAttribute("wordspace", 25);
      AppendAttribute("letterspace", 0);
      AppendAttribute("baselineskip", 140);
      AppendAttribute("linespace", 10);
      AppendAttribute("parskip", 0);
      AppendAttribute("parindent", 0);
      AppendAttribute("textlinewidth", 2);
      AppendAttribute("linecolor", "0x00000000");
      AppendAttribute("rubyoverhang", "none");
      AppendAttribute("empdotsposition", "before");
      AppendAttribute("emplineposition", "before");
      AppendAttribute("emplinetype", "none");

      if (TextPosition == TextPosition.Centred)
      {
        AppendAttribute("align", "center");
      }
      else
      {
        AppendAttribute("align", "head");
      }

      AppendAttribute("column", 1);
      AppendAttribute("columnsep", 0);
    }
  }

  public class BbebTextStyleCollection : KeyedCollection<TextPurpose, BbebTextStyle>, IBbebGenerator
  {
    public BbebTextStyleCollection(BbebDocument doc)
      : base()
    {
      Add(new BbebTextStyle(doc, TextPurpose.CoverTitleLarge, 140, TextPosition.Centred, BbebFont.Swiss));
      Add(new BbebTextStyle(doc, TextPurpose.CoverTitleMedium, 100, TextPosition.Centred, BbebFont.Swiss));
      Add(new BbebTextStyle(doc, TextPurpose.CoverTitleSmall, 60, TextPosition.Centred, BbebFont.Swiss));
      Add(new BbebTextStyle(doc, TextPurpose.ArticleTitle, 140, TextPosition.LeftAligned, BbebFont.Swiss));
      Add(new BbebTextStyle(doc, TextPurpose.ArticleScriptures, 100, TextPosition.LeftAligned, BbebFont.Swiss));
      Add(new BbebTextStyle(doc, TextPurpose.ArticleText, 100, TextPosition.LeftAligned, BbebFont.Roman));
    }

    public void GenerateBbeb()
    {
      foreach (BbebTextStyle textStyle in this)
      {
        textStyle.GenerateBbeb();
      }
    }

    protected override TextPurpose GetKeyForItem(BbebTextStyle item)
    {
      return item.TextPurpose;
    }
  }
}
