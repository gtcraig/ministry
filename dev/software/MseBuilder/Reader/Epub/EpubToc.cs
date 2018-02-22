/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  24-Dec-2010  10902 : Improved OO design to allow better extendability.
 * CAM  28-Dec-2011  gc005 : Show Author and Title on Contents.
 * CAM  31-May-2015  998637 : Hide Cover page from TOC.
 * CAM  22-Feb-2018  732482 : Use TocTitle - improved Plain Text.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public class EpubToc : EpubFile, IEpubTocGenerator
  {
    private DirectoryInfo _dir;

    public DirectoryInfo Dir
    {
      get { return _dir; }
      set { _dir = value; }
    }

    public string QualifiedId
    {
      get { return String.Format("{0}-{1:000}-toc", Document.Volume.Author.Inits.ToLower(), Document.Volume.Vol); }
    }
    public FileInfo XmlFile
    {
      get { return new FileInfo(String.Format(@"{0}\{1}.html", Document.OpsDir.FullName, QualifiedId)); }
    }

    public EpubToc(EpubDocument doc, DirectoryInfo dir)
      : base(doc)
    {
      Dir = dir;
    }

    public void GenerateToc()
    {
    }

    public virtual void SaveFile()
    {
      using (StreamWriter writer = new StreamWriter(XmlFile.FullName))
      {
        EpubHeading heading = new EpubHeading(Document.Volume.Title);
        EpubHeading author = new EpubHeading(Document.Volume.Author.FullName, "tocauthor");
        string li;

        WriteHeader(writer, heading.Text);
        writer.WriteLine(author.RenderToXhtml());
        writer.WriteLine(heading.RenderToXhtml());

        writer.WriteLine(@"    <ul>");

        foreach (EpubArticle article in Document.Articles)
        {
          if (!(article is EpubTitlePage) && !(article is EpubCoverPage))
          {
            li = "      <li><a href=\"" + article.XmlFile.Name + "\">" + article.TocTitle + "</a></li>";
            writer.WriteLine(li);
          }
        }

        writer.WriteLine(@"    </ul>");

        WriteFooter(writer);
      }
    }

    public void WriteHeader(StreamWriter writer, string title)
    {
      writer.WriteLine(@"<?xml version=""1.0"" encoding=""UTF-8""?>");
      writer.WriteLine(@"<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.1//EN"" ""http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"">");
      writer.WriteLine(@"<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""en"">");
      writer.WriteLine(@"  <head>");
      writer.WriteLine(@"    <title>" + title + "</title>");
      writer.WriteLine(@"    <link rel=""stylesheet"" href=""css/epub-ministry.css"" type=""text/css""/>");
      writer.WriteLine(@"    <meta http-equiv=""Content-Type"" content=""application/xhtml+xml; charset=utf-8""/>");
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