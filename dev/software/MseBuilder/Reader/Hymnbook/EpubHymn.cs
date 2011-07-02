/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubHymn.cs 1314 2011-01-04 01:59:30Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Added all hymn attributes.
 * CAM  03-Jan-2011  10918 : Use new classes to format hymn page.
 * CAM  03-Jan-2011  10920 : Property for the first line of each hymn.
 * CAM  04-Jan-2011  10919 : Pass all properties to authors and meters to enable links back to TOC.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Text;
using System.IO;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubHymn : EpubFile, IEpubGenerator
  {
    private long _hymnNo;
    private long _meterId;
    private string _meter;
    private long _authorId;
    private string _author;
    private string _authorLife;
    private string _firstLine;
    private EpubItemCollection _items;

    public long HymnNo
    {
      get { return _hymnNo; }
      set { _hymnNo = value; }
    }
    public string ShortHymnNo
    {
      get { return String.Format("#{0}", HymnNo); }
    }
    public string TocText
    {
      get
      {
        string rval = String.Format("{0} - {1}", HymnNo, FirstLine);

        if (rval.EndsWith(".")) rval = rval.Substring(0, rval.Length - 1);
        if (rval.EndsWith(",")) rval = rval.Substring(0, rval.Length - 1);
        if (rval.EndsWith(";")) rval = rval.Substring(0, rval.Length - 1);

        return rval;
      }
    }
    public long MeterId
    {
      get { return _meterId; }
      set { _meterId = value; }
    }
    public string Meter
    {
      get { return _meter; }
      set { _meter = value; }
    }
    public long AuthorId
    {
      get { return _authorId; }
      set { _authorId = value; }
    }
    public string Author
    {
      get { return _author; }
      set { _author = value; }
    }
    public string AuthorLife
    {
      get { return _authorLife; }
      set { _authorLife = value; }
    }
    public string FirstLine
    {
      get { return _firstLine; }
      set { _firstLine = value; }
    }

    public string QualifiedId
    {
      get { return String.Format("{0}-{1:000}", Document.LanguageCode, HymnNo); }
    }
    public FileInfo XmlFile
    {
      get { return new FileInfo(String.Format(@"{0}\{1}.html", Document.OpsDir.FullName, QualifiedId)); }
    }
    public EpubItemCollection Items
    {
      get { return _items; }
    }

    public EpubHymn(EpubHymnbookDocument doc, long hymnNo)
      : this(doc, hymnNo, 0, String.Empty, 0, String.Empty)
    {
    }

    public EpubHymn(EpubHymnbookDocument doc, long hymnNo, long meterId, string meter, long authorId, string author)
      : base(doc)
    {
      HymnNo = hymnNo;
      MeterId = meterId;
      AuthorId = authorId;
      Author = author;

      _items = new EpubItemCollection();
    }

    public virtual void GenerateEpub()
    {
    }

    public virtual void SaveFile()
    {
      using (StreamWriter writer = new StreamWriter(XmlFile.FullName))
      {
        EpubHymnHeader header = new EpubHymnHeader(Document, HymnNo, MeterId, Meter);
        EpubHymnAuthor author = new EpubHymnAuthor(Document, AuthorId, Author, AuthorLife);

        WriteHeader(writer);

        writer.WriteLine(header.RenderToXhtml());

        writer.WriteLine("    <ol>");

        foreach (EpubItem item in Items)
        {
          writer.WriteLine(item.RenderToXhtml());
        }

        writer.WriteLine("    </ol>");

        writer.WriteLine(author.RenderToXhtml());

        WriteFooter(writer);
      }
    }

    public void WriteHeader(StreamWriter writer)
    {
      writer.WriteLine(@"<?xml version=""1.0"" encoding=""UTF-8""?>");
      writer.WriteLine(@"<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.1//EN"" ""http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"">");
      writer.WriteLine(@"<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""en"">");
      writer.WriteLine(@"  <head>");
      writer.WriteLine(@"    <title>" + Document.HymnBookTitle + " - " + ShortHymnNo + "</title>");
      writer.WriteLine(@"    <link rel=""stylesheet"" href=""css/epub-hymn.css"" type=""text/css""/>");
      writer.WriteLine(@"    <meta http-equiv=""Content-Type"" content=""application/xhtml+xml; charset=utf-8""/>");
      writer.WriteLine(@"    <meta name=""EPB-UUID"" content=""" + Document.BookId + @"""/>");
      writer.WriteLine(@"  </head>");
      writer.WriteLine(@"  <body>");
    }

    public void WriteFooter(StreamWriter writer)
    {
      writer.WriteLine(@"  </body>");
      writer.WriteLine(@"</html>");
    }
  }
}
