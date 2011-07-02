/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubContainer.cs 1286 2010-12-24 22:41:03Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  24-Dec-2010  10902 : Improved OO design to allow better extendability.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public class EpubContainer : EpubXmlFile
  {
    public override string XmlFilename { get { return "container.xml"; } }
    public override string RootName { get { return "container"; } }

    public EpubContainer(EpubDocument doc, DirectoryInfo dir)
      : base(doc, dir)
    {
      GenerateEpub();
    }

    public override void GenerateEpub()
    {
      base.GenerateEpub();

      XmlElement rootfiles;
      XmlElement rootfile;

      AppendAttribute(Root, "xmlns", "urn:oasis:names:tc:opendocument:xmlns:container");
      AppendAttribute(Root, "version", "1.0");

      rootfiles = this.CreateElement("", "rootfiles", "");
      Root.AppendChild(rootfiles);

      rootfile = this.CreateElement("", "rootfile", "");
      rootfiles.AppendChild(rootfile);

      AppendAttribute(rootfile, "full-path", "OPS/" + Doc.Opf.XmlFilename);
      AppendAttribute(rootfile, "media-type", MimeTypes.GetMimeType(MimeType.EpubContainer));
    }


  }
}
