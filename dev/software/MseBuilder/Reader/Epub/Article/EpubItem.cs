/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubItem.cs 1310 2011-01-03 16:41:38Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  23-Jan-2010  10553 : Ensure valid XHTML.
 * CAM  03-Jan-2011  10917 : Enable repeated setting/concatenation of _text using PlainText and do all conversion on Text.get.
 * CAM  29-Dec-2012  11151 : Correctly output Italics and Double and Single Quotation marks.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;

using FrontBurner.Ministry.MseBuilder.Engine;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public abstract class EpubItem
  {
    private string _text;

    public string Text
    {
      get {
        string rval = _text;

        rval = rval.Replace("&", "&amp;");
        rval = rval.Replace("@", "");

        #region Italics
        if (rval.StartsWith("*")) rval = "<i>" + rval.Substring(1);   // Italics beginning at the start of a line

        rval = rval.Replace(" *", " <i>");
        rval = rval.Replace("\"*", "\"<i>");

        rval = rval.Replace("*", "</i>"); // All others, assume closing
        #endregion

        rval = rval.Replace("~", "&rsquo;"); // Apostrophes
        rval = rval.Replace("--", "&mdash;");

        #region Double Quotation Marks
        if (rval.StartsWith("\"")) rval = "&ldquo;" + rval.Substring(1);   // Italics beginning at the start of a line
        rval = rval.Replace(" \"", " &ldquo;");
        rval = rval.Replace("\"", "&rdquo;");  // All others, assume closing
        #endregion

        #region Single Quotation Marks
        if (rval.StartsWith("'")) rval = "&lsquo;" + rval.Substring(1);   // Italics beginning at the start of a line
        rval = rval.Replace(" '", " &lsquo;");
        rval = rval.Replace("'", "&rsquo;");  // All others, assume closing
        #endregion

        rval = rval.Replace("<br>", "<br />"); // XHTML
        rval = rval.Replace("<hr>", "<hr />"); // XHTML
        rval = rval.Replace("`", ""); // Hymn references

        rval = rval.Replace("¦", "<sup>&dagger;</sup>"); // Footnotes.  TODO: Count the number in the current article

        return rval;
      }
      set
      {
        _text = value;
      }
    }
    public string PlainText
    {
      get
      {
        return _text;
      }
      set
      {
        _text = value;
      }
    }

    protected EpubItem(string text)
    {
      Text = text;
    }

    public abstract string RenderToXhtml();

    public string Newline()
    {
      if (EngineSettings.Instance.Mode == BuildMode.SonyEpub)
      {
        return "<p>&nbsp;</p>";
      }

      return String.Empty;
    }
  }


  public class EpubItemCollection : List<EpubItem>
  {
  }
}
