/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubOpf.cs 1286 2010-12-24 22:41:03Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  21-Jan-2010  10543 : Added dc:Subject (Tags).
 * CAM  21-Jan-2010  10549 : Use Volume.FullTitle for book title.
 * CAM  11-Feb-2010  10559 : Added Namespace etc to Package tag.
 * CAM  24-Dec-2010  10902 : Improved OO design to allow better extendability.
 * CAM  28-Dec-2011  gc005 : Ensure apostrophes display correctly by using EpubHeading.
 * CAM  29-Dec-2011  gc005 : Titles were not displaying correctly on Apple (&amp;rsquo;).
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Engine;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public class EpubOpf : EpubXmlFile, IEpubTocGenerator
  {
    protected static readonly string XmlnsOpf = "http://www.idpf.org/2007/opf";
    protected static readonly string XmlnsDc = "http://purl.org/dc/elements/1.1/";

    private XmlElement _metaData;
    private XmlElement _manifest;
    private XmlElement _spine;
    private XmlElement _guide;

    public override string XmlFilename { get { return String.Format("{0}-{1:000}.opf", Doc.Volume.Author.Inits.ToLower(), Doc.Volume.Vol); } }
    public override string RootName { get { return "package"; } }

    public XmlElement MetaData
    {
      get { return _metaData; }
    }
    public XmlElement Manifest
    {
      get { return _manifest; }
    }
    public XmlElement Spine
    {
      get { return _spine; }
    }
    protected string CoverId
    {
      get { return string.Format("{0}-{1:000}-cover", Doc.Volume.Author.Inits.ToLower(), Doc.Volume.Vol); }
    }

    public EpubOpf(EpubDocument doc, DirectoryInfo dir)
      : base(doc, dir)
    {
      Doc = doc;

      GenerateEpub();
    }

    public override void GenerateEpub()
    {
      base.GenerateEpub();

      AppendAttribute(Root, "xmlns", XmlnsOpf);
      AppendAttribute(Root, "unique-identifier", "EPB-UUID");
      AppendAttribute(Root, "version", "2.0");

      _metaData = AppendElement(Root, "metadata");
      AppendAttribute(MetaData, "xmlns:opf", XmlnsOpf);
      AppendAttribute(MetaData, "xmlns:dc", XmlnsDc);

      _manifest = AppendElement(Root, "manifest");

      _spine = AppendElement(Root, "spine");
      AppendAttribute(Spine, "toc", "ncx");

      if (EngineSettings.Instance.Mode == BuildMode.KindleMobiEpub)
      {
        _guide = AppendElement(Root, "guide"); // Kindle TOC support
        XmlElement reference = AppendElement(_guide, "reference");
        AppendAttribute(reference, "type", "toc");
        AppendAttribute(reference, "title", "Table of Contents");
        AppendAttribute(reference, "href", Doc.Toc.XmlFile.Name);
      }

      AddMetaData();
      AddSupportFiles();
    }

    public void GenerateToc()
    {
      foreach (EpubArticle article in Doc.Articles)
      {
        AppendSpineItem(article.QualifiedId, article.XmlFile.Name);

        if (article is EpubTitlePage)
        {
          if (EngineSettings.Instance.Mode == BuildMode.KindleMobiEpub)
          {
            // Only add the 'dummy' HTML TOC for Kindle generations
            AppendSpineItem(Doc.Toc.QualifiedId, Doc.Toc.XmlFile.Name);
          }
        }
      }
    }

    protected void AppendSpineItem(string id, string filename)
    {
      XmlElement element = AppendElement(Manifest, "item");
      AppendAttribute(element, "id", id);
      AppendAttribute(element, "href", filename);
      AppendAttribute(element, "media-type", MimeTypes.GetMimeType(MimeType.Xhtml));

      element = AppendElement(Spine, "itemref");
      AppendAttribute(element, "idref", id);
      AppendAttribute(element, "linear", "yes");
    }

    protected string TagSafe(string type)
    {
      return type.Replace(",", "");
    }

    protected string XmlSafeTitle(string title)
    {
      // [#5]
      title = title.Replace("~", "'");
      return title;
    }

    protected void AddMetaData()
    {
      XmlElement element = AppendElement(MetaData, "dc:title", XmlnsDc, XmlSafeTitle(Volume.FullTitle));      

      element = AppendElement(MetaData, "dc:creator", XmlnsDc, Volume.Author.OrgName);
      AppendAttribute(element, "opf:role", XmlnsOpf, "aut");
      AppendAttribute(element, "opf:file-as", XmlnsOpf, Volume.Author.OrgName);

      element = AppendElement(MetaData, "dc:subject", XmlnsDc, TagSafe(Volume.Author.OrgName));
      element = AppendElement(MetaData, "dc:publisher", XmlnsDc, "GoodTeaching.org");

      element = AppendElement(MetaData, "dc:date", XmlnsDc, DateTime.Now.ToString("yyyy-MM-dd"));
      AppendAttribute(element, "opf:event", XmlnsOpf, "epub-publication");

      element = AppendElement(MetaData, "dc:source", XmlnsDc, "GoodTeaching.org");

      element = AppendElement(MetaData, "dc:identifier", XmlnsDc, Doc.QualifiedBookId);
      AppendAttribute(element, "id", "EPB-UUID");

      element = AppendElement(MetaData, "dc:language", XmlnsDc, "en-gb");

      element = AppendElement(MetaData, "meta");
      AppendAttribute(element, "name", "cover");
      AppendAttribute(element, "content", CoverId);
    }

    protected void AddSupportFiles()
    {
      AddManifestFile("main-css", "css/epub-ministry.css", MimeType.Css);
      AddManifestFile("author-photo", String.Format("img/{0}", Volume.Author.ImageFilename), MimeType.ImagePng);
      AddManifestFile("ncx", Doc.Ncx.XmlFilename, MimeType.Ncx);
      AddManifestFile("toc", Doc.Toc.XmlFile.Name, MimeType.Xhtml);
      AddManifestFile(CoverId, String.Format("img/cover-{0}", Volume.Author.ImageFilename), MimeType.ImagePng);
    }

    protected void AddManifestFile(string id, string fileName, MimeType mimeType)
    {
      XmlElement element = AppendElement(Manifest, "item");
      AppendAttribute(element, "id", id);
      AppendAttribute(element, "href", fileName);
      AppendAttribute(element, "media-type", MimeTypes.GetMimeType(mimeType));
    }
  }
}