/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebTitlePage.cs 1121 2010-01-15 22:56:23Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10529 : Converted Volume.Author from string to Author class.
 * CAM  15-Jan-2010  10531 : Title in bold.
 * CAM  15-Jan-2010  10532 : Use VolumeTitle as intended.
 * CAM  15-Jan-2010  10533 : Added ImageBlock.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Text;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebTitlePage : BbebPage
  {
    public BbebTitlePage(BbebDocument doc, BbebPageStyle pageStyle)
      : base(doc, pageStyle)
    {
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      BbebDocument doc = (BbebDocument)OwnerDocument;

      BbebTextBlock text = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.CoverTitleLarge]);
      text.AddNewline(2);
      text.AddBoldTitle(doc.Volume.Author.Name);
      AppendChild(text);
      text.GenerateBbeb();

      text = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.CoverTitleMedium]);
      AppendChild(text);
      text.AddTitle(doc.Volume.VolumeTitle);
      text.GenerateBbeb();

      text = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.CoverTitleMedium]);
      if (doc.Volume.Series.Length > 0)
      {
        text.AddBoldTitle(doc.Volume.Series);
      }
      text.AddNewline();
      AppendChild(text);
      text.GenerateBbeb();

      BbebImageBlock imageBlockAuthor = new BbebImageBlock(doc, doc.BlockStyle, doc.ImageStreamAuthor);
      imageBlockAuthor.GenerateBbeb();
      AppendChild(imageBlockAuthor);

      text = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.CoverTitleSmall]);
      text.AddNewline();
      text.AddParagraph("Produced from GoodTeaching.org", true);
      text.AddParagraph(String.Format("on {0:d-MMM-yyyy}", DateTime.Now), false);
      AppendChild(text);
      text.GenerateBbeb();
    }
  }
}
