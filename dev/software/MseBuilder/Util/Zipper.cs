/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: Zipper.cs 1156 2010-02-11 14:12:42Z craig $
 *
 * Who  When         Why
 * CAM  21-Jan-2010  10544 : File created.
 * CAM  11-Feb-2010  10560 : Moved to using zip.exe as something is wrong with the way we are building zipfiles using SharpZipLib.
 * CAM  25-Feb-2018  790063 : Removed all refs to SharpZipLib as per above.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Util
{
  public class Ziplist : List<FileInfo>
  {
    public Ziplist()
      : base()
    {
    }
  }

  public class Zipper
  {
    private static Zipper _zipper;

    private Ziplist _ziplist;

    public Ziplist Ziplist
    {
      get { return _ziplist; }
      set { _ziplist = value; }
    }

    private Zipper()
    {
      Ziplist = new Ziplist();
    }

    public static Zipper Instance
    {
      get
      {
        if (_zipper == null)
        {
          _zipper = new Zipper();
        }
        return _zipper;
      }
    }

    public void ZipDirectory(DirectoryInfo sourceFolder, FileInfo zipfile)
    {
      Process zip = new Process();

      zip.StartInfo.FileName = "zip.exe";
      zip.StartInfo.Arguments = String.Format("-9 -r \"{0}\" {1}", zipfile.FullName, GenerateFlatFileList(sourceFolder));
      zip.StartInfo.WorkingDirectory = sourceFolder.FullName;
      zip.Start();
      zip.StartInfo.WindowStyle = ProcessWindowStyle.Minimized;
      zip.WaitForExit();
    }

    private string GenerateFlatFileList(DirectoryInfo dir)
    {
      StringBuilder sb = new StringBuilder();

      foreach (FileInfo file in dir.GetFiles())
      {
        // Add each file in directory
        sb.Append("\"");
        sb.Append(file.Name);
        sb.Append("\" ");
      }

      foreach (DirectoryInfo subdir in dir.GetDirectories())
      {
        // Recursively add subdirectories
        sb.Append("\"");
        sb.Append(subdir.Name);
        sb.Append("\" ");
      }

      return sb.ToString().Trim();
    }
  }
}
