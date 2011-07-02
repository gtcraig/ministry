/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebBlockStyle.cs 1116 2010-01-15 17:19:25Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebBlockStyle : BbebStyle
  {
    public BbebBlockStyle(BbebDocument doc)
      : base(doc, "BlockStyle")
    {
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      AppendAttribute("framemode", "square");
      AppendAttribute("blockwidth", 600);
      AppendAttribute("blockheight", 800);
      AppendAttribute("blockrule", "horz-adjustable");
      AppendAttribute("bgcolor", "0xff000000");
      AppendAttribute("layout", "LrTb");
      AppendAttribute("framewidth", 0);
      AppendAttribute("framecolor", "0x00000000");
      AppendAttribute("topskip", 0);
      AppendAttribute("sidemargin", 0);
    }
  }
}
