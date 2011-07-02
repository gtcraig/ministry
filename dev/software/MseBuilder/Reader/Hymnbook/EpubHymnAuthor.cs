/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2011 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubHymnAuthor.cs 1314 2011-01-04 01:59:30Z craig $
 *
 * Who  When         Why
 * CAM  03-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10918 : XHTML correction (picked up from iBooks error checking).
 * CAM  04-Jan-2011  10919 : Pass all properties to author to enable links back to TOC.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

using FrontBurner.Ministry.MseBuilder.Engine;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubHymnAuthor : EpubItem
  {
    private EpubHymnbookDocument _doc;
    private string _life;
    private long _authorId;

    public EpubHymnAuthor(EpubHymnbookDocument doc, long authorId, string author, string life)
      : base(author)
    {
      _doc = doc;
      _authorId = authorId;
      _life = life;
    }

    public override string RenderToXhtml()
    {
      string author = Text;

      if (EngineSettings.Instance.Mode == BuildMode.StandardEpub)
      {
        // Standard EPUB can cope with these reverse links back to the TOC... Kindle cannot
        author = String.Format("<a class=\"author\" href=\"{0}#author-{1}\">{2}</a>",
          _doc.Toc.XmlFile.Name, _authorId, author);
      }

      if (_life != String.Empty) author = String.Format("{0}&nbsp;<span class=\"authorlife\">{1}</span>", author, _life);
      return String.Format("    <p class=\"author\">{0}</p>{1}", author, Newline());
    }
  }
}
