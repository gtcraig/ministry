/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebStyle.cs 1116 2010-01-15 17:19:25Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebStyle : BbebObjElement
  {
    public BbebStyle(BbebDocument doc, string name)
      : base(doc, name)
    {
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      XmlAttribute attribute = OwnerDocument.CreateAttribute("stylelabel");
      attribute.Value = ObjId.ToString().Trim();
      Attributes.Append(attribute);
    }
  }
}
