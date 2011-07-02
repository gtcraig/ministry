/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebTocLabel.cs 1120 2010-01-15 21:13:58Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10532 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebTocLabel : BbebElement
  {
    private BbebPage _page;
    private BbebObjElement _obj;
    private string _label;

    public BbebPage Page
    {
      get { return _page; }
      set { _page = value; }
    }
    public BbebObjElement Obj
    {
      get { return _obj; }
      set { _obj = value; }
    }
    public string Label
    {
      get { return _label; }
      set { _label = value; }
    }


    public BbebTocLabel(BbebDocument doc, BbebPage page, BbebObjElement obj, string label)
      : base(doc, "TocLabel")
    {
      _page = page;
      _obj = obj;
      _label = label;
    }

    public override void GenerateBbeb()
    {
      AppendAttribute("refpage", Page);
      AppendAttribute("refobj", Obj);

      AppendChild(OwnerDocument.CreateTextNode(_label));
    }
  }

  public class BbebToc : List<BbebTocLabel>
  {
    public BbebToc()
      : base()
    {
    }
  }
}
