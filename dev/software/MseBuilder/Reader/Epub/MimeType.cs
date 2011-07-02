/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: MimeType.cs 1128 2010-01-19 21:51:08Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public enum MimeType
  {
    EpubZip,
    EpubContainer,
    Xhtml,
    Css,
    ImagePng,
    Ncx
  }

  public class MimeTypes
  {
    public static readonly string EpubZip = "application/epub+zip";
    public static readonly string EpubContainer = "application/oebps-package+xml";
    public static readonly string Xhtml = "application/xhtml+xml";
    public static readonly string Css = "text/css";
    public static readonly string ImagePng = "image/png";
    public static readonly string Ncx = "application/x-dtbncx+xml";
    public static readonly string Text = "text";

    public static string GetMimeType(MimeType mimeType)
    {
      switch (mimeType)
      {
        case MimeType.EpubZip: return MimeTypes.EpubZip;
        case MimeType.EpubContainer: return MimeTypes.EpubContainer;
        case MimeType.Xhtml: return MimeTypes.Xhtml;
        case MimeType.Css: return MimeTypes.Css;
        case MimeType.ImagePng: return MimeTypes.ImagePng;
        case MimeType.Ncx: return MimeTypes.Ncx;
      }

      return MimeTypes.Text;
    }
  }
}
