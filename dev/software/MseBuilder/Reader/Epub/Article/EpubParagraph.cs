/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubParagraph.cs 1150 2010-01-24 12:32:55Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  23-Jan-2010  10553 : Format footnotes differently.
 * CAM  01-Jan-2013  11153 : Support for SubTitles (lines beginning %).
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubParagraph : EpubItem
  {
    private string _inits;

    public string Inits
    {
      get { return _inits; }
      set { _inits = value; }
    }

    private bool DoesNotRequireParagraphEncoding()
    {
      if (Text.Contains("<ol>") || Text.Contains("</ol>") || Text.Contains("<ul>") || Text.Contains("</ul>") ||
        Text.Contains("<li>") || Text.Contains("</li>") ||
        Text.Contains("<table>") || Text.Contains("<tr>") || Text.Contains("<th>") || Text.Contains("<td>") ||
        Text.Contains("</table>") || Text.Contains("</tr>") || Text.Contains("</th>") || Text.Contains("</td>"))
      {
        return true;
      }
      return false;
    }

    public EpubParagraph(string inits, string text)
      : base(text)
    {
      Inits = inits;
    }

    public EpubParagraph(string text)
      : this("", text)
    {
    }

    public override string RenderToXhtml()
    {
      string initials = "";
      string classId = "";

      if (Paragraph.IsSubTitle(Text))
      {
        return String.Format("    {0}{1}", Text, Newline());
      }
      else if (DoesNotRequireParagraphEncoding())
      {
        return String.Format("    {0}", Text);
      }
      else if (Inits.Length > 0)
      {
        initials = String.Format("<span class=\"init\">{0}</span>&nbsp;", Inits);
      }
      else if (Text.StartsWith("<sup>"))
      {
        // Footnote
        classId = " class=\"footnote\"";
      }

      return String.Format("    <p{3}>{0}{1} </p>{2}", initials, Text, Newline(), classId);
    }
  }
}
