/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: IEpubGenerator.cs 1128 2010-01-19 21:51:08Z craig $
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public interface IEpubGenerator
  {
    void GenerateEpub();
    void SaveFile();
  }

  public interface IEpubTocGenerator
  {
    void GenerateToc();
  }
}
