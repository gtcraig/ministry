/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebImageStream.cs 1121 2010-01-15 22:56:23Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10533 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebImageStream : BbebObjElement
  {
    private string _filename;

    public string Filename
    {
      get { return _filename; }
      set { _filename = value; }
    }

    public BbebImageStream(BbebDocument doc, string filename)
      : base(doc, "ImageStream")
    {
      _filename = filename;
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      AppendAttribute("encoding", "PNG");
      AppendAttribute("file", Filename);
    }
  }
}
