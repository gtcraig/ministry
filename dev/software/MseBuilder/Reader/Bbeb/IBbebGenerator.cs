/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: IBbebGenerator.cs 1116 2010-01-15 17:19:25Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public interface IBbebGenerator
  {
    void GenerateBbeb();
  }

  public class BbebGeneratorList : List<IBbebGenerator>, IBbebGenerator
  {
    public BbebGeneratorList()
      : base()
    {
    }

    public void GenerateBbeb()
    {
      foreach (IBbebGenerator generator in this)
      {
        generator.GenerateBbeb();
      }
    }
  }
}
