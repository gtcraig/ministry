/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubNcx.cs 1312 2011-01-03 23:44:28Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Class renames to make Hymn EPUB more obviously separate.  Ensure Indices file is included in NCX.
 * CAM  03-Jan-2011  10920 : Use new TocText when creating index.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubNcx : EpubXmlFile, IEpubTocGenerator
  {
    protected static readonly string XmlnsNcx = "http://www.daisy.org/z3986/2005/ncx/";

    private XmlElement _head;
    private XmlElement _navMap;

    public override string XmlFilename { get { return "hymns.ncx"; } }
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

    public EpubNcx(EpubHymnbookDocument doc, DirectoryInfo dir)
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
      text.AppendChild(CreateTextNode(Doc.HymnBookTitle));

      XmlElement docAuthor = AppendElement(Root, "docAuthor");
      text = AppendElement(docAuthor, "text");
      text.AppendChild(CreateTextNode(Doc.HymnBookAuthor));

      _navMap = AppendElement(Root, "navMap");
    }

    public void GenerateToc()
    {
      int id = 1;
      XmlElement navPoint = null;
      XmlElement navLabel = null;
      XmlElement content = null;

      // Always includes the TOC (indices) document at the beginning of the NCX
      navPoint = AppendElement(NavMap, "navPoint");
      AppendAttribute(navPoint, "id", String.Format("navpoint-{0}", id));
      AppendAttribute(navPoint, "playOrder", String.Format("{0}", id));

      navLabel = AppendElement(navPoint, "navLabel");
      AppendElement(navLabel, "text", "INDICES by Hymn, Author, Meter and Category");

      content = AppendElement(navPoint, "content");
      AppendAttribute(content, "src", Doc.Toc.XmlFile.Name);

      foreach (EpubHymn hymn in Doc.Hymns)
      {
        navPoint = AppendElement(NavMap, "navPoint");
        AppendAttribute(navPoint, "id", String.Format("navpoint-{0}", id));
        AppendAttribute(navPoint, "playOrder", String.Format("{0}", id));

        navLabel = AppendElement(navPoint, "navLabel");
        AppendElement(navLabel, "text", hymn.TocText);

        content = AppendElement(navPoint, "content");
        AppendAttribute(content, "src", hymn.XmlFile.Name);

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