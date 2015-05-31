/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubNcx.cs 1286 2010-12-24 22:41:03Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  21-Jan-2010  10542 : Corrected metadata.
 * CAM  23-Jan-2010  10553 : Use PlainText for TOC entries.
 * CAM  11-Feb-2010  10559 : Increment TOC entry id.
 * CAM  24-Dec-2010  10902 : Improved OO design to allow better extendability.
 * CAM  29-Dec-2011  gc005 : Removed Title page from Contents and ensure Title is XmlSafe.
 * CAM  31-May-2015  998637 : Skip Cover page in Index.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public class EpubNcx : EpubXmlFile, IEpubTocGenerator
  {
    protected static readonly string XmlnsNcx = "http://www.daisy.org/z3986/2005/ncx/";

    private XmlElement _head;
    private XmlElement _navMap;

    public override string XmlFilename { get { return "ministry.ncx"; } }
    public override string RootName { get { return "ncx"; } }

    public XmlElement Head
    {
      get { return _head; }
      set { _head = value; }
    }
    public XmlElement NavMap
    {
      get { return _navMap; }
    }

    public EpubNcx(EpubDocument doc, DirectoryInfo dir)
      : base(doc, dir)
    {
      GenerateEpub();
    }

    protected override void AddDocumentType()
    {
      XmlDocumentType docType = CreateDocumentType("ncx", "-//NISO//DTD ncx 2005-1//EN", "http://www.daisy.org/z3986/2005/ncx-2005-1.dtd", "");
      AppendChild(docType);
    }

    public override void GenerateEpub()
    {
      base.GenerateEpub();

      AppendAttribute(Root, "xmlns", XmlnsNcx);
      AppendAttribute(Root, "version", "2005-1");

      _head = AppendElement(Root, "head");

      AddMetaData();

      XmlElement docTitle = AppendElement(Root, "docTitle");
      XmlElement text = AppendElement(docTitle, "text");
      text.AppendChild(CreateTextNode(XmlTitle(Volume.VolumeTitle)));

      XmlElement docAuthor = AppendElement(Root, "docAuthor");
      text = AppendElement(docAuthor, "text");
      text.AppendChild(CreateTextNode(Volume.Author.OrgName));

      _navMap = AppendElement(Root, "navMap");
    }

    public void GenerateToc()
    {
      int id = 1;
      foreach (EpubArticle article in Doc.Articles)
      {
        if (article is EpubCoverPage) continue;
        if (article is EpubTitlePage) continue;

        XmlElement navPoint = AppendElement(NavMap, "navPoint");
        AppendAttribute(navPoint, "id", String.Format("navpoint-{0}", id));
        AppendAttribute(navPoint, "playOrder", String.Format("{0}", id));

        XmlElement navLabel = AppendElement(navPoint, "navLabel");
        AppendElement(navLabel, "text", article.PlainTitle);

        XmlElement content = AppendElement(navPoint, "content");
        AppendAttribute(content, "src", article.XmlFile.Name);

        id++;
      }
    }

    protected void AddMetaData()
    {
      XmlElement element = AppendElement(Head, "meta");
      AppendAttribute(element, "name", "dtb:uid");
      AppendAttribute(element, "content", Doc.BookId);

      element = AppendElement(Head, "meta");
      AppendAttribute(element, "name", "epub-creator");
      AppendAttribute(element, "content", "GoodTeaching.org/Craig McKay");

      element = AppendElement(Head, "meta");
      AppendAttribute(element, "name", "dtb:depth");
      AppendAttribute(element, "content", "1");

      element = AppendElement(Head, "meta");
      AppendAttribute(element, "name", "dtb:totalPageCount");
      AppendAttribute(element, "content", "0");

      element = AppendElement(Head, "meta");
      AppendAttribute(element, "name", "dtb:maxPageNumber");
      AppendAttribute(element, "content", "0");
    }
  }
 }