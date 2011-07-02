/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubImage.cs 1155 2010-02-11 12:34:31Z craig $
 *
 * Who  When         Why
 * CAM  21-Jan-2010  10546 : File created.
 * CAM  11-Feb-2010  10559 : Added Alt tag.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubImage : EpubItem
  {
    private string _alt;

    public string Alt
    {
      get { return _alt; }
      set { _alt = value; }
    }

    public EpubImage(string src, string alt)
      : base(src)
    {
      Alt = alt;
    }

    public override string RenderToXhtml()
    {
      return String.Format("    <p><img src=\"img/{0}\" alt=\"{1}\" /></p>", Text, Alt);
    }
  }
}
