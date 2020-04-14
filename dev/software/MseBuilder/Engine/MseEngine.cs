/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10186 : Added Zip method.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  25-Nov-2007  10208 : Added newpages to SQL that is written to the loader file.
 * CAM  11-May-2008  10265 : Allow Zipping of single Volume.
 * CAM  17-May-2008  10266 : Check for Errors during Build.
 * CAM  08-Jun-2008  10269 : Don't just do an update on the export script: the volume may not exist - do a REPLACE including Title.
 * CAM  15-Jan-2010  10528 : Added CreateBbebFiles.
 * CAM  15-Jan-2010  10529 : Converted Volume.Author from string to Author class.
 * CAM  15-Jan-2010  10531 : Added ArticleStage.
 * CAM  15-Jan-2010  10532 : Add Articles to the TOC.
 * CAM  15-Jan-2010  10533 : Copy image files to target directory.
 * CAM  18-Jan-2010  10529 : Missed several references to Author!
 * CAM  18-Jan-2010  10538 : Ensure newline occurs after title when there are no scriptures, and after finding the first paragraph, stop looking for scriptures.
 * CAM  19-Jan-2010  10540 : Added CreateEpubFiles logic.
 * CAM  21-Jan-2010  10544 : Create a separate directory for the EPUB files.
 * CAM  23-Jan-2010  10551 : Added CreateJndFiles.
 * CAM  24-Dec-2010  10902 : Added directories for Epub and Mobi.
 * CAM  03-Jan-2011  10917 : Replaced stub CreateEpubHymnFiles with actual data.
 * CAM  03-Jan-2011  10920 : Retrieve first line of each hymn.
 * CAM  28-Dec-2011  gc005 : Removed redundant code.
 * CAM  31-Dec-2015  886930 : Added CreateEpubScriptureFiles.
 * CAM  22-Feb-2018  732482 : Added CreateEpubCollectionFiles and tidied TOC entries for Scripture Files.
 * CAM  25-Feb-2018  790063 : Used correct namespace for Data.
 * CAM  14-Apr-2020  361011 : Include Article Groups, and group GT by Bible Book using Book-Chapter parent groupings.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Threading;
using System.Windows.Forms;

using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.GZip;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Data;

using FrontBurner.Ministry.MseBuilder.Reader.Epub;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;
using FrontBurner.Ministry.MseBuilder.Reader.Hymnbook;

namespace FrontBurner.Ministry.MseBuilder.Engine
{
  public class MseEngine
  {
    private enum ArticleStage
    {
      Title,
      Scriptures,
      Body
    }

    protected int _current;
    protected bool _anyErrors;

    public int Current
    {
      get
      {
        return _current;
      }
    }
    public bool AnyErrors
    {
      get
      {
        return _anyErrors;
      }
    }

    public MseEngine()
    {
      DatabaseLayer.Instance.Open();
    }

    public void Build(string author, int vol)
    {
      VolumeCollection vols = BusinessLayer.Instance.Volumes;
      Volume vol1 = null;
      _anyErrors = false;

      try
      {
        vol1 = vols[Volume.GetId(author, vol)];
      }
      catch (Exception)
      {
        throw;
      }

      if (vol1 != null)
      {
        Build(vol1);
      }
    }

    public void Build(Volume vol)
    {
      DatabaseLayer.Instance.DeleteVolume(vol);
      MseParser parser = new MseParser(vol);
      if (parser.ParseText()) _anyErrors = true;
    }

    public void Build()
    {
      VolumeCollection vols = DatabaseLayer.Instance.GetVolumes();
      _current = 0;
      _anyErrors = false;

      DatabaseLayer.Instance.TruncateTables();

      foreach (Volume vol in vols)
      {
        Build(vol);
        _current++;
        Thread.Sleep(2000);
      }
    }

    public void Zip()
    {
      this.Zip(string.Empty, 0);
    }

    public void Zip(string author, int volume)
    {
      byte[] dataBuffer = new byte[4096];
      string sql = "";
      string colSql = "";
      DirectoryInfo root = new DirectoryInfo(@"C:\tmp\mse1");
      FileInfo sqlFile = null;
      FileInfo zipFile = null;

      if (root.Exists) root.Delete(true);
      root.Create();
      _current = 0;

      using (StreamWriter script = new StreamWriter(root.FullName + @"\aaa"))
      {
        foreach (Volume vol in DatabaseLayer.Instance.GetVolumes())
        {
          if ((volume == 0) || ((volume > 0) && (vol.Author.Inits.Equals(author)) && (vol.Vol == volume)))
          {
            sqlFile = new FileInfo(String.Format(@"{0}\{1}.sql", root.FullName, vol.Filename));

            using (StreamWriter sw = new StreamWriter(sqlFile.FullName))
            {
              sw.NewLine = "\n";

              sw.WriteLine(String.Format("-- {0} {1}\n", vol.Author.Inits, vol.Vol));

              sw.WriteLine("\n-- REMOVE EXISTING VOLUME\n");

              // Empty existing data
              sw.WriteLine(String.Format("REPLACE INTO mse_volume (author,vol,title,added) VALUES ('{0}', '{1}', '{2}', NOW());\n", vol.Author.Inits, vol.Vol, DatabaseLayer.SqlText(vol.Title)));
              sw.WriteLine(String.Format("DELETE FROM mse_article WHERE author='{0}' AND vol={1};", vol.Author.Inits, vol.Vol));
              sw.WriteLine(String.Format("DELETE FROM mse_text WHERE author='{0}' AND vol={1};", vol.Author.Inits, vol.Vol));
              sw.WriteLine(String.Format("DELETE FROM mse_bible_ref WHERE author='{0}' AND vol={1};\n", vol.Author.Inits, vol.Vol));

              sw.WriteLine("\n-- ADD ARTICLES\n");

              // Write Articles
              foreach (DataRow dr in DatabaseLayer.Instance.GetArticles(vol).Rows)
              {
                sql = String.Format(
                  "INSERT INTO mse_article (author,vol,page,article,scriptures) VALUES " +
                  "('{0}',{1},{2},'{3}','{4}');",
                  vol.Author.Inits, vol.Vol, dr["page"],
                  DatabaseLayer.SqlText(dr["article"]),
                  DatabaseLayer.SqlText(dr["scriptures"]));

                sw.WriteLine(sql);
              }

              sw.WriteLine("\n-- ADD TEXT\n");

              foreach (DataRow dr in DatabaseLayer.Instance.GetText(vol).Rows)
              {
                string text = dr["text"].ToString();
                string inits = dr["inits"].ToString();
                string newPages = dr["newpages"].ToString();

                if (text.Length > 0)
                {
                  // Non-null columns
                  colSql = "INSERT INTO mse_text (author,vol,page,para,article_page,text";
                  sql = String.Format(
                    "'{0}',{1},{2},{3},{4},'{5}'",
                    vol.Author.Inits, vol.Vol,
                    dr["page"], dr["para"], dr["article_page"], DatabaseLayer.SqlText(text));

                  // Add each nullable column
                  if (inits.Length > 0)
                  {
                    colSql += ",inits";
                    sql += "," + DatabaseLayer.SqlText(inits, true);
                  }
                  if (newPages.Length > 0)
                  {
                    colSql += ",newpages";
                    sql += "," + DatabaseLayer.SqlText(newPages, true);
                  }

                  sql = colSql + ") VALUES (" + sql + ");";
                  sw.WriteLine(sql);
                }
              }

              sw.WriteLine("\n-- ADD BIBLE REFS\n");

              foreach (DataRow dr in DatabaseLayer.Instance.GetBibleRefs(vol).Rows)
              {
                sql = String.Format(
                  "INSERT INTO mse_bible_ref (author,vol,page,para,ref,article_page,article_primary,bookid,chapter,vstart,vend) VALUES " +
                  "('{0}',{1},{2},{3},{4},{5},{6},{7},{8},{9},{10});",
                  vol.Author.Inits, vol.Vol,
                  dr["page"], dr["para"], dr["ref"], dr["article_page"], dr["article_primary"],
                  dr["bookid"], dr["chapter"], dr["vstart"], dr["vend"]);

                sw.WriteLine(sql);
              }

              sw.Close();
            }

            zipFile = new FileInfo(sqlFile.FullName + ".gz");

            using (Stream stream = new GZipOutputStream(File.Create(zipFile.FullName)))
            using (FileStream fileStream = File.OpenRead(sqlFile.FullName))
            {
              StreamUtils.Copy(fileStream, stream, dataBuffer);
            }

            sqlFile.Delete();

            script.WriteLine(String.Format("gunzip {0}", zipFile.Name));
            script.WriteLine(String.Format("mysql -u goodteaching -ppsalm45 -D goodteaching_org_min < {0}", sqlFile.Name));
            script.WriteLine(String.Format("rm {0}", sqlFile.Name));
            script.Flush();

            Thread.Sleep(100);
          }

          _current++;
        }
      }
    }

    public void CreateEpubFiles()
    {
      CreateEpubFiles(null, 0);
    }

    public void CreateEpubFiles(string author, int volume)
    {
      byte[] dataBuffer = new byte[4096];
      DirectoryInfo root = new DirectoryInfo(@"C:\tmp\epub");
      DirectoryInfo files = new DirectoryInfo(@"C:\tmp\epub\dirs");
      DirectoryInfo epubDir = new DirectoryInfo(@"C:\tmp\epub\epub");
      DirectoryInfo mobiDir = new DirectoryInfo(@"C:\tmp\epub\mobi");

      try
      {
        if (files.Exists) files.Delete(true);
        files.Create();
        if (epubDir.Exists) epubDir.Delete(true);
        epubDir.Create();
        if (mobiDir.Exists) mobiDir.Delete(true);
        mobiDir.Create();
      }
      catch
      {
      }

      FileInfo exe = new FileInfo(Application.ExecutablePath);
      FileInfo cssFile = new FileInfo(String.Format(@"{0}\Reader\Epub\resources\css\epub-ministry.css", exe.DirectoryName));

      _current = 0;

      foreach (Volume vol in DatabaseLayer.Instance.GetVolumes())
      {
        if ((volume == 0) || ((volume > 0) && (vol.Author.Inits.Equals(author)) && (vol.Vol == volume)))
        {
          FileInfo authorImageFile = new FileInfo(String.Format(@"{0}\img\author\{1}", exe.DirectoryName, vol.Author.ImageFilename));
          FileInfo coverImageFile = new FileInfo(String.Format(@"{0}\img\cover\{1}", exe.DirectoryName, vol.Author.ImageFilename));

          EpubDocument epub = new EpubDocument(files, epubDir, mobiDir, vol, cssFile, authorImageFile, coverImageFile);

          int currentArticlePage = -1;
          EpubArticle article = null;
          EpubArticle articleGroup = null;
          DataTable articleGroups = DatabaseLayer.Instance.GetArticleGroups(vol);
          Article art = null;

          ArticleStage stage = ArticleStage.Title;

          foreach (DataRow dr in DatabaseLayer.Instance.GetText(vol).Rows)
          {
            string text = dr["text"].ToString();
            string inits = dr["inits"].ToString();
            string newPages = dr["newpages"].ToString();
            int articlePage = int.Parse(dr["article_page"].ToString());

            if (articlePage != currentArticlePage)
            {
              // Find Article
              art = DatabaseLayer.Instance.GetArticle(vol, articlePage);
              if (art.Group == null)
              {
                articleGroup = null;
              }
              else
              {
                if (articleGroup == null || articleGroup.Title != art.Group.Title)
                {
                  articleGroup = epub.Articles.CreateArticle();
                  articleGroup.Title = art.Group.Title;
                  article.Items.Add(new EpubParagraph(art.Group.Summary));
                }
              }

              article = epub.Articles.CreateArticle();
              article.Title = art.Title;
              article.Scriptures = art.Scriptures;
              article.Group = articleGroup;

              currentArticlePage = articlePage;
              stage = ArticleStage.Title;
            }

            if (stage == ArticleStage.Title)
            {
              stage = ArticleStage.Scriptures;
            }
            else
            {
              if (stage == ArticleStage.Scriptures && text.Trim().StartsWith("@"))
              {
                stage = ArticleStage.Body;
              }
              else
              {
                article.Items.Add(new EpubParagraph(inits, text));
                stage = ArticleStage.Body;
              }
            }
          }

          epub.GenerateToc();
          epub.SaveFile();

          Thread.Sleep(50);
        }

        _current++;
      }
    }

    public void CreateEpubCollectionFiles()
    {
      byte[] dataBuffer = new byte[4096];
      DirectoryInfo root = new DirectoryInfo(@"C:\tmp\epub");
      DirectoryInfo files = new DirectoryInfo(@"C:\tmp\epub\dirs");
      DirectoryInfo epubDir = new DirectoryInfo(@"C:\tmp\epub\epub");
      DirectoryInfo mobiDir = new DirectoryInfo(@"C:\tmp\epub\mobi");

      try
      {
        if (files.Exists) files.Delete(true);
        files.Create();
        if (epubDir.Exists) epubDir.Delete(true);
        epubDir.Create();
        if (mobiDir.Exists) mobiDir.Delete(true);
        mobiDir.Create();
      }
      catch
      {
      }

      FileInfo exe = new FileInfo(Application.ExecutablePath);
      FileInfo cssFile = new FileInfo(String.Format(@"{0}\Reader\Epub\resources\css\epub-ministry.css", exe.DirectoryName));

      _current = 0;

      foreach (Volume vol in BusinessLayer.Instance.Collections)
      {
        FileInfo authorImageFile = new FileInfo(String.Format(@"{0}\img\author\{1}", exe.DirectoryName, vol.Author.ImageFilename));
        FileInfo coverImageFile = new FileInfo(String.Format(@"{0}\img\cover\{1}", exe.DirectoryName, vol.Author.ImageFilename));

        EpubDocument epub = new EpubDocument(files, epubDir, mobiDir, vol, cssFile, authorImageFile, coverImageFile);

        int currentArticle = 0;
        EpubArticle article = null;
        ArticleStage stage = ArticleStage.Title;

        foreach (DataRow dr in DatabaseLayer.Instance.GetCollectionText(vol).Rows)
        {
          int bookid = int.Parse(dr["bookid"].ToString());
          string bookName = dr["bookname"].ToString();
          int articleNo = int.Parse(dr["articleno"].ToString());
          string author = dr["author"].ToString();
          int volNo = int.Parse(dr["vol"].ToString());

          string text = dr["text"].ToString();
          string inits = dr["inits"].ToString();
          string newPages = dr["newpages"].ToString();
          int articlePage = int.Parse(dr["article_page"].ToString());

          if (articlePage != currentArticle)
          {
            article = epub.Articles.CreateArticle();
            currentArticle = articlePage;
            stage = ArticleStage.Title;
          }

          if (stage == ArticleStage.Title)
          {
            if (Paragraph.IsTitle(text))
            {
              article.Title = String.Format("{0} -- {1} ({2} {3})", articleNo, text, author, volNo);
              stage = ArticleStage.Scriptures;
            }
          }
          else
          {
            if (stage == ArticleStage.Scriptures && text.Trim().StartsWith("@"))
            {
              article.Scriptures = text;
              stage = ArticleStage.Body;
            }
            else
            {
              article.Items.Add(new EpubParagraph(inits, text));
              stage = ArticleStage.Body;
            }
          }
        }

        epub.GenerateToc();
        epub.SaveFile();

        Thread.Sleep(50);
        _current++;
      }
    }

    private string ChapterTitle(Volume vol, string bookName, int chapter)
    {
      if (vol.LocalFile == "1")
      {
        return bookName;
      }

      return String.Format("{0} {1}", bookName, chapter);
    }

    public void CreateEpubScriptureFiles()
    {
      byte[] dataBuffer = new byte[4096];
      DirectoryInfo root = new DirectoryInfo(@"C:\tmp\epub");
      DirectoryInfo files = new DirectoryInfo(@"C:\tmp\epub\dirs");
      DirectoryInfo epubDir = new DirectoryInfo(@"C:\tmp\epub\epub");
      DirectoryInfo mobiDir = new DirectoryInfo(@"C:\tmp\epub\mobi");

      try
      {
        if (files.Exists) files.Delete(true);
        files.Create();
        if (epubDir.Exists) epubDir.Delete(true);
        epubDir.Create();
        if (mobiDir.Exists) mobiDir.Delete(true);
        mobiDir.Create();
      }
      catch
      {
      }

      FileInfo exe = new FileInfo(Application.ExecutablePath);
      FileInfo cssFile = new FileInfo(String.Format(@"{0}\Reader\Epub\resources\css\epub-ministry.css", exe.DirectoryName));

      _current = 0;

      foreach (Volume vol in DatabaseLayer.Instance.GetVolumesByBibleBook())
      {
        FileInfo authorImageFile = new FileInfo(String.Format(@"{0}\img\author\{1}", exe.DirectoryName, vol.Author.ImageFilename));
        FileInfo coverImageFile = new FileInfo(String.Format(@"{0}\img\cover\{1}", exe.DirectoryName, vol.Author.ImageFilename));

        EpubDocument epub = new EpubDocument(files, epubDir, mobiDir, vol, cssFile, authorImageFile, coverImageFile);

        int currentArticle = 0;
        int currentChapter = 0;
        EpubArticle article = null;
        EpubArticle articleChap = null;
        ArticleStage stage = ArticleStage.Title;
        SortedDictionary<string, Article> chaps = new SortedDictionary<string, Article>();
        SortedDictionary<string, EpubArticle> chapArticles = new SortedDictionary<string, EpubArticle>();
        DataTable scriptureText = DatabaseLayer.Instance.GetScriptureText(vol);
        
        // Reset Chapter Reference
        currentChapter = 0;

        foreach (DataRow dr in scriptureText.Rows)
        {
          int bookid = int.Parse(dr["bookid"].ToString());
          int chapter = int.Parse(dr["chapter"].ToString());
          string author = dr["author"].ToString();
          int volNo = int.Parse(dr["vol"].ToString());
          int pageNo = int.Parse(dr["page"].ToString());
          int para = int.Parse(dr["para"].ToString());
          int localRow = int.Parse(dr["localrow"].ToString());

          string text = dr["text"].ToString();
          string inits = dr["inits"].ToString();
          string newPages = dr["newpages"].ToString();
          int articlePage = int.Parse(dr["article_page"].ToString());

          if (articlePage != currentArticle)
          {
            if (chapter != currentChapter)
            {
              Article a = new Article(vol, pageNo, para, localRow, ChapterTitle(vol, vol.Title, chapter));
              //Article a = chaps[ChapterTitle(vol, vol.Title, chapter)];
              if (a != null)
              {
                articleChap = epub.Articles.CreateArticle();
                articleChap.Title = a.Title;
                chapArticles.Add(ChapterTitle(vol, vol.Title, chapter), articleChap);
              }
            }

            article = epub.Articles.CreateArticle();
            article.Group = articleChap;
            currentArticle = articlePage;
            stage = ArticleStage.Title;
          }

          if (stage == ArticleStage.Title)
          {
            if (Paragraph.IsTitle(text))
            {
              if (vol.LocalFile == "1")
              {
                article.Title = String.Format("{0} -- {1} ({2} {3})", vol.Title, text, author, volNo);
              }
              else
              {
                article.Title = String.Format("{0} ({1} {2})", text, author, volNo);
              }
              stage = ArticleStage.Scriptures;
            }
          }
          else
          {
            if (stage == ArticleStage.Scriptures && text.Trim().StartsWith("@"))
            {
              article.Scriptures = text;
              stage = ArticleStage.Body;
            }
            else
            {
              article.Items.Add(new EpubParagraph(inits, text));
              stage = ArticleStage.Body;
            }
          }

          currentChapter = chapter;
        }

        // Now that all Articles have been created, 
        // Add links onto them for each article referring to the Article Chapter
        foreach (EpubArticle chap in chapArticles.Values)
        {
          chap.Items.Add(new EpubPlain("<ul>"));

          foreach (EpubArticle a in epub.Articles)
          {
            Paragraph scriptures = new Paragraph(vol, 1, 1, 1, "", a.Scriptures, true);
            foreach (BibleRef bref in scriptures)
            {
              string key = ChapterTitle(vol, bref.Book.BookName, bref.Chapter);
              if (key == chap.Title)
              {
                EpubItem title = new EpubParagraph(a.Title);
                if (a.Group != chap)
                {
                  chap.Items.Add(new EpubPlain(String.Format("<li>({2}) <a href=\"{0}\">{1}</a></li>", 
                    a.XmlFile.Name, title.RenderToXhtml(), a.Group.Title)));
                }
                else
                {
                  chap.Items.Add(new EpubPlain(String.Format("<li><a href=\"{0}\">{1}</a></li>", 
                    a.XmlFile.Name, title.RenderToXhtml())));
                }
              }
            }
          }

          chap.Items.Add(new EpubPlain("</ul>"));          
        }

        epub.GenerateToc();
        epub.SaveFile();

        Thread.Sleep(50);
        _current++;
      }
    }

    public void CreateEpubHymnFiles()
    {
      byte[] dataBuffer = new byte[4096];
      DirectoryInfo root = new DirectoryInfo(@"C:\tmp\epub");
      DirectoryInfo files = new DirectoryInfo(@"C:\tmp\epub\dirs");
      DirectoryInfo epubDir = new DirectoryInfo(@"C:\tmp\epub\epub");
      DirectoryInfo mobiDir = new DirectoryInfo(@"C:\tmp\epub\mobi");

      try
      {
        if (files.Exists) files.Delete(true);
        files.Create();
        if (epubDir.Exists) epubDir.Delete(true);
        epubDir.Create();
        if (mobiDir.Exists) mobiDir.Delete(true);
        mobiDir.Create();
      }
      catch (IOException ioe)
      {
        MessageBox.Show(ioe.Message + "\n\n" + ioe.StackTrace,
          "Error wiping output directories", MessageBoxButtons.OK, MessageBoxIcon.Error);
        return;
      }

      FileInfo exe = new FileInfo(Application.ExecutablePath);
      FileInfo cssFile = new FileInfo(String.Format(@"{0}\Reader\Hymnbook\resources\css\epub-hymn.css", exe.DirectoryName));

      foreach (Language lang in Languages.List)
      {
        FileInfo coverImageFile = new FileInfo(String.Format(@"{0}\img\hymnbook\hymnbook_{1}.png",
          exe.DirectoryName, Languages.LanguageCode(lang)));
        EpubHymnbookDocument hymnDoc = new EpubHymnbookDocument(lang, files, epubDir, mobiDir, cssFile, coverImageFile);

        foreach (DataRow hr in DatabaseLayer.Instance.GetHymns(lang).Rows)
        {
          EpubHymn hymn = hymnDoc.Hymns.CreateHymn(long.Parse(hr["hymn_no"].ToString()));
          hymn.MeterId = long.Parse(hr["meter_id"].ToString());
          hymn.Meter = hr["meter"].ToString();
          hymn.AuthorId = long.Parse(hr["author_id"].ToString());
          hymn.Author = hr["fullname"].ToString();
          if (!hr.IsNull("author_life")) hymn.AuthorLife = hr["author_life"].ToString();
          hymn.FirstLine = hr["first_line_text"].ToString();

          long prevVers = 0;
          long currVers = 0;
          string versText = String.Empty;
          string text = String.Empty;
          EpubHymnVerse verse = null;

          foreach (DataRow tr in DatabaseLayer.Instance.GetHymnText(lang, hymn.HymnNo).Rows)
          {
            currVers = long.Parse(tr["vers_no"].ToString());
            if (currVers != prevVers)
            {
              verse = new EpubHymnVerse(currVers);
              hymn.Items.Add(verse);
            }

            if (verse.PlainText != String.Empty) verse.PlainText += "<br />";
            verse.PlainText += tr["line_text"].ToString();

            prevVers = currVers;
          }
        }

        hymnDoc.GenerateToc();
        hymnDoc.SaveFile();

        Thread.Sleep(50);
      }
    }

    protected string RemoveTags(string line, string tag)
    {
      line = line.Replace(String.Format("<{0}>", tag), "");
      line = line.Replace(String.Format("</{0}>", tag), "");
      return line;
    }

    protected string PageNo(string line)
    {
      const string PageNo = "[Page";
      int p = line.IndexOf(PageNo);
      if (p < 0) return line;

      line = line.Substring(p + PageNo.Length).Trim();
      p = line.IndexOf("]");
      line = line.Substring(0, p).Trim();
      return String.Format("{{{0}}}", line);
    }

    protected string RemoveATag(string line)
    {
      const string ATag = "<a";
      int p = line.IndexOf(ATag);

      while (p >= 0)
      {
        line = RemoveATag(line, ATag);
        p = line.IndexOf(ATag);
      }

      return line;
    }

    protected string RemoveATag(string line, string tag)
    {
      int p = line.IndexOf(tag);
      if (p < 0) return line;

      string rval = line.Substring(0, p);
      int e = line.IndexOf(">", p);

      string href = line.Substring(p, e - p);

      if (href.IndexOf("/bible/") > 0)
      {
        rval += "@";
      }

      rval += line.Substring(e + 1);

      return rval;
    }
  }
}