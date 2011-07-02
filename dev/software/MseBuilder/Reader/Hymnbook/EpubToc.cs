/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubToc.cs 1314 2011-01-04 01:59:30Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Class renames to make Hymn EPUB more obviously separate.
 * CAM  03-Jan-2011  10918 : Build index by Hymn Number.
 * CAM  04-Jan-2011  10919 : Expand TOC with Authors and Meters.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
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
      get { return String.Format("{0}-toc", Document.LanguageCode); }
    }
    public FileInfo XmlFile
    {
      get { return new FileInfo(String.Format(@"{0}\{1}.html", Document.OpsDir.FullName, QualifiedId)); }
    }

    public EpubToc(EpubHymnbookDocument doc, DirectoryInfo dir)
      : base(doc)
    {
      Dir = dir;
    }

    public void GenerateToc()
    {
    }

    protected void WriteHymnsByNumber(StreamWriter writer)
    {
      EpubHeading heading = new EpubHeading("Hymns by Number", "tocheading", "by-hymn");

      writer.WriteLine(heading.RenderToXhtml());
      writer.WriteLine(@"    <ul>");

      string line = String.Empty;
      int counter = 0;

      foreach (EpubHymn article in Document.Hymns)
      {
        if ((counter % 5) == 0 && line != String.Empty)
        {
          writer.WriteLine("      <li class=\"toc\">" + line + "</li>");
          line = String.Empty;
        }

        line += "<a href=\"" + article.XmlFile.Name + "\">" + article.ShortHymnNo + "</a>&nbsp;";
        counter++;
      }

      writer.WriteLine("      <li class=\"toc\">" + line + "</li>");
      writer.WriteLine(@"    </ul>");
    }

    protected void WriteHymnsByAuthor(StreamWriter writer)
    {
      EpubHeading heading = new EpubHeading("Hymns by Author", "tocheading", "by-author");

      writer.WriteLine(heading.RenderToXhtml());
      writer.WriteLine(@"    <dl>");

      string line = String.Empty;
      long currAuthor = 0;
      long prevAuthor = 0;
      EpubHymn hymn;

      foreach (DataRow ar in DatabaseLayer.Instance.GetHymnAuthors(Document.Language).Rows)
      {
        currAuthor = long.Parse(ar["id"].ToString());

        if (currAuthor != prevAuthor)
        {
          if (prevAuthor > 0)
          {
            writer.WriteLine("      </dd>");
          }
          line = String.Format("      <dt class=\"toc\"><a name=\"author-{0}\" />{1}", currAuthor, ar["fullname"]);
          if (!ar.IsNull("author_life"))
          {
            string life = ar["author_life"].ToString();
            if (life.Length > 0)            line = String.Format("{0} {1}", line, life);
          }
          line += "</dt>";
          writer.WriteLine(line);

          writer.WriteLine("      <dd>");
        }

        hymn = Document.Hymns[long.Parse(ar["hymn_no"].ToString())];
        writer.WriteLine("<a href=\"" + hymn.XmlFile.Name + "\">" + hymn.ShortHymnNo + "</a>&nbsp;");
        prevAuthor = currAuthor;
      }

      writer.WriteLine("      </dd>");
      writer.WriteLine(@"    </dl>");
    }

    protected void WriteHymnsByMeter(StreamWriter writer)
    {
      EpubHeading heading = new EpubHeading("Hymns by Meter", "tocheading", "by-meter");

      writer.WriteLine(heading.RenderToXhtml());
      writer.WriteLine(@"    <dl>");

      string line = String.Empty;
      long currMeter = 0;
      long prevMeter = 0;
      EpubHymn hymn;

      foreach (DataRow mr in DatabaseLayer.Instance.GetHymnMeters(Document.Language).Rows)
      {
        currMeter = long.Parse(mr["id"].ToString());

        if (currMeter != prevMeter)
        {
          if (prevMeter > 0)
          {
            writer.WriteLine("      </dd>");
          }
          line = String.Format("      <dt class=\"toc\"><a name=\"meter-{0}\" />{1}", currMeter, mr["meter"]);
          if (!mr.IsNull("rhythm"))
          {
            string rhythm = mr["rhythm"].ToString();
            if (rhythm.Length > 0) line = String.Format("{0} {1}", line, rhythm);
          }
          if (!mr.IsNull("chorus"))
          {
            string chorus = mr["chorus"].ToString();
            if (chorus.Length > 0) line = String.Format("{0} {1}", line, chorus);
          }
          line += "</dt>";
          writer.WriteLine(line);

          writer.WriteLine("      <dd>");
        }

        hymn = Document.Hymns[long.Parse(mr["hymn_no"].ToString())];
        writer.WriteLine("<a href=\"" + hymn.XmlFile.Name + "\">" + hymn.ShortHymnNo + "</a>&nbsp;");
        prevMeter = currMeter;
      }

      writer.WriteLine("      </dd>");
      writer.WriteLine(@"    </dl>");
    }

    public virtual void SaveFile()
    {
      using (StreamWriter writer = new StreamWriter(XmlFile.FullName))
      {
        WriteHeader(writer);

        EpubHeading heading = new EpubHeading("INDICES", "tocheading");
        writer.WriteLine(heading.RenderToXhtml());
        writer.WriteLine("    <ul>");
        writer.WriteLine("    <li><a href=\"#by-hymn\">by Hymn Number</a></li>");
        writer.WriteLine("    <li><a href=\"#by-author\">by Author</a></li>");
        writer.WriteLine("    <li><a href=\"#by-meter\">by Meter</a></li>");
        writer.WriteLine("    </ul>");

        WriteHymnsByNumber(writer);
        WriteHymnsByAuthor(writer);
        WriteHymnsByMeter(writer);

        WriteFooter(writer);
      }
    }

    public void WriteHeader(StreamWriter writer)
    {
      writer.WriteLine(@"<?xml version=""1.0"" encoding=""UTF-8""?>");
      writer.WriteLine(@"<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.1//EN"" ""http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"">");
      writer.WriteLine(@"<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""en"">");
      writer.WriteLine(@"  <head>");
      writer.WriteLine(@"    <title>INDICES</title>");
      writer.WriteLine(@"    <link rel=""stylesheet"" href=""css/epub-hymn.css"" type=""text/css""/>");
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