/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubHeading.cs 1314 2011-01-04 01:59:30Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  21-Jan-2010  10546 : Added ClassName.
 * CAM  04-Jan-2011  10919 : Added Anchor.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubHeading : EpubItem
  {
    private string _className;
    private string _anchorName;

    public EpubHeading(string text)
      : this(text, "title", String.Empty)
    {
    }

    public EpubHeading(string text, string className)
      : this(text, className, String.Empty)
    {
    }

    public EpubHeading(string text, string className, string anchorName)
      : base(text)
    {
      _className = className;
      _anchorName = anchorName;
    }

    public override string RenderToXhtml()
    {
      string text = Text;
      if (_anchorName.Length > 0)
      {
        text = String.Format("<a name=\"{0}\" />{1}", _anchorName, text);
      }
      return String.Format("    <p class=\"{0}\">{1}</p>", _className, text);
    }
  }
}
