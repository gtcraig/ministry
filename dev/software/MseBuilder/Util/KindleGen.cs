/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2010,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  24-Dec-2010  10902 : File added.
 * CAM  22-Feb-2018  732482 : Delete the final MOBI file if it exists before recreating.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Diagnostics;
using System.IO;

namespace FrontBurner.Ministry.MseBuilder.Util
{
  public class KindleGen
  {
    private static KindleGen _kindlegen;

    private KindleGen()
    {
    }

    public static KindleGen Instance
    {
      get
      {
        if (_kindlegen == null)
        {
          _kindlegen = new KindleGen();
        }
        return _kindlegen;
      }
    }

    public void GenerateMobi(FileInfo opfFile, FileInfo mobiFile)
    {
      Process zip = new Process();

      zip.StartInfo.FileName = @"c:\dev\bin\kindlegen\kindlegen.exe";
      zip.StartInfo.Arguments = String.Format("\"{0}\"", opfFile.FullName);
      zip.StartInfo.WorkingDirectory = opfFile.Directory.FullName;
      zip.Start();
      zip.StartInfo.WindowStyle = ProcessWindowStyle.Minimized;
      zip.WaitForExit();

      string mobiName = String.Format("{0}.mobi", 
        opfFile.FullName.Substring(0, opfFile.FullName.LastIndexOf('.')));

      if (mobiFile.Exists) mobiFile.Delete();
      File.Move(mobiName, mobiFile.FullName);
    }
  }
}
