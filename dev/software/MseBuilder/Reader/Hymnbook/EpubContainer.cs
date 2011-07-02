/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubContainer.cs 1310 2011-01-03 16:41:38Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Class renames to make Hymn EPUB more obviously separate.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

//using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub;
//using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubContainer : EpubXmlFile
  {
    public override string XmlFilename { get { return "container.xml"; } }
    public override string RootName { get { return "container"; } }

    public EpubContainer(EpubHymnbookDocument doc, DirectoryInfo dir)
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
