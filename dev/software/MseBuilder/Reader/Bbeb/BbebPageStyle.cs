/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebPageStyle.cs 1116 2010-01-15 17:19:25Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebPageStyle : BbebStyle
  {
    public BbebPageStyle(BbebDocument doc)
      : base(doc, "PageStyle")
    {
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      AppendAttribute("topmargin", 0);
      AppendAttribute("headheight", 0);
      AppendAttribute("headsep", 0);
      AppendAttribute("oddsidemargin", 0);
      AppendAttribute("textheight", 800);
      AppendAttribute("textwidth", 600);
      AppendAttribute("footspace", 0);
      AppendAttribute("evensidemargin", 0);
      AppendAttribute("footheight", 0);
      AppendAttribute("layout", "LrTb");
      AppendAttribute("pageposition", "any");
      AppendAttribute("setwaitprop", "noreplay");
      AppendAttribute("setemptyview", "show");
    }
  }
}
