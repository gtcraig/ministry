/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubScriptures.cs 1128 2010-01-19 21:51:08Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubScriptures : EpubItem
  {
    public EpubScriptures(string text)
      : base(text)
    {
    }

    public override string RenderToXhtml()
    {
      return String.Format("    <p class=\"scriptures\">{0}</p>{1}", Text, Newline());
    }
  }
}
