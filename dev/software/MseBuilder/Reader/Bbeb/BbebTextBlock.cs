/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebTextBlock.cs 1124 2010-01-18 12:32:40Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10531 : Added BoldTitle and removed redundant spaces from Scripture refs.
 * CAM  15-Jan-2010  10533 : Ensure AddNewline is inside a paragraph.
 * CAM  18-Jan-2010  10537 : Corrected apostrophe code characters and long dashes.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Text;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebTextBlock: BbebObjElement
  {
    private BbebBlockStyle _blockStyle;
    private BbebTextStyle _textStyle;

    public BbebBlockStyle BlockStyle
    {
      get { return _blockStyle; }
      set { _blockStyle = value; }
    }
    public BbebTextStyle TextStyle
    {
      get { return _textStyle; }
      set { _textStyle = value; }
    }

    public BbebTextBlock(BbebDocument doc, BbebBlockStyle blockStyle, BbebTextStyle textStyle)
      : base(doc, "TextBlock")
    {
      _blockStyle = blockStyle;
      _textStyle = textStyle;
    }

    public void AddTitle(string text)
    {
      AddParagraph(text, false);
    }

    public void AddBoldTitle(string text)
    {
      XmlElement para = CreateParagraph();
      XmlElement bold = CreateBold();
      para.AppendChild(bold);
      bold.AppendChild(CreateText(text));
      AppendChild(para);
    }

    public void AddScriptures(string text)
    {
      XmlElement para = CreateParagraph();
      XmlElement italics = CreateItalics();
      para.AppendChild(italics);

      string scriptures = text.Replace(" - ", "-");
      for (int i = 0; i < 6; i++)
      {
        scriptures = scriptures.Replace("- ", "-");
        scriptures = scriptures.Replace(" -", "-");
      }

      italics.AppendChild(CreateText(scriptures));
      para.AppendChild(CreateNewline());

      AppendChild(para);
    }

    public void AddParagraph(string inits, string text)
    {
      XmlElement para = CreateParagraph();
      XmlElement bold = CreateBold();
      para.AppendChild(bold);
      bold.AppendChild(CreateText(inits + " "));
      para.AppendChild(CreateText(text));

      para.AppendChild(CreateNewline());

      AppendChild(para);
    }

    public void AddParagraph(string text)
    {
      AddParagraph(text, true);
    }

    public void AddParagraph(string text, bool newline)
    {
      XmlElement para = CreateParagraph();
      para.AppendChild(CreateText(text));

      if (newline)
      {
        para.AppendChild(CreateNewline());
      }

      AppendChild(para);
    }

    public void AddNewline()
    {
      AddNewline(1);
    }

    public void AddNewline(int count)
    {
      XmlElement para = CreateParagraph();
      for (int i = 0; i < count; i++)
      {
        para.AppendChild(CreateNewline());
      }
      AppendChild(para);
    }

    protected XmlText CreateText(string text)
    {
      text = text.Replace("@", "");
      text = text.Replace("*", ""); // TODO: make italics work
      text = text.Replace("¬", "'"); // Apostrophes
      text = text.Replace("--", "\u2014");
      return OwnerDocument.CreateTextNode(text);
    }

    protected XmlElement CreateParagraph()
    {
      return OwnerDocument.CreateElement("", "P", "");
    }
    protected XmlElement CreateBold()
    {
      XmlElement bold = OwnerDocument.CreateElement("", "Span", "");
      AppendAttribute(bold, "fontweight", 900);
      return bold;
    }
    protected XmlElement CreateItalics()
    {
      return OwnerDocument.CreateElement("", "Italic", "");
    }
    protected XmlElement CreateNewline()
    {
      return OwnerDocument.CreateElement("", "CR", "");
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      AppendAttribute("blockstyle", BlockStyle);
      AppendAttribute("textstyle", TextStyle);
    }
  }
}
