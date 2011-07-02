/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebBookInformation.cs 1121 2010-01-15 22:56:23Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10531 : Remove any periods which Calibre doesn't copy with.
 * CAM  15-Jan-2010  10532 : Added TOC, exposed it publically, and added GenerateToc which must be called after everything else.
 * CAM  15-Jan-2010  10533 : Tidy author names for Calibre/Sony.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Xml;
using System.IO;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebBookInformation : BbebElement
  {
    private string _title;
    private string _author;
    private string _bookId;
    private string _category;
    private FileInfo _thumbnail;
    private string _creator;
    private XmlElement _tocNode;
    private BbebToc _toc;

    public string Title
    {
      get { return _title; }
      set
      {
        _title = value.Replace(".", ""); // Calibre doesn't cope with periods in names;
      }
    }
    public string Author
    {
      get { return _author; }
      set
      {
        _author = value.Replace(".", "").Replace(",", ""); // Calibre doesn't cope with periods in names and commas confuse it too
      }
    }
    public string BookId
    {
      get { return _bookId; }
      set { _bookId = value; }
    }
    public string Category
    {
      get { return _category; }
      set
      {
        _category = value.Replace(",", "");
      }
    }
    public FileInfo Thumbnail
    {
      get { return _thumbnail; }
      set { _thumbnail = value; }
    }
    public string Creator
    {
      get { return _creator; }
      set { _creator = value; }
    }
    public BbebToc Toc
    {
      get { return _toc; }
    }

    public BbebBookInformation(BbebDocument doc)
      : base(doc, "BookInformation")
    {
      Thumbnail = new FileInfo(@"C:\Program Files\Calibre2\eministry.gif");
      _toc = new BbebToc();
    }

    public override void GenerateBbeb()
    {
      XmlElement info;
      XmlElement bookInfo;
      XmlElement docInfo;
      XmlAttribute attribute;

      info = OwnerDocument.CreateElement("", "Info", "");
      AppendChild(info);
      attribute = OwnerDocument.CreateAttribute("version");
      attribute.Value = "1.1";
      info.Attributes.Append(attribute);

      bookInfo = OwnerDocument.CreateElement("", "BookInfo", "");
      info.AppendChild(bookInfo);

      docInfo = OwnerDocument.CreateElement("", "DocInfo", "");
      info.AppendChild(docInfo);

      _tocNode = OwnerDocument.CreateElement("", "TOC", "");
      AppendChild(_tocNode);

      XmlElement title = OwnerDocument.CreateElement("", "Title", "");
      bookInfo.AppendChild(title);
      title.Attributes.Append(OwnerDocument.CreateAttribute("reading"));
      title.AppendChild(OwnerDocument.CreateTextNode(Title));

      XmlElement author = OwnerDocument.CreateElement("", "Author", "");
      bookInfo.AppendChild(author);
      author.Attributes.Append(OwnerDocument.CreateAttribute("reading"));
      author.AppendChild(OwnerDocument.CreateTextNode(Author));

      XmlElement bookId = OwnerDocument.CreateElement("", "BookID", "");
      bookInfo.AppendChild(bookId);
      bookId.AppendChild(OwnerDocument.CreateTextNode(BookId));

      XmlElement category = OwnerDocument.CreateElement("", "Category", "");
      bookInfo.AppendChild(category);
      category.Attributes.Append(OwnerDocument.CreateAttribute("reading"));
      category.AppendChild(OwnerDocument.CreateTextNode(Category));

      XmlElement thumbnail = OwnerDocument.CreateElement("", "CThumbnail", "");
      bookInfo.AppendChild(thumbnail);
      attribute = OwnerDocument.CreateAttribute("file");
      attribute.Value = Thumbnail.Name;
      thumbnail.Attributes.Append(attribute);

      XmlElement creator = OwnerDocument.CreateElement("", "Creator", "");
      bookInfo.AppendChild(creator);
      creator.Attributes.Append(OwnerDocument.CreateAttribute("reading"));
      creator.AppendChild(OwnerDocument.CreateTextNode(Creator));
    }

    public void GenerateToc()
    {
      foreach (BbebTocLabel label in Toc)
      {
        _tocNode.AppendChild(label);
        label.GenerateBbeb();
      }
    }
  }
}
