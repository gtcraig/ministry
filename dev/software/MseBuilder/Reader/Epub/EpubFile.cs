/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubFile.cs 1286 2010-12-24 22:41:03Z craig $
 *
 * Who  When         Why
 * CAM  24-Dec-2010  10902 : Improved OO design to allow better extendability.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public class EpubFile 
  {
    private EpubDocument _doc;

    public EpubDocument Document
    {
      get { return _doc; }
      set { _doc = value; }
    }

    public EpubFile(EpubDocument doc)
    {
      Document = doc;
    }
  }
}