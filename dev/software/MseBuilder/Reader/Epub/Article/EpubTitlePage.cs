/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubTitlePage.cs 1343 2011-04-21 19:32:32Z craig $
 *
 * Who  When         Why
 * CAM  21-Jan-2010  10546 : File created.
 * CAM  11-Feb-2010  10559 : Passed author name as alt tag.
 * CAM  24-Dec-2010  10902 : Improved OO design to allow better extendability.
 * CAM  31-May-2015  998637 : Removed name 'by Craig McKay' from Title page.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Text;
using System.IO;

using FrontBurner.Ministry.MseBuilder.Engine;
using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubTitlePage : EpubArticle
  {
    public EpubTitlePage(long id, EpubDocument doc)
      : base(id, doc)
    {
      Title = doc.Volume.FullTitle;
    }

    public override void SaveFile()
    {
      using (StreamWriter writer = new StreamWriter(XmlFile.FullName))
      {
        EpubHeading author = new EpubHeading(Document.Volume.Author.FullName, "frontauthor");
        EpubHeading title = new EpubHeading(Document.Volume.VolumeTitle, "fronttitle");
        EpubHeading source = new EpubHeading(
          String.Format("Produced from GoodTeaching.org<br />on {0:d-MMM-yyyy}", DateTime.Now), "frontpublisher");
        EpubImage image = new EpubImage(Document.Volume.Author.ImageFilename, Document.Volume.Author.Name);

        WriteHeader(writer, Title);

        if (Document.Volume.Author != Author.ScriptureAuthor)
        {
          writer.WriteLine(author.RenderToXhtml());
        }
        writer.WriteLine(title.RenderToXhtml());

        if (Document.Volume.Author.Inits.Equals("JT"))
        {
          EpubHeading series = new EpubHeading("New Series", "frontseries");
          writer.WriteLine(series.RenderToXhtml());
        }

        writer.WriteLine(image.RenderToXhtml());
        writer.WriteLine(source.RenderToXhtml());

        WriteFooter(writer);
      }
    }
  }
}
