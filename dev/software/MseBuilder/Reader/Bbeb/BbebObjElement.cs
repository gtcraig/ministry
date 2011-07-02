/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebObjElement.cs 1121 2010-01-15 22:56:23Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10533 : Moved AppendAttribute method to BbebElement.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public abstract class BbebObjElement : BbebElement
  {
    private int _objId;

    public int ObjId
    {
      get { return _objId; }
      set { _objId = value; }
    }

    protected BbebObjElement(BbebDocument doc, string name)
      : base(doc, name)
    {
      ObjId = BbebUtil.Instance.NextObjId();
    }

    public override void GenerateBbeb()
    {
      XmlAttribute attribute = OwnerDocument.CreateAttribute("objid");
      attribute.Value = ObjId.ToString().Trim();
      Attributes.Append(attribute);
    }
  }
}
