/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  21-Jan-2010  10544 : Create the EPUB zipfile.
 * CAM  11-Feb-2010  10559 : Mimetype without newline (needed?).
 * CAM  24-Dec-2010  10902 : Improved OO design to allow better extendability.
 * CAM  24-Dec-2010  10904 : More sensible, tidier title on cover image.
 * CAM  28-Dec-2011  gc005 : Ensure apostrophes display correctly on cover page.
 * CAM  31-May-2015  998637 : Support for Cover page.
 * CAM  22-Feb-2018  732482 : Refreshed the font and added support for Collections.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.IO;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;
using FrontBurner.Ministry.MseBuilder.Util;
using FrontBurner.Ministry.MseBuilder.Engine;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public class EpubDocument : IEpubGenerator, IEpubTocGenerator
  {
    private Volume _volume;
    private Guid _bookId;

    private DirectoryInfo _rootDir;
    private DirectoryInfo _outputEpub;
    private DirectoryInfo _outputMobi;
    private DirectoryInfo _epubDir;
    private DirectoryInfo _metaDir;
    private DirectoryInfo _opsDir;
    private DirectoryInfo _cssDir;
    private DirectoryInfo _imgDir;
    private FileInfo _epubFile;
    private FileInfo _mobiFile;

    private FileInfo _cssFile;
    private FileInfo _authorImage;
    private FileInfo _coverImage;

    private EpubContainer _container;
    private EpubOpf _opf;
    private EpubNcx _ncx;
    private EpubToc _toc;

    private EpubArticleCollection _articles;

    public string BookId
    {
      get { return _bookId.ToString().ToUpper(); }
    }
    public string QualifiedBookId
    {
      get { return String.Format("urn:uuid:{0}", BookId); }
    }
    public FileInfo AuthorImage
    {
      get { return _authorImage; }
    }
    public FileInfo CoverImage
    {
      get { return _coverImage; }
    }
    public DirectoryInfo RootDir
    {
      get { return _rootDir; }
      set { _rootDir = value; }
    }
    public DirectoryInfo OutputEpub
    {
      get { return _outputEpub; }
      set { _outputEpub = value; }
    }
    public DirectoryInfo OutputMobi
    {
      get { return _outputMobi; }
      set { _outputMobi = value; }
    }
    public DirectoryInfo OpsDir
    {
      get { return _opsDir; }
    }
    public Volume Volume
    {
      get { return _volume; }
      set { _volume = value; }
    }

    public EpubContainer Container
    {
      get { return _container; }
      set { _container = value; }
    }
    public EpubOpf Opf
    {
      get { return _opf; }
      set { _opf = value; }
    }
    public EpubNcx Ncx
    {
      get { return _ncx; }
      set { _ncx = value; }
    }
    public EpubToc Toc
    {
      get { return _toc; }
      set { _toc = value; }
    }

    public EpubArticleCollection Articles
    {
      get { return _articles; }
    }

    public EpubDocument(DirectoryInfo root, DirectoryInfo outputEpub, DirectoryInfo outputMobi, Volume volume, FileInfo cssFile, FileInfo authorImage, FileInfo coverImage)
    {
      RootDir = root;
      OutputEpub = outputEpub;
      OutputMobi = outputMobi;
      Volume = volume;
      _cssFile = cssFile;
      _authorImage = authorImage;
      _coverImage = coverImage;

      _bookId = Guid.NewGuid();

      _articles = new EpubArticleCollection(this);

      // Build based on the Epub for Mobi, alter for Standard later (as this has less functionality)
      EngineSettings.Instance.Mode = BuildMode.KindleMobiEpub;

      GenerateEpub();
    }

    public void GenerateEpub()
    {
      _epubDir = new DirectoryInfo(String.Format(@"{0}\{1}", RootDir.FullName, _volume.Filename));

      _metaDir = new DirectoryInfo(String.Format(@"{0}\META-INF", _epubDir.FullName));
      _opsDir = new DirectoryInfo(String.Format(@"{0}\OPS", _epubDir.FullName));

      _cssDir = new DirectoryInfo(String.Format(@"{0}\css", _opsDir.FullName));
      _imgDir = new DirectoryInfo(String.Format(@"{0}\img", _opsDir.FullName));

      _epubFile = new FileInfo(String.Format(@"{0}\{1}.epub", OutputEpub.FullName, _volume.Filename));
      _mobiFile = new FileInfo(String.Format(@"{0}\{1}.mobi", OutputMobi.FullName, _volume.Filename));

      Ncx = new EpubNcx(this, _opsDir);
      Toc = new EpubToc(this, _opsDir);
      Opf = new EpubOpf(this, _opsDir);
      Container = new EpubContainer(this, _metaDir);
    }

    public void GenerateToc()
    {
      Opf.GenerateToc();
      Ncx.GenerateToc();
    }

    public void SaveFile()
    {
      CreateDirectoryStructure();

      Container.SaveFile();
      Opf.SaveFile();
      Ncx.SaveFile();
      Toc.SaveFile();

      foreach (EpubArticle article in Articles)
      {
        article.SaveFile();
      }

      CreateMimeType();
      CopyResources();

      // MOBI generated with Kindle TOC
      KindleGen.Instance.GenerateMobi(_opf.File, _mobiFile);

      // Regenerate without the Kindle TOC for EPUB (iPad etc) and with Cover page
      EngineSettings.Instance.Mode = BuildMode.StandardEpub;
      Opf.GenerateEpub();
      Opf.GenerateToc();
      Opf.SaveFile();
      Zipper.Instance.ZipDirectory(_epubDir, _epubFile);
    }

    protected void CreateDirectoryStructure()
    {
      if (_epubDir.Exists) _epubDir.Delete(true);
      if (_epubFile.Exists) _epubFile.Delete();

      _epubDir.Create();
      _metaDir.Create();
      _opsDir.Create();

      _cssDir.Create();
      _imgDir.Create();
    }

    protected void CreateMimeType()
    {
      FileInfo mimetypeFile = new FileInfo(String.Format(@"{0}\mimetype", _epubDir));

      using (StreamWriter writer = new StreamWriter(mimetypeFile.FullName))
      {
        writer.Write(MimeTypes.GetMimeType(MimeType.EpubZip));
      }
    }

    protected void CopyResources()
    {
      Color gold = Color.FromArgb(255, 221, 51);
      Color deepGold = Color.FromArgb(196, 180, 48);
      Color fontColor = gold;

      _cssFile.CopyTo(String.Format(@"{0}\{1}", _cssDir.FullName, _cssFile.Name), true);
      _authorImage.CopyTo(String.Format(@"{0}\{1}", _imgDir.FullName, _authorImage.Name), true);

      // Determine the text and therefore size/position of the title
      string title = String.Format("Volume {0}", Volume.Vol);
      int fontSize = 48;
      float vertical = 0.25f;

      if (Volume.Title.Length > 0)
      {
        title = Volume.Title.Replace('~', (char)8217); // [#5]
        fontSize = 48;
        vertical = 0.4f;
      }

      if (Volume.Author == Author.ScriptureAuthor)
      {
        fontSize = 60;
        vertical = 0.45f;
        //fontColor = deepGold;
      }
      if (Volume.Author == Author.CollectionAuthor)
      {
        vertical = 0.50f;
      }

      // Copy the plain volume cover and add the specific title
      Bitmap coverBitmap = new Bitmap(_coverImage.FullName);
      Graphics g = Graphics.FromImage(coverBitmap);
      g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;

      StringFormat strFormat = new StringFormat();
      strFormat.Alignment = StringAlignment.Center;
      int h = (int)(((float)coverBitmap.Height) * vertical);
      int w = (int)(((float)coverBitmap.Width) * 0.9f);
      g.DrawString(title, new Font("Swis721 Cn BT", fontSize), new SolidBrush(fontColor),
          new RectangleF((coverBitmap.Width - w) / 2, coverBitmap.Height - h, w, h), strFormat);

      if (Volume.Author == Author.CollectionAuthor)
      {
        g.DrawString(String.Format("#{0}", Volume.Vol) , new Font("Swis721 Cn BT", fontSize), new SolidBrush(fontColor),
            new RectangleF((coverBitmap.Width - w) / 2, coverBitmap.Height - h - (fontSize*1.5f), w, h), strFormat);
      }

      coverBitmap.Save(String.Format(@"{0}\cover-{1}", _imgDir.FullName, _coverImage.Name));
    }
  }
}
