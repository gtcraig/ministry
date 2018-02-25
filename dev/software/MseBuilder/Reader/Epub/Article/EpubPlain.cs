/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2015 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  31-Dec-2015  886930 : File created to enable HTML encoding.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubPlain : EpubItem
  {
    public EpubPlain(string text)
      : base("")
    {
      PlainText = text;
    }

    public override string RenderToXhtml()
    {
      return PlainText;
    }
  }
}
