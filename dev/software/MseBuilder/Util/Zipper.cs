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
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;

using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.Zip;

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

    public void ZipDirectory2(DirectoryInfo sourceFolder, FileInfo zipfile)
    {
      Ziplist.Clear();

      GenerateFileList(sourceFolder);

      FileStream fs;
      byte[] buffer;
      ZipEntry entry;
      Crc32 crc = new Crc32();
      ZipOutputStream zipStream = new ZipOutputStream(zipfile.Create());
      zipStream.SetLevel(9); // maximum compression
      int baseDirectoryLength = sourceFolder.FullName.Length + 1; // remove up to and including the '\'

      foreach (FileInfo file in _ziplist)
      {
        // Read the file contents
        fs = File.OpenRead(file.FullName);
        buffer = new byte[fs.Length];
        fs.Read(buffer, 0, buffer.Length);
        entry = new ZipEntry(file.FullName.Remove(0, baseDirectoryLength));
        entry.DateTime = DateTime.Now;
        entry.Size = fs.Length;
        fs.Close();

        // Calculate CRC
        crc.Reset();
        crc.Update(buffer);
        entry.Crc = crc.Value;

        // Generate an entry in the zipfile
        zipStream.PutNextEntry(entry);
        // Add the contents of the file itself
        zipStream.Write(buffer, 0, buffer.Length);
      }

      zipStream.Finish();
      zipStream.Close();
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

    private void GenerateFileList(DirectoryInfo dir)
    {
      foreach (FileInfo file in dir.GetFiles())
      {
        // Add each file in directory
        _ziplist.Add(file);
      }

      foreach (DirectoryInfo subdir in dir.GetDirectories())
      {
        // Recursively add subdirectories
        GenerateFileList(subdir);
      }
    }
  }
}
