/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebBookStyle.cs 1116 2010-01-15 17:19:25Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebBookStyle : BbebStyle
  {
    public BbebBookStyle(BbebDocument doc)
      : base(doc, "BookStyle")
    {
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      XmlElement setDefault;
      XmlElement bookSetting;

      setDefault = OwnerDocument.CreateElement("", "SetDefault", "");
      AppendChild(setDefault);

      AppendAttribute(setDefault, "rubyAlignAndAdjust", "2");
      AppendAttribute(setDefault, "rubyoverhang", "none");
      AppendAttribute(setDefault, "empdotsposition", "before");
      AppendAttribute(setDefault, "emplineposition", "after");
      AppendAttribute(setDefault, "setwaitprop", "noreplay");
      AppendAttribute(setDefault, "page_tree_id", BbebUtil.Instance.NextObjId());
      AppendAttribute(setDefault, "emplinetype", "solid");

      bookSetting = OwnerDocument.CreateElement("", "BookSetting", "");
      AppendChild(bookSetting);

      AppendAttribute(bookSetting, "bindingdirection", "Lr");
      AppendAttribute(bookSetting, "dpi", "1600");
      AppendAttribute(bookSetting, "screenwidth", "600");
      AppendAttribute(bookSetting, "screenheight", "800");
      AppendAttribute(bookSetting, "colordepth", "24");
    }
  }
}
