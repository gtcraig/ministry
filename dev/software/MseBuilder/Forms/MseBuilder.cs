/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10186 : Added Zip! (export).
 * CAM  11-May-2008  10264 : Replaced FlexCell with DataGridView.
 * CAM  11-May-2008  10265 : Allow Zipping of single Volume.
 * CAM  17-May-2008  10266 : Show Errors on completion of Build.
 * CAM  18-May-2008  10267 : Moved buttons to new toolbar, created CopyToMySQL.
 * CAM  28-Mar-2009  10409 : Added call to Footnote parser.
 * CAM  28-Mar-2009  10412 : Call new Bugzilla table adapter.
 * CAM  15-Jan-2010  10528 : Added CreateBbebReaderFiles.
 * CAM  19-Jan-2010  10540 : Added Epub process, and ensure progress is reset after all processes.
 * CAM  23-Jan-2010  10551 : Added ParseJndHthmlFiles.
 * CAM  24-Dec-2010  10902 : Removed plumbing to radios for types.
 * CAM  03-Jan-2011  10917 : Added checks for completion of EpubHymnThread.
 * CAM  03-Jan-2011  10918 : Added radio buttons to set entire session for EPUB or MOBI (because of LI/P issue)
 * CAM  28-Dec-2011  gc005 : Removed redundant code.
 * CAM  31-Dec-2015  886930 : Added button to generate ebooks by Scripture.
 * CAM  22-Feb-2018  732482 : Added CreateEpubCollections.
 * CAM  25-Feb-2018  790063 : Used correct namespace for Data and replaced MseData.xsd with an explicit query.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Text;
using System.Threading;
using System.Windows.Forms;

using FrontBurner.Ministry.MseBuilder.Bible;
using FrontBurner.Ministry.MseBuilder.Data;
using FrontBurner.Ministry.MseBuilder.Engine;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder
{
  public partial class MseBuilder : Form
  {
    private string _author;
    private int _vol;
    private bool _specificVolume;
    private BuilderThread _builder;
    private ZipperThread _zipper;
    private EpubThread _epub;
    private EpubCollectionThread _epubCollection;
    private EpubScriptureThread _epubScripture;
    private EpubHymnThread _epubHymn;

    public MseBuilder()
    {
      InitializeComponent();

      DatabaseLayer.Instance.Open();
    }

    private bool SpecificVolume()
    {
      if (_specificVolume = ((txtVol.Text.Length > 0) && (int.Parse(txtVol.Text) > 0)))
      {
        _author = cmbAuthor.SelectedValue.ToString();
        _vol = int.Parse(txtVol.Text);
      }

      return _specificVolume;
    }

    private void tmrRefresh_Tick(object sender, EventArgs e)
    {
      if (_builder != null)
      {
        if (_builder.Process.IsAlive)
        {
          if (_builder.Engine != null) pgbVol.Value = _builder.Engine.Current;
          this.Refresh();
          this.Update();
        }
        else
        {
          tmrRefresh.Enabled = false;

          if (_specificVolume) ShowArticles();

          if (_builder.AnyErrors)
          {
            tabResults.SelectTab(tabBuildErrors);
            grdError.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            grdError.DataSource = DatabaseLayer.Instance.GetBuildErrorDataset();
            grdError.DataMember = "BuildError";
          }
          else
          {
            tabResults.SelectTab(tabArticles);
          }

          ProcessComplete();
          _builder = null;
        }
      }
      else if (_zipper != null)
      {
        if (_zipper.Process.IsAlive)
        {
          if (_zipper.Engine != null) pgbVol.Value = _zipper.Engine.Current;
          this.Refresh();
          this.Update();
        }
        else
        {
          ProcessComplete();
          _zipper = null;
        }
      }
      else if (_epub != null)
      {
        if (_epub.Process.IsAlive)
        {
          if (_epub.Engine != null) pgbVol.Value = _epub.Engine.Current;
          this.Refresh();
          this.Update();
        }
        else
        {
          ProcessComplete();
          _epub = null;
        }
      }
      else if (_epubScripture != null)
      {
        if (_epubScripture.Process.IsAlive)
        {
          if (_epubScripture.Engine != null) pgbVol.Value = _epubScripture.Engine.Current;
          this.Refresh();
          this.Update();
        }
        else
        {
          ProcessComplete();
          _epubScripture = null;
        }
      }
      else if (_epubCollection != null)
      {
        if (_epubCollection.Process.IsAlive)
        {
          if (_epubCollection.Engine != null) pgbVol.Value = _epubCollection.Engine.Current;
          this.Refresh();
          this.Update();
        }
        else
        {
          ProcessComplete();
          _epubCollection = null;
        }
      }
      else if (_epubHymn != null)
      {
        if (_epubHymn.Process.IsAlive)
        {
          if (_epubHymn.Engine != null) pgbVol.Value = _epubHymn.Engine.Current;
          this.Refresh();
          this.Update();
        }
        else
        {
          ProcessComplete();
          _epubHymn = null;
        }
      }
    }

    protected void ProcessComplete()
    {
      pgbVol.Maximum = pgbVol.Value = 0;
      tmrRefresh.Enabled = false;
      _tspMain.Enabled = true;
    }

    private void MseBuilder_Load(object sender, EventArgs e)
    {
      DataSet ds = DatabaseLayer.Instance.GetAuthorDataset();
      cmbAuthor.DataSource = ds;
      cmbAuthor.DisplayMember = "Author.name";
      cmbAuthor.ValueMember = "Author.author";

      // Article Grid
      grdArticle.Columns.Add("PageNo", "Page No");
      grdArticle.Columns[0].Width = 65;

      grdArticle.Columns.Add("Row", "Row");
      grdArticle.Columns[1].Width = 40;

      grdArticle.Columns.Add("Article", "Article");
      grdArticle.Columns[2].Width = 320;

      grdArticle.Columns.Add("Scriptures", "Scriptures");
      grdArticle.Columns[3].Width = 300;
    }

    protected void ClearArticles()
    {
      BusinessLayer.Instance.Articles.Clear();
      grdArticle.Rows.Clear();
    }

    protected void ShowArticles()
    {
      foreach (Article art in BusinessLayer.Instance.Articles)
      {
        AddArticle(art);
      }

      grdArticle.Refresh();
    }

    protected void AddArticle(Article art)
    {
      DataGridViewRow row = grdArticle.Rows[grdArticle.Rows.Add()];

      row.Cells[0].Value = art.PageNo;
      row.Cells[1].Value = art.LocalRow;
      row.Cells[2].Value = art.Title;
      row.Cells[3].Value = art.Scriptures;
    }

    private void BuildDatabaseFromSourceFiles(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      grdArticle.Rows.Clear();

      ClearArticles();

      SpecificVolume();

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.Volumes.Count;

      _builder = new BuilderThread(_author, _vol, _specificVolume);
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void CreateZippedDataFile(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.Volumes.Count;

      SpecificVolume();

      _zipper = new ZipperThread(_author, _vol, _specificVolume);
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void CopyBugzillaVersionHistoryToMySQL(object sender, EventArgs e)
    {
      //_bugsTableAdapter.CopyToMySQL();
    }

    private void BuildBibleDatabase(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      MseBibleEngine bible = new MseBibleEngine();
      bible.Build();

      _tspMain.Enabled = true;
    }

    private void CreateEpubFiles(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.Volumes.Count;

      SpecificVolume();

      _epub = new EpubThread(_author, _vol, _specificVolume);
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void CreateEpubCollections(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.Collections.Count;

      _epubCollection = new EpubCollectionThread();
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void CreateEpubScriptureFiles(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      pgbVol.Minimum = 0;
      pgbVol.Maximum = BusinessLayer.Instance.Books.Count;

      _epubScripture = new EpubScriptureThread();
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void CreateEpubHymnFiles(object sender, EventArgs e)
    {
      _tspMain.Enabled = false;

      pgbVol.Minimum = 0;
      pgbVol.Maximum = 5;

      _epubHymn = new EpubHymnThread();
      Thread.Sleep(1000);

      tmrRefresh.Enabled = true;
    }

    private void EpubChecked(object sender, EventArgs e)
    {
      EngineSettings.Instance.Mode = BuildMode.StandardEpub;
    }

    private void MobiChecked(object sender, EventArgs e)
    {
      EngineSettings.Instance.Mode = BuildMode.KindleMobiEpub;
    }
  }
}