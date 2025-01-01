/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubHymnbookDocument.cs 1312 2011-01-03 23:44:28Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Changed rendering for Hymnbook EPUB.
 * CAM  03-Jan-2011  10918 : Use EngineSettings to determine global build for EPUB or MOBI.
 * CAM  03-Jan-2011  10920 : Rename of 'articles' to 'hymns' for consistency.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;

using FrontBurner.Ministry.MseBuilder.Util;
using FrontBurner.Ministry.MseBuilder.Engine;
using FrontBurner.Ministry.MseBuilder.Reader.Epub;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubHymnbookDocument : IEpubGenerator, IEpubTocGenerator
  {
    private Guid _bookId;

    private Language _language;
    private DirectoryInfo _rootDir;
    private DirectoryInfo _outputEpub;
    private DirectoryInfo _epubDir;
    private DirectoryInfo _metaDir;
    private DirectoryInfo _opsDir;
    private DirectoryInfo _cssDir;
    private DirectoryInfo _imgDir;
    private FileInfo _epubFile;

    private FileInfo _cssFile;
    private FileInfo _coverImage;

    private EpubContainer _container;
    private EpubOpf _opf;
    private EpubNcx _ncx;
    private EpubToc _toc;

    private EpubHymnCollection _hymns;

    public string BookId
    {
      get { return _bookId.ToString().ToUpper(); }
    }
    public string QualifiedBookId
    {
      get { return String.Format("urn:uuid:{0}", BookId); }
    }
    public Language Language
    {
      get { return _language; }
      set { _language = value; }
    }
    public string LanguageCode
    {
      get { return Languages.LanguageCode(Language); }
    }
    public string Filename
    {
      get { return String.Format("hymns-1962-{0}", LanguageCode); }
    }
    public string HymnBookTitle
    {
      get { return String.Format("Hymns and Spiritual Songs (1962) - {0}", Languages.LanguageName(Language)); }
    }
    public string HymnBookAuthor
    {
      get { return "Brethren"; }
    }
    public DirectoryInfo RootDir
    {
      get { return _rootDir; }
      set { _rootDir = value; }
    }
    public FileInfo EpubFile
    {
      get { return _epubFile; }
    }
    public DirectoryInfo OutputEpub
    {
      get { return _outputEpub; }
      set { _outputEpub = value; }
    }
    public DirectoryInfo OpsDir
    {
      get { return _opsDir; }
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
    public FileInfo CssFile
    {
      get { return _cssFile; }
      set { _cssFile = value; }
    }
    public FileInfo CoverImage
    {
      get { return _coverImage; }
      set { _coverImage = value; }
    }

    public EpubHymnCollection Hymns
    {
      get { return _hymns; }
    }

    public EpubHymnbookDocument(Language language, DirectoryInfo root, DirectoryInfo outputEpub, FileInfo cssFile, FileInfo coverImage)
    {
      Language = language;
      RootDir = root;
      OutputEpub = outputEpub;
      _cssFile = cssFile;
      _coverImage = coverImage;

      _bookId = Guid.NewGuid();

      _hymns = new EpubHymnCollection(this);

      GenerateEpub();
    }

    public void GenerateEpub()
    {
      _epubDir = new DirectoryInfo(String.Format(@"{0}\{1}", RootDir.FullName, LanguageCode));

      _metaDir = new DirectoryInfo(String.Format(@"{0}\META-INF", _epubDir.FullName));
      _opsDir = new DirectoryInfo(String.Format(@"{0}\OPS", _epubDir.FullName));

      _cssDir = new DirectoryInfo(String.Format(@"{0}\css", _opsDir.FullName));
      _imgDir = new DirectoryInfo(String.Format(@"{0}\img", _opsDir.FullName));

      _epubFile = new FileInfo(String.Format(@"{0}\{1}.epub", OutputEpub.FullName, Filename));

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

      foreach (EpubHymn article in Hymns)
      {
        article.SaveFile();
      }

      CreateMimeType();
      CopyResources();

      if (EngineSettings.Instance.Mode == BuildMode.StandardEpub)
      {
        Zipper.Instance.ZipDirectory(_epubDir, _epubFile);
      }
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
      _cssFile.CopyTo(String.Format(@"{0}\{1}", _cssDir.FullName, _cssFile.Name), true);

      // No need to write anything extra - individual cover files have been created
      _coverImage.CopyTo(String.Format(@"{0}\{1}", _imgDir.FullName, _coverImage.Name));

      // Determine the text and therefore size/position of the title
      //string title = String.Format("({0})", Languages.LanguageCode(Language));
      //int fontSize = 48;
      //float vertical = 0.25f;

      // Copy the plain volume cover and add the specific title
      //Bitmap coverBitmap = new Bitmap(_coverImage.FullName);
      //Graphics g = Graphics.FromImage(coverBitmap);
      //g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;

      //StringFormat strFormat = new StringFormat();
      //strFormat.Alignment = StringAlignment.Center;
      //int h = (int)(((float)coverBitmap.Height) * vertical);
      //int w = (int)(((float)coverBitmap.Width) * 0.9f);
      //g.DrawString(title, new Font("Tahoma", fontSize), new SolidBrush(Color.FromArgb(255, 243, 186)),
      //    new RectangleF((coverBitmap.Width-w)/2, coverBitmap.Height-h, w, h), strFormat);
      //coverBitmap.Save(String.Format(@"{0}\cover-{1}", _imgDir.FullName, _coverImage.Name));
    }
  }
}
