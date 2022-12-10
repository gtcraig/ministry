/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2011 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubHymnHeader.cs 1314 2011-01-04 01:59:30Z craig $
 *
 * Who  When         Why
 * CAM  03-Jan-2011  10917 : File created.
 * CAM  04-Jan-2011  10919 : Pass all properties to meter to enable links back to TOC.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

using FrontBurner.Ministry.MseBuilder.Engine;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubHymnHeader : EpubItem
  {
    private EpubHymnbookDocument _doc;
    private long _hymnNo;
    private long _meterId;
    private string _meter;

    public EpubHymnHeader(EpubHymnbookDocument doc, long hymnNo, long meterId, string meter)
      : base(meter)
    {
      _doc = doc;
      _hymnNo = hymnNo;
      _meterId = meterId;
      _meter = meter;
    }

    public override string RenderToXhtml()
    {
      string meter = _meter;

      if (EngineSettings.Instance.Mode == BuildMode.StandardEpub)
      {
        // Standard EPUB can cope with these reverse links back to the TOC
        meter = String.Format("<a class=\"meter\" href=\"{0}#meter-{1}\">{2}</a>", _doc.Toc.XmlFile.Name, _meterId, _meter);
      }

      return String.Format("    <p class=\"hymnno\">{0}</p>{1}{2}", _hymnNo, meter, Newline());
    }
  }
}
