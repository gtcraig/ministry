/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10186 : Added methods for exporting.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  24-Nov-2007  10188 : Save Mse_Text.Article_Page.
 * CAM  24-Nov-2007  10208 : Write NewPages to mse_text.
 * CAM  25-Nov-2007  10208 : Added newpages to sql extraction in GetText.
 * CAM  11-May-2008  10264 : Added handling of error refs.
 * CAM  08-Jun-2008  10269 : Update the local volume when deleting to see meaningful info on the home page.
 * CAM  28-Mar-2009  10409 : Added Footnote support.
 * CAM  04-Apr-2009  10413 : Save Footnote Refs.
 * CAM  04-Apr-2009  10414 : Truncate rather than Delete Xrefs.
 * CAM  15-Jan-2010  10528 : Added GetAuthors (renamed existing to GetAuthorDataset).
 * CAM  15-Jan-2010  10529 : Converted Volume.Author from string to Author class.
 * CAM  15-Jan-2010  10529 : Missed a reference to Author.
 * CAM  18-Jan-2010  10529 : Missed several references to Author!
 * CAM  23-Jan-2010  10551 : Added GetJndHtmlVolumes.
 * CAM  24-Dec-2010  10902 : Added Fullname and Orgname.
 * CAM  03-Jan-2011  10917 : Retrieve hymns.
 * CAM  03-Jan-2011  10920 : Retrieve first line of each hymn.
 * CAM  04-Jan-2011  10919 : Retrieve hymns by authors and meters.
 * CAM  28-Dec-2011  gc005 : Removed redundant code.
 * CAM  29-Aug-2015  163118 : Save Article Primary and Article Page properties for BibleRef.
 * CAM  31-Dec-2015  886930 : Added methods to return Articles and Text by Scripture.
 * CAM  22-Feb-2018  732482 : Added Collection summary and detail queries.
 * CAM  25-Feb-2018  790063 : Used correct namespace for Data and replaced MseData.xsd with an explicit query.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Engine;
using FrontBurner.Ministry.MseBuilder.Reader.Hymnbook;

namespace FrontBurner.Ministry.MseBuilder.Data
{
  /// <summary>
  /// Retrieves MySQL data
  /// </summary>
  public class DatabaseLayer
  {
    private static DatabaseLayer _dbLayer;
    protected static readonly object _semaphore = new object();

    protected MySqlConnection _conn;

    protected MySqlCommand _cmdVolume;
    protected MySqlCommand _cmdVolumeColl;
    protected MySqlCommand _cmdVolumeJndHtml;
    protected MySqlCommand _cmdAuthor;
    protected MySqlCommand _cmdVersions;
    protected MySqlCommand _cmdBooks;
    protected MySqlCommand _cmdArticles;
    protected MySqlCommand _cmdText;
    protected MySqlCommand _cmdBibleRef;
    protected MySqlCommand _cmdRelArticles;

    protected MySqlCommand _cmdInsertText;
    protected MySqlCommand _cmdInsertBibleRef;
    protected MySqlCommand _cmdInsertBadBibleRef;

    // Bible commands
    protected MySqlCommand _cmdInsertVerse;
    protected MySqlCommand _cmdInsertFootnote;
    protected MySqlCommand _cmdInsertFootnoteRef;
    protected MySqlCommand _cmdInsertFootnoteXref;
    protected MySqlCommand _cmdDeleteVerse;
    protected MySqlCommand _cmdDeleteFootnote;
    protected MySqlCommand _cmdDeleteFootnoteRef;
    protected MySqlCommand _cmdDeleteFootnoteXref1;
    protected MySqlCommand _cmdDeleteFootnoteXref2;

    protected MySqlDataAdapter _dadAuthor;
    protected MySqlDataAdapter _dadBuildError;

    private DatabaseLayer()
    {
    }

    public static DatabaseLayer Instance
    {
      get
      {
        lock (_semaphore)
        {
          if (_dbLayer == null)
          {
            _dbLayer = new DatabaseLayer();
          }
          return _dbLayer;
        }
      }
    }

    public bool Open()
    {
      string DataSource = "wizard";
      string Database = "goodteaching_org_min";
      string UserID = "goodteaching";
      string Password = "psalm45";

      string MyConString = "Data Source=" + DataSource +
          ";Database=" + Database +
          ";User ID=" + UserID +
          ";Password=" + Password;

      lock (_semaphore)
      {
        try
        {
          _conn = new MySqlConnection(MyConString);
          _conn.Open();
        }
        catch (Exception)
        {
          return false;
        }
      }
      return true;
    }

    protected MySqlConnection Connection
    {
      get
      {
        lock (_semaphore)
        {
          if (_conn.State == ConnectionState.Closed)
          {
            try
            {
              _conn.Open();
            }
            catch (Exception) { }
          }
         
        }
        return _conn;
      }
    }

    public void Close()
    {
      lock (_semaphore)
      {
        if (_conn != null && _conn.State == ConnectionState.Open)
        {
          _conn.Close();
        }

      }
    }

    public BibleVersionCollection GetBibleVersions()
    {
      String sql;
      MySqlDataReader dr;
      BibleVersionCollection versions = new BibleVersionCollection();

      sql = "SELECT verid, vercode, versionname " +
            "FROM mse_bible_version ";

      lock (_semaphore)
      {
        if (_cmdVersions == null)
        {
          _cmdVersions = new MySqlCommand(sql, Connection);
        }
        dr = _cmdVersions.ExecuteReader();
      }

      do
      {
        while (dr.Read())
        {
          versions.Add(new BibleVersion(dr.GetInt32(0), dr.GetString(1), dr.GetString(2)));
        }
      } while (dr.NextResult());

      dr.Close();

      return versions;
    }

    public BibleBookCollection GetBooks()
    {
      String sql;
      MySqlDataReader dr;
      BibleBook book;
      BibleBookCollection books = new BibleBookCollection();

      sql = "SELECT bookid, bookname, singlechap " +
            "FROM mse_bible_book ";

      lock (_semaphore)
      {
        if (_cmdBooks == null)
        {
          _cmdBooks = new MySqlCommand(sql, Connection);
        }
        dr = _cmdBooks.ExecuteReader();
      }

      do
      {
        while (dr.Read())
        {
          book = new BibleBook(dr.GetInt32(0), dr.GetString(1));
          if (!dr.IsDBNull(2)) book.SingleChap = (dr.GetInt32(2) == 1);

          books.Add(book);
        }
      } while (dr.NextResult());

      dr.Close();

      return books;
    }

    public VolumeCollection GetVolumes()
    {
      MySqlDataReader dr;
      Volume vol;
      string inits;
      VolumeCollection rval = new VolumeCollection();
      AuthorCollection authors = BusinessLayer.Instance.Authors;

      lock (_semaphore)
      {
        if (_cmdVolume == null)
        {
          string sql =
            "SELECT author,vol,title,added,localfile " +
            "FROM mse_volume " +
            "WHERE author <> 'GRC' " +
            "ORDER BY author,vol ";

          _cmdVolume = new MySqlCommand(sql, Connection);
        }
        dr = _cmdVolume.ExecuteReader();

        do
        {
          while (dr.Read())
          {
            inits = dr.GetString(0);
            if (authors.Contains(inits))
            {
              vol = new Volume(authors[inits], dr.GetInt32(1));

              if (!dr.IsDBNull(2)) vol.Title = dr.GetString(2);
              if (!dr.IsDBNull(3)) vol.Added = dr.GetDateTime(3);
              if (!dr.IsDBNull(4)) vol.LocalFile = dr.GetString(4);

              rval.Add(vol);
            }
          }
        } while (dr.NextResult());

        dr.Close();
      }

      return rval;
    }

    public VolumeCollection GetVolumesByBibleBook()
    {
      MySqlDataReader dr;
      Volume vol;
      VolumeCollection rval = new VolumeCollection();

      lock (_semaphore)
      {
        if (_cmdVolume == null)
        {
          string sql =
            "SELECT bookid,bookname,ifnull(singlechap,0) singlechap " +
            "FROM mse_bible_book " +
            //"WHERE bookid >= 6 and bookid <= 9 " +
            "ORDER BY bookid ";

          _cmdVolume = new MySqlCommand(sql, Connection);
        }
        dr = _cmdVolume.ExecuteReader();

        do
        {
          while (dr.Read())
          {
            vol = new Volume(Author.ScriptureAuthor, dr.GetInt32(0));

            if (!dr.IsDBNull(1)) vol.Title = dr.GetString(1);
            if (!dr.IsDBNull(2)) vol.LocalFile = dr.GetString(2);

            rval.Add(vol);
          }
        } while (dr.NextResult());

        dr.Close();
      }

      return rval;
    }

    public VolumeCollection GetCollectionVolumes()
    {
      MySqlDataReader dr;
      Volume vol;
      VolumeCollection rval = new VolumeCollection();

      lock (_semaphore)
      {
        if (_cmdVolumeColl == null)
        {
          string sql =
            "SELECT collectionid,collectionname " +
            "FROM mse_collection " +
            "ORDER BY collectionid ";

          _cmdVolumeColl = new MySqlCommand(sql, Connection);
        }
        dr = _cmdVolumeColl.ExecuteReader();

        do
        {
          while (dr.Read())
          {
            vol = new Volume(Author.CollectionAuthor, dr.GetInt32(0));

            if (!dr.IsDBNull(1)) vol.Title = dr.GetString(1);

            rval.Add(vol);
          }
        } while (dr.NextResult());

        dr.Close();
      }

      return rval;
    }

    public ArticleCollection GetRelatedArticles(int bookid, int chapter)
    {
      MySqlDataReader dr;
      Volume vol;
      Article article;
      ArticleCollection rval = new ArticleCollection();
      AuthorCollection authors = BusinessLayer.Instance.Authors;
      string inits;

      lock (_semaphore)
      {
        if (_cmdRelArticles == null)
        {
          string sql =
            "select a.author, a.vol, a.article_page, a.localrow, a.article, a.scriptures, " +
            "concat(a.bookname, ' ', br.chapter, ' &ndash; <b>', a.article, '</b> (', a.author, ' ', a.vol, ')') ref " +
            "from ( " +
            "select bb.bookid, min(bb.bookname) bookname, br.chapter,  " +
            "br.author, br.vol, br.article_page, a.localrow,  " +
            "min(a.article) article, min(a.scriptures) scriptures " +
            "from mse_bible_ref br " +
            "inner join mse_bible_book bb " +
            "on bb.bookid = br.bookid " +
            "inner join mse_article a " +
            "on a.author = br.author " +
            "and a.vol = br.vol " +
            "and a.page = br.page " +
            "where article_primary = 1 " +
            "and br.bookid = ?bookid " +
            "and br.chapter = ?chapter " +
            "and exists (select 1 from mse_bible_ref br2  " +
            "where br2.bookid = br.bookid  " +
            "and br2.chapter < br.chapter " +
            "and br2.author = br.author " +
            "and br2.vol = br.vol " +
            "and br2.article_page = br.article_page " +
            "and br2.article_primary = 1 " +
            ") " +
            "group by bb.bookid, br.chapter, br.author, br.vol, br.article_page " +
            ") a inner join mse_bible_ref br " +
            "on a.author = br.author " +
            "and a.vol = br.vol " +
            "and a.article_page = br.article_page " +
            "and br.article_primary = 1 " +
            "group by a.bookid, a.bookname, a.chapter, a.author, a.vol, a.article_page, a.localrow, a.article, a.scriptures " +
            "order by br.chapter, br.author, br.vol, br.article_page ";

          _cmdRelArticles = new MySqlCommand(sql, Connection);
          _cmdRelArticles.Prepare();

          _cmdRelArticles.Parameters.Add("?bookid", MySqlDbType.Int32);
          _cmdRelArticles.Parameters.Add("?chapter", MySqlDbType.Int32);

        }

        _cmdRelArticles.Parameters["?bookid"].Value = bookid;
        _cmdRelArticles.Parameters["?chapter"].Value = chapter;

        dr = _cmdRelArticles.ExecuteReader();

        do
        {
          while (dr.Read())
          {
            inits = dr.GetString(0);
            if (authors.Contains(inits))
            {
              vol = new Volume(authors[inits], dr.GetInt32(1));
              article = new Article(vol, dr.GetInt32(2), 1, dr.GetInt32(3), dr.GetString(6));

              rval.Add(article);
            }
          }
        } while (dr.NextResult());

        dr.Close();
      }

      return rval;
    }

    public AuthorCollection GetAuthors()
    {
      MySqlDataReader dr;
      Author author;
      AuthorCollection rval = new AuthorCollection();

      lock (_semaphore)
      {
        if (_cmdAuthor == null)
        {
          string sql =
            "SELECT author,name,fullname,orgname " +
            "FROM mse_author " +
            "WHERE author <> 'GRC' ";

          _cmdAuthor = new MySqlCommand(sql, Connection);
        }
        dr = _cmdAuthor.ExecuteReader();

        do
        {
          while (dr.Read())
          {
            author = new Author(dr.GetString(0), dr.GetString(1), dr.GetString(2), dr.GetString(3));

            rval.Add(author);
          }
        } while (dr.NextResult());

        dr.Close();
      }

      return rval;
    }

    public DataSet GetAuthorDataset()
    {
      DataSet ds = new DataSet();

      lock (_semaphore)
      {
        if (_dadAuthor == null)
        {
          string sql =
            "SELECT author, name " +
            "FROM mse_author " +
            "WHERE author <> 'GRC' " +
            "ORDER BY name";

          _dadAuthor = new MySqlDataAdapter(sql, Connection);
        }

        _dadAuthor.Fill(ds, "Author");
      }

      return ds;
    }

    public DataSet GetBuildErrorDataset()
    {
      DataSet ds = new DataSet();

      lock (_semaphore)
      {
        if (_dadBuildError == null)
        {
          string sql =
            "SELECT author, vol, page, para, ref, error_code, text " +
            "FROM mse_bible_ref_error " +
            "ORDER BY author, vol, page, para, error_code, ref";

          _dadBuildError = new MySqlDataAdapter(sql, Connection);
        }

        _dadBuildError.Fill(ds, "BuildError");
      }

      return ds;
    }

    public DataTable GetArticles(Volume vol)
    {
      if (_cmdArticles == null)
      {
        string sql =
          "SELECT page,article,scriptures,localrow " +
          "FROM mse_article " +
          "WHERE author = ?author " +
          "AND vol = ?vol " +
          "ORDER BY page DESC";

        _cmdArticles = new MySqlCommand(sql, Connection);
        _cmdArticles.Prepare();

        _cmdArticles.Parameters.Add("?author", MySqlDbType.String);
        _cmdArticles.Parameters.Add("?vol", MySqlDbType.Int32);
      }

      _cmdArticles.Parameters["?author"].Value = vol.Author.Inits;
      _cmdArticles.Parameters["?vol"].Value = vol.Vol;

      DataTable dt = new DataTable("mse_article");
      MySqlDataAdapter da = new MySqlDataAdapter(_cmdArticles);
      da.Fill(dt);
      return dt;
    }

    public DataTable GetText(Volume vol)
    {
      if (_cmdText == null)
      {
        string sql =
          "SELECT page,para,article_page,text,inits,newpages " +
          "FROM mse_text " +
          "WHERE author = ?author " +
          "AND vol = ?vol " +
          "ORDER BY page,para";

        _cmdText = new MySqlCommand(sql, Connection);
        _cmdText.Prepare();

        _cmdText.Parameters.Add("?author", MySqlDbType.String);
        _cmdText.Parameters.Add("?vol", MySqlDbType.Int32);
      }

      _cmdText.Parameters["?author"].Value = vol.Author.Inits;
      _cmdText.Parameters["?vol"].Value = vol.Vol;

      DataTable dt = new DataTable("mse_text");
      MySqlDataAdapter da = new MySqlDataAdapter(_cmdText);
      da.Fill(dt);
      return dt;
    }

    public DataTable GetScriptureText(Volume vol)
    {
      if (_cmdText == null)
      {
        string sql =
          "select a.bookid, a.bookname, a.chapter, a.author, a.vol, a.article_page, " +
          "t.page, t.para, t.inits, t.text, t.newpages " +
          "from ( " +
          "select bb.bookid, min(bb.bookname) bookname, min(br.chapter) chapter, " +
          "br.author, br.vol, br.article_page,  " +
          "min(a.article) article, min(a.scriptures) scriptures " +
          "from mse_bible_ref br " +
          "inner join mse_bible_book bb " +
          "on bb.bookid = br.bookid " +
          "inner join mse_article a " +
          "on a.author = br.author " +
          "and a.vol = br.vol " +
          "and a.page = br.page " +
          "where article_primary = 1 " +
          "and br.bookid = ?bookid " +
          "group by bb.bookid, br.author, br.vol, br.article_page " +
          ") a inner join mse_text t " +
          "on t.author = a.author " +
          "and t.vol = a.vol " +
          "and t.article_page = a.article_page " +
          "order by bookid, chapter, t.author, t.vol, t.page, t.para";
        _cmdText = new MySqlCommand(sql, Connection);
        _cmdText.Prepare();

        _cmdText.Parameters.Add("?bookid", MySqlDbType.Int32);
      }

      _cmdText.Parameters["?bookid"].Value = vol.Vol;

      DataTable dt = new DataTable("mse_text");
      MySqlDataAdapter da = new MySqlDataAdapter(_cmdText);
      da.Fill(dt);
      return dt;
    }

    public DataTable GetCollectionText(Volume vol)
    {
      if (_cmdText == null)
      {
        string sql =
          "select c.collectionid bookid, c.collectionname bookname, ca.articleno, a.author, a.vol, a.page article_page, " +
          "t.page, t.para, t.inits, t.text, t.newpages " +
          "from mse_collection c " +
          "inner join mse_collection_article ca on ca.collectionid = c.collectionid " +
          "inner join mse_article a on a.author=ca.author and a.vol=ca.vol and a.page=ca.page " +
          "inner join mse_text t on t.author=a.author and t.vol=a.vol and t.article_page=a.page " +
          "where c.collectionid = ?collectionid " +
          "order by c.collectionid, ca.articleno, t.author, t.vol, t.page, t.para ";
        _cmdText = new MySqlCommand(sql, Connection);
        _cmdText.Prepare();

        _cmdText.Parameters.Add("?collectionid", MySqlDbType.Int32);
      }

      _cmdText.Parameters["?collectionid"].Value = vol.Vol;

      DataTable dt = new DataTable("mse_text");
      MySqlDataAdapter da = new MySqlDataAdapter(_cmdText);
      da.Fill(dt);
      return dt;
    }

    public DataTable GetBibleRefs(Volume vol)
    {
      if (_cmdBibleRef == null)
      {
        string sql =
          "SELECT page,para,ref,article_page,article_primary,bookid,chapter,vstart,vend " +
          "FROM mse_bible_ref " +
          "WHERE author = ?author " +
          "AND vol = ?vol " +
          "ORDER BY page,para,ref";

        _cmdBibleRef = new MySqlCommand(sql, Connection);
        _cmdBibleRef.Prepare();

        _cmdBibleRef.Parameters.Add("?author", MySqlDbType.String);
        _cmdBibleRef.Parameters.Add("?vol", MySqlDbType.Int32);
      }

      _cmdBibleRef.Parameters["?author"].Value = vol.Author.Inits;
      _cmdBibleRef.Parameters["?vol"].Value = vol.Vol;

      DataTable dt = new DataTable("mse_bible_ref");
      MySqlDataAdapter da = new MySqlDataAdapter(_cmdBibleRef);
      da.Fill(dt);
      return dt;
    }

    public void InsertParagraph(Paragraph para)
    {
      if (_cmdInsertText == null)
      {
        string sql =
          "INSERT INTO mse_text (" +
            "author, vol, page, para, article_page, localrow, inits, text, newpages" +
          ") VALUES (" +
            "?author, ?vol, ?pageNo, ?para, ?articlePage, ?localRow, ?inits, ?text, ?newPages" +
          ")";

        _cmdInsertText = new MySqlCommand(sql, Connection);
        _cmdInsertText.Prepare();

        _cmdInsertText.Parameters.Add("?author", MySqlDbType.String);
        _cmdInsertText.Parameters.Add("?vol", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?pageNo", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?para", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?articlePage", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?localRow", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?inits", MySqlDbType.String);
        _cmdInsertText.Parameters.Add("?text", MySqlDbType.String);
        _cmdInsertText.Parameters.Add("?newPages", MySqlDbType.String);
      }

      _cmdInsertText.Parameters["?author"].Value = para.Volume.Author.Inits;
      _cmdInsertText.Parameters["?vol"].Value = para.Volume.Vol;
      _cmdInsertText.Parameters["?pageNo"].Value = para.PageNo;
      _cmdInsertText.Parameters["?para"].Value = para.Para;
      _cmdInsertText.Parameters["?articlePage"].Value = para.Article.PageNo;
      _cmdInsertText.Parameters["?localRow"].Value = para.LocalRow;
      _cmdInsertText.Parameters["?inits"].Value = para.Inits;
      _cmdInsertText.Parameters["?text"].Value = para.Text;

      if (para.NewPages.Length == 0)
      {
        _cmdInsertText.Parameters["?newPages"].Value = DBNull.Value;
      }
      else
      {
        _cmdInsertText.Parameters["?newPages"].Value = para.NewPages;
      }

      _cmdInsertText.ExecuteNonQuery();
    }

    public void InsertBibleRef(Paragraph paragraph, int refNo, BibleRef bref)
    {
      if (_cmdInsertBibleRef == null)
      {
        string sql =
          "INSERT INTO mse_bible_ref (" +
           "author, vol, page, para, ref, article_page, article_primary, " +
            "bookid, chapter, vstart, vend" +
          ") VALUES (" +
            "?author, ?vol, ?pageNo, ?para, ?ref, ?article_page, ?article_primary, " +
            "?bookId, ?chapter, ?vStart, ?vEnd" +
          ")";

        _cmdInsertBibleRef = new MySqlCommand(sql, Connection);
        _cmdInsertBibleRef.Prepare();

        _cmdInsertBibleRef.Parameters.Add("?author", MySqlDbType.String);
        _cmdInsertBibleRef.Parameters.Add("?vol", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?pageNo", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?para", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?ref", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?article_page", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?article_primary", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?bookId", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?chapter", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?vStart", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?vEnd", MySqlDbType.Int32);
      }

      _cmdInsertBibleRef.Parameters["?author"].Value = paragraph.Volume.Author.Inits;
      _cmdInsertBibleRef.Parameters["?vol"].Value = paragraph.Volume.Vol;
      _cmdInsertBibleRef.Parameters["?pageNo"].Value = paragraph.PageNo;
      _cmdInsertBibleRef.Parameters["?para"].Value = paragraph.Para;
      _cmdInsertBibleRef.Parameters["?ref"].Value = refNo;
      _cmdInsertBibleRef.Parameters["?article_page"].Value = paragraph.Article.PageNo;
      _cmdInsertBibleRef.Parameters["?article_primary"].Value = (bref.ArticlePrimary ? 1 : 0);
      _cmdInsertBibleRef.Parameters["?bookId"].Value = bref.Book.BookId;
      _cmdInsertBibleRef.Parameters["?chapter"].Value = bref.Chapter;
      _cmdInsertBibleRef.Parameters["?vStart"].Value = bref.VerseStart;
      _cmdInsertBibleRef.Parameters["?vEnd"].Value = bref.VerseEnd;

      _cmdInsertBibleRef.ExecuteNonQuery();
    }

    public void InsertBadBibleRef(Volume vol, int pageNo, int para, int refNo, char errCode, string text)
    {
      if (_cmdInsertBadBibleRef == null)
      {
        string sql =
          "INSERT INTO mse_bible_ref_error (" +
           "author, vol, page, para, ref, " +
            "error_code, text" +
          ") VALUES (" +
            "?author, ?vol, ?pageNo, ?para, ?ref, " +
            "?errCode, ?text" +
          ")";

        _cmdInsertBadBibleRef = new MySqlCommand(sql, Connection);
        _cmdInsertBadBibleRef.Prepare();

        _cmdInsertBadBibleRef.Parameters.Add("?author", MySqlDbType.String);
        _cmdInsertBadBibleRef.Parameters.Add("?vol", MySqlDbType.Int32);
        _cmdInsertBadBibleRef.Parameters.Add("?pageNo", MySqlDbType.Int32);
        _cmdInsertBadBibleRef.Parameters.Add("?para", MySqlDbType.Int32);
        _cmdInsertBadBibleRef.Parameters.Add("?ref", MySqlDbType.Int32);
        _cmdInsertBadBibleRef.Parameters.Add("?errCode", MySqlDbType.String);
        _cmdInsertBadBibleRef.Parameters.Add("?text", MySqlDbType.String);
      }

      _cmdInsertBadBibleRef.Parameters["?author"].Value = vol.Author.Inits;
      _cmdInsertBadBibleRef.Parameters["?vol"].Value = vol.Vol;
      _cmdInsertBadBibleRef.Parameters["?pageNo"].Value = pageNo;
      _cmdInsertBadBibleRef.Parameters["?para"].Value = para;
      _cmdInsertBadBibleRef.Parameters["?ref"].Value = refNo;
      _cmdInsertBadBibleRef.Parameters["?errCode"].Value = errCode;
      _cmdInsertBadBibleRef.Parameters["?text"].Value = text;

      try
      {
        _cmdInsertBadBibleRef.ExecuteNonQuery();
      }
      catch (MySqlException mse)
      {
        if (mse.Number == 1062)
        {
          // ignore duplicates
        }
        else
        {
          MessageBox.Show(mse.ToString());
        }
      }
    }

    public void UpdateArticle(Article art)
    {
      string sql;

      if (art.Scriptures == null)
      {
        sql = String.Format(
          "REPLACE INTO mse_article ( " +
            "author, vol, article, localrow, page " +
          ") VALUES (" +
            "'{0}', '{1}', '{2}', '{3}', '{4}')",
          art.Volume.Author.Inits, art.Volume.Vol, DatabaseLayer.SqlText(art.Title), art.LocalRow, art.PageNo);
      }
      else
      {
        sql = String.Format(
          "UPDATE mse_article " +
          "SET scriptures = '{0}' " +
          "WHERE author = '{1}' " +
          "AND vol = '{2}' " +
          "AND localrow = '{3}'",
          DatabaseLayer.SqlText(art.Scriptures), art.Volume.Author.Inits, art.Volume.Vol, art.LocalRow);
      }

      ExecuteSql(sql);
    }

    public void TruncateTables()
    {
      this.ExecuteSql("TRUNCATE TABLE mse_article");
      this.ExecuteSql("TRUNCATE TABLE mse_text");
      this.ExecuteSql("TRUNCATE TABLE mse_bible_ref");
    }

    public void DeleteVolume(Volume vol)
    {
      this.ExecuteSql(String.Format("UPDATE mse_volume SET added=NOW() WHERE author = '{0}' and vol = {1}", vol.Author.Inits, vol.Vol), true);
      this.ExecuteSql(String.Format("DELETE FROM mse_article WHERE author = '{0}' and vol = {1}", vol.Author.Inits, vol.Vol), true);
      this.ExecuteSql(String.Format("DELETE FROM mse_text WHERE author = '{0}' and vol = {1}", vol.Author.Inits, vol.Vol), true);
      this.ExecuteSql(String.Format("DELETE FROM mse_bible_ref WHERE author = '{0}' and vol = {1}", vol.Author.Inits, vol.Vol), true);
      this.ExecuteSql(String.Format("DELETE FROM mse_bible_ref_error WHERE author = '{0}' and vol = {1}", vol.Author.Inits, vol.Vol), true);
    }

    public void SaveBibleBook(BibleBook book)
    {
      DeleteVerse(book);
      DeleteFootnoteRef(book);
      DeleteFootnote(book);

      foreach (BibleVerse verse in book.Verses)
      {
        InsertVerse(verse);
      }

      foreach (BibleFootnote footnote in book.Footnotes)
      {
        InsertFootnote(footnote);

        foreach (BibleFootnoteRef fRef in footnote.Refs)
        {
          InsertFootnoteRef(fRef);
        }

        foreach (BibleXref xref in footnote)
        {
          InsertFootnoteXref(xref);
        }
      }
    }

    public void DeleteVerse(BibleBook book)
    {
      if (_cmdDeleteVerse == null)
      {
        string sql =
          "DELETE FROM mse_bible_text " +
          "WHERE verid = ?verid " +
          "AND bookid = ?bookid";

        _cmdDeleteVerse = new MySqlCommand(sql, Connection);
        _cmdDeleteVerse.Prepare();

        _cmdDeleteVerse.Parameters.Add("?verid", MySqlDbType.Int32);
        _cmdDeleteVerse.Parameters.Add("?bookid", MySqlDbType.Int32);
      }

      _cmdDeleteVerse.Parameters["?verid"].Value = book.Version.VersionId;
      _cmdDeleteVerse.Parameters["?bookid"].Value = book.BookId;

      _cmdDeleteVerse.ExecuteNonQuery();
    }

    public void DeleteFootnoteRef(BibleBook book)
    {
      //DeleteFootnoteXref1(book);
      //DeleteFootnoteXref2(book);
    }

    protected void DeleteFootnoteXref1(BibleBook book)
    {
      if (_cmdDeleteFootnoteXref1 == null)
      {
        string sql =
          "DELETE FROM mse_bible_footnote_xref " +
          "WHERE EXISTS (SELECT 1 FROM mse_bible_footnote " +
                        "WHERE verid = ?verid " +
                        "AND bookid = ?bookid " +
                        "AND footnoteid = mse_bible_footnote_xref.footnoteid)";
        _cmdDeleteFootnoteXref1 = new MySqlCommand(sql, Connection);
        _cmdDeleteFootnoteXref1.Prepare();

        _cmdDeleteFootnoteXref1.Parameters.Add("?verid", MySqlDbType.Int32);
        _cmdDeleteFootnoteXref1.Parameters.Add("?bookid", MySqlDbType.Int32);
      }

      _cmdDeleteFootnoteXref1.Parameters["?verid"].Value = book.Version.VersionId;
      _cmdDeleteFootnoteXref1.Parameters["?bookid"].Value = book.BookId;

      _cmdDeleteFootnoteXref1.ExecuteNonQuery();
    }

    protected void DeleteFootnoteXref2(BibleBook book)
    {
      if (_cmdDeleteFootnoteXref2 == null)
      {
        string sql =
          "DELETE FROM mse_bible_footnote_xref " +
          "WHERE EXISTS (SELECT 1 FROM mse_bible_footnote " +
                        "WHERE verid = ?verid " +
                        "AND bookid = ?bookid " +
                        "AND footnoteid = mse_bible_footnote_xref.from_footnoteid) " +
         "AND from_footnoteid IS NOT NULL";

        _cmdDeleteFootnoteXref2 = new MySqlCommand(sql, Connection);
        _cmdDeleteFootnoteXref2.Prepare();

        _cmdDeleteFootnoteXref2.Parameters.Add("?verid", MySqlDbType.Int32);
        _cmdDeleteFootnoteXref2.Parameters.Add("?bookid", MySqlDbType.Int32);
      }

      _cmdDeleteFootnoteXref2.Parameters["?verid"].Value = book.Version.VersionId;
      _cmdDeleteFootnoteXref2.Parameters["?bookid"].Value = book.BookId;

      _cmdDeleteFootnoteXref2.ExecuteNonQuery();
    }

    public void DeleteFootnote(BibleBook book)
    {
      if (_cmdDeleteFootnote == null)
      {
        string sql =
          "DELETE FROM mse_bible_footnote " +
          "WHERE verid = ?verid " +
          "AND bookid = ?bookid";

        _cmdDeleteFootnote = new MySqlCommand(sql, Connection);
        _cmdDeleteFootnote.Prepare();

        _cmdDeleteFootnote.Parameters.Add("?verid", MySqlDbType.Int32);
        _cmdDeleteFootnote.Parameters.Add("?bookid", MySqlDbType.Int32);
      }

      _cmdDeleteFootnote.Parameters["?verid"].Value = book.Version.VersionId;
      _cmdDeleteFootnote.Parameters["?bookid"].Value = book.BookId;

      _cmdDeleteFootnote.ExecuteNonQuery();
    }

    public void InsertVerse(BibleVerse verse)
    {
      if (_cmdInsertVerse == null)
      {
        string sql =
          "INSERT INTO mse_bible_text (" +
            "verid, bookid, chapter, verse, text" +
          ") VALUES (" +
            "?verid, ?bookid, ?chapter, ?verse, ?text" +
          ")";

        _cmdInsertVerse = new MySqlCommand(sql, Connection);
        _cmdInsertVerse.Prepare();

        _cmdInsertVerse.Parameters.Add("?verid", MySqlDbType.Int32);
        _cmdInsertVerse.Parameters.Add("?bookid", MySqlDbType.Int32);
        _cmdInsertVerse.Parameters.Add("?chapter", MySqlDbType.Int32);
        _cmdInsertVerse.Parameters.Add("?verse", MySqlDbType.Int32);
        _cmdInsertVerse.Parameters.Add("?text", MySqlDbType.String);
      }

      _cmdInsertVerse.Parameters["?verid"].Value = verse.Book.Version.VersionId;
      _cmdInsertVerse.Parameters["?bookid"].Value = verse.Book.BookId;
      _cmdInsertVerse.Parameters["?chapter"].Value = verse.Chapter;
      _cmdInsertVerse.Parameters["?verse"].Value = verse.Verse;
      _cmdInsertVerse.Parameters["?text"].Value = verse.Text;

      _cmdInsertVerse.ExecuteNonQuery();
    }

    public void InsertFootnote(BibleFootnote footnote)
    {
      if (_cmdInsertFootnote == null)
      {
        string sql =
          "INSERT INTO mse_bible_footnote (" +
            "footnoteid, verid, bookid, chapter, verse, symbol, text" +
          ") VALUES (" +
            "?footnoteid, ?verid, ?bookid, ?chapter, ?verse, ?symbol, ?text" +
          ")";

        _cmdInsertFootnote = new MySqlCommand(sql, Connection);
        _cmdInsertFootnote.Prepare();

        _cmdInsertFootnote.Parameters.Add("?footnoteid", MySqlDbType.Int32);
        _cmdInsertFootnote.Parameters.Add("?verid", MySqlDbType.Int32);
        _cmdInsertFootnote.Parameters.Add("?bookid", MySqlDbType.Int32);
        _cmdInsertFootnote.Parameters.Add("?chapter", MySqlDbType.Int32);
        _cmdInsertFootnote.Parameters.Add("?verse", MySqlDbType.Int32);
        _cmdInsertFootnote.Parameters.Add("?symbol", MySqlDbType.VarChar);
        _cmdInsertFootnote.Parameters.Add("?text", MySqlDbType.String);
      }

      _cmdInsertFootnote.Parameters["?footnoteid"].Value = footnote.FoonoteId;
      _cmdInsertFootnote.Parameters["?verid"].Value = footnote.Book.Version.VersionId;
      _cmdInsertFootnote.Parameters["?bookid"].Value = footnote.Book.BookId;
      _cmdInsertFootnote.Parameters["?chapter"].Value = footnote.Chapter;
      _cmdInsertFootnote.Parameters["?verse"].Value = footnote.Verse;
      _cmdInsertFootnote.Parameters["?symbol"].Value = footnote.Symbol;
      _cmdInsertFootnote.Parameters["?text"].Value = footnote.Text;

      _cmdInsertFootnote.ExecuteNonQuery();
    }

    public void InsertFootnoteRef(BibleFootnoteRef fref)
    {
      if (_cmdInsertFootnoteRef == null)
      {
        string sql =
          "INSERT INTO mse_bible_footnote_ref (" +
            "footnoteid, verid, bookid, chapter, verse, refid, phrase" +
          ") VALUES (" +
            "?footnoteid, ?verid, ?bookid, ?chapter, ?verse, ?refid, ?phrase" +
          ")";

        _cmdInsertFootnoteRef = new MySqlCommand(sql, Connection);
        _cmdInsertFootnoteRef.Prepare();

        _cmdInsertFootnoteRef.Parameters.Add("?footnoteid", MySqlDbType.Int32);
        _cmdInsertFootnoteRef.Parameters.Add("?verid", MySqlDbType.Int32);
        _cmdInsertFootnoteRef.Parameters.Add("?bookid", MySqlDbType.Int32);
        _cmdInsertFootnoteRef.Parameters.Add("?chapter", MySqlDbType.Int32);
        _cmdInsertFootnoteRef.Parameters.Add("?verse", MySqlDbType.Int32);
        _cmdInsertFootnoteRef.Parameters.Add("?refid", MySqlDbType.Int32);
        _cmdInsertFootnoteRef.Parameters.Add("?phrase", MySqlDbType.String);
      }

      _cmdInsertFootnoteRef.Parameters["?footnoteid"].Value = fref.Footnote.FoonoteId;
      _cmdInsertFootnoteRef.Parameters["?verid"].Value = fref.Footnote.Book.Version.VersionId;
      _cmdInsertFootnoteRef.Parameters["?bookid"].Value = fref.Footnote.Book.BookId;
      _cmdInsertFootnoteRef.Parameters["?chapter"].Value = fref.Chapter;
      _cmdInsertFootnoteRef.Parameters["?verse"].Value = fref.Verse;
      _cmdInsertFootnoteRef.Parameters["?refid"].Value = fref.RefId;
      _cmdInsertFootnoteRef.Parameters["?phrase"].Value = fref.Phrase;

      _cmdInsertFootnoteRef.ExecuteNonQuery();
    }

    public void InsertFootnoteXref(BibleXref xref)
    {
      BibleFootnote refTo = xref.RefTo as BibleFootnote;
      BibleVerse refFrom = xref.RefFrom;

      if (_cmdInsertFootnoteXref == null)
      {
        string sql =
          "INSERT INTO mse_bible_footnote_xref (" +
            "footnoteid, verid, bookid, chapter, verse, xrefid, from_footnoteid, phrase" +
          ") VALUES (" +
            "?footnoteid, ?verid, ?bookid, ?chapter, ?verse, ?xrefid, ?from_footnoteid, ?phrase" +
          ")";

        _cmdInsertFootnoteXref = new MySqlCommand(sql, Connection);
        _cmdInsertFootnoteXref.Prepare();

        _cmdInsertFootnoteXref.Parameters.Add("?footnoteid", MySqlDbType.Int32);
        _cmdInsertFootnoteXref.Parameters.Add("?verid", MySqlDbType.Int32);
        _cmdInsertFootnoteXref.Parameters.Add("?bookid", MySqlDbType.Int32);
        _cmdInsertFootnoteXref.Parameters.Add("?chapter", MySqlDbType.Int32);
        _cmdInsertFootnoteXref.Parameters.Add("?verse", MySqlDbType.Int32);
        _cmdInsertFootnoteXref.Parameters.Add("?xrefid", MySqlDbType.Int32);
        _cmdInsertFootnoteXref.Parameters.Add("?from_footnoteid", MySqlDbType.Int32);
        _cmdInsertFootnoteXref.Parameters.Add("?phrase", MySqlDbType.String);
      }

      _cmdInsertFootnoteXref.Parameters["?footnoteid"].Value = refTo.FoonoteId;
      _cmdInsertFootnoteXref.Parameters["?verid"].Value = refFrom.Book.Version.VersionId;
      _cmdInsertFootnoteXref.Parameters["?bookid"].Value = refFrom.Book.BookId;
      _cmdInsertFootnoteXref.Parameters["?chapter"].Value = refFrom.Chapter;
      _cmdInsertFootnoteXref.Parameters["?verse"].Value = refFrom.Verse;
      _cmdInsertFootnoteXref.Parameters["?xrefid"].Value = xref.InstanceId;

      if (xref.RefFrom is BibleFootnote)
      {
        _cmdInsertFootnoteXref.Parameters["?from_footnoteid"].Value = ((BibleFootnote)refFrom).FoonoteId;
      }
      else
      {
        _cmdInsertFootnoteXref.Parameters["?from_footnoteid"].Value = DBNull.Value;
      }

      _cmdInsertFootnoteXref.Parameters["?phrase"].Value = xref.Word;

      _cmdInsertFootnoteXref.ExecuteNonQuery();
    }

    public void ExecuteSql(string sql)
    {
      ExecuteSql(sql, false);
    }

    public void ExecuteSql(string sql, bool longRunning)
    {
      MySqlCommand cmd = new MySqlCommand(sql, Connection);

      if (longRunning)
      {
        cmd.CommandTimeout = 300;
      }

      cmd.ExecuteNonQuery();
    }

    public static string SqlText(object text)
    {
      return SqlText(text.ToString(), false);
    }

    public static string SqlText(string text)
    {
      return SqlText(text, false);
    }

    public static string SqlText(string text, bool quotes)
    {
      text = text.Replace("'", "\\'");
      if (quotes)
      {
        text = String.Format("'{0}'", text);
      }
      return text;
    }

    public static bool IsInteger(string text)
    {
      if (text.Length == 0) return true;

      try
      {
        Int32.Parse(text);
      }
      catch (Exception)
      {
        return false;
      }

      return true;
    }

    public DataTable GetHymns(Language language)
    {
      string sql =
        "SELECT h.hymn_no, h.author_id, a.fullname, a.author_life, " +
          "h.meter, " +
          "h.meter_id, " +
          "hl.line_text AS first_line_text " +
        "FROM hymn" + Languages.LanguageSuffix(language) + " h, authors a, " +
        "hymn_line" + Languages.LanguageSuffix(language) + " hl " +
        "WHERE h.author_id = a.id " +
        "AND hl.hymn_no = h.hymn_no AND hl.vers_no = 1 AND hl.line_no = 1 " +
        "ORDER BY 1";

      MySqlDataAdapter dad = new MySqlDataAdapter(sql, Connection);
      DataTable rval = new DataTable();
      dad.Fill(rval);

      return rval;
    }

    public DataTable GetHymnText(Language language, long hymnNo)
    {
      string sql =
        "select vers_no, line_no, line_text " +
        "from hymn_line" + Languages.LanguageSuffix(language) + " " +
        "where hymn_no=" + hymnNo + " " +
        "order by if(vers_no=99,11,vers_no*10),line_no";

      MySqlDataAdapter dad = new MySqlDataAdapter(sql, Connection);
      DataTable rval = new DataTable();
      dad.Fill(rval);

      return rval;
    }

    public DataTable GetHymnAuthors(Language language)
    {
      string sql =
        "SELECT ha.id, ha.fullname, ha.surname, ha.firstnames, ha.author_life, h.hymn_no " +
        "FROM authors ha, hymn" + Languages.LanguageSuffix(language) + " h " +
        "WHERE h.author_id = ha.id " +
        "ORDER BY 3,4,2,6 ";

      MySqlDataAdapter dad = new MySqlDataAdapter(sql, Connection);
      DataTable rval = new DataTable();
      dad.Fill(rval);

      return rval;
    }

    public DataTable GetHymnMeters(Language language)
    {
      string sql =
        "SELECT hm.id, hm.meter, hm.rhythm, hm.chorus, hm.disp_order, h.hymn_no " +
        "FROM hymn_meter hm, hymn" + Languages.LanguageSuffix(language) + " h " +
        "WHERE h.meter_id = hm.id " +
        "ORDER BY 5,2,3,4,1,6 ";

      MySqlDataAdapter dad = new MySqlDataAdapter(sql, Connection);
      DataTable rval = new DataTable();
      dad.Fill(rval);

      return rval;
    }
  }
}
