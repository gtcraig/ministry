/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebElement.cs 1128 2010-01-19 21:51:08Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10532 : Added AppendAttribute by Obj.
 * CAM  15-Jan-2010  10533 : Moved AppendAttribute method from BbebObjElement.
 * CAM  19-Jan-2010  10540 : Correct OO - GenerateBbeb is abstract here.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public abstract class BbebElement : XmlElement, IBbebGenerator
  {
    protected BbebElement(BbebDocument doc, string name)
      : base("", name, "", doc)
    {
    }

    protected void AppendAttribute(string name, BbebObjElement obj)
    {
      AppendAttribute(this, name, obj.ObjId);
    }

    protected void AppendAttribute(string name, int value)
    {
      AppendAttribute(this, name, value);
    }

    protected void AppendAttribute(string name, string value)
    {
      AppendAttribute(this, name, value);
    }

    protected void AppendAttribute(XmlElement element, string name, BbebObjElement objElement)
    {
      AppendAttribute(element, name, objElement.ObjId);
    }

    protected void AppendAttribute(XmlElement element, string name, int value)
    {
      AppendAttribute(element, name, value.ToString().Trim());
    }

    protected void AppendAttribute(XmlElement element, string name, string value)
    {
      XmlAttribute attribute = OwnerDocument.CreateAttribute(name);
      attribute.Value = value;
      element.Attributes.Append(attribute);
    }

    public abstract void GenerateBbeb();
  }
}
