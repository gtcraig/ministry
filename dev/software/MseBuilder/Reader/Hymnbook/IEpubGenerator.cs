/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: IEpubGenerator.cs 1309 2011-01-02 14:04:37Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
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
