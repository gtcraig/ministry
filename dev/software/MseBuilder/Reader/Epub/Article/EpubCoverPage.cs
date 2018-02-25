/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2015 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  31-May-2015  998637 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System.IO;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubCoverPage : EpubArticle
  {
    public EpubCoverPage(long id, EpubDocument doc)
      : base(id, doc)
    {
      Title = doc.Volume.FullTitle + " Cover page";
    }

    public override void SaveFile()
    {
      using (StreamWriter writer = new StreamWriter(XmlFile.FullName))
      {
        WriteHeader(writer, Title);

        writer.WriteLine("<div>");
        writer.WriteLine("  <svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" " +
          "version=\"1.1\" width=\"100%\" height=\"100%\" viewBox=\"0 0 600 800\" preserveAspectRatio=\"xMidYMid meet\">");
        writer.WriteLine("      <image width=\"600\" height=\"800\" xlink:href=\"img/cover-" + Document.CoverImage.Name + "\"/>");
        writer.WriteLine("  </svg>");
        writer.WriteLine("</div>");

        WriteFooter(writer);
      }
    }
  }
}
