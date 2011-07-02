/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebImageBlock.cs 1128 2010-01-19 21:51:08Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10533 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebImageBlock : BbebObjElement
  {
    private BbebBlockStyle _blockStyle;
    private BbebImageStream _imageStream;

    public BbebBlockStyle BlockStyle
    {
      get { return _blockStyle; }
      set { _blockStyle = value; }
    }
    public BbebImageStream ImageStream
    {
      get { return _imageStream; }
      set { _imageStream = value; }
    }

    public BbebImageBlock(BbebDocument doc, BbebBlockStyle blockStyle, BbebImageStream imageStream)
      : base(doc, "ImageBlock")
    {
      _blockStyle = blockStyle;
      _imageStream = imageStream;
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      int imageWidth = 600;
      int imageHeight = 300;

      AppendAttribute("blockstyle", BlockStyle);
      AppendAttribute("blockwidth", imageWidth);
      AppendAttribute("blockrule", "block-adjustable");
      AppendAttribute("refstream", ImageStream);
      AppendAttribute("ysize", imageHeight);
      AppendAttribute("xsize", imageWidth);
      AppendAttribute("blockheight", imageHeight);
      AppendAttribute("y1", imageHeight);
      AppendAttribute("y0", 0);
      AppendAttribute("x0", 0);
      AppendAttribute("x1", imageWidth);
    }
  }
}
