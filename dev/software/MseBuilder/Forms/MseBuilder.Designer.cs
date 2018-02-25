/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  11-May-2008  10264 : Replaced FlexCell with DataGridView.
 * CAM  18-May-2008  10267 : Moved buttons to new toolbar.
 * CAM  28-Mar-2009  10409 : Added call to Footnote parser.
 * CAM  28-Mar-2009  10412 : Use new Bugzilla table adapter.
 * CAM  15-Jan-2010  10528 : Added button for CreateBbebReaderFiles.
 * CAM  19-Jan-2010  10540 : Added button for CreateEpubFiles.
 * CAM  23-Jan-2010  10551 : Added button for ParseJndHthmlFiles.
 * CAM  22-Feb-2018  732482 : Added CreateEpubCollections.
 * * * * * * * * * * * * * * * * * * * * * * * */

using FrontBurner.Ministry.MseBuilder.Data;

namespace FrontBurner.Ministry.MseBuilder
{
  partial class MseBuilder
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      this.components = new System.ComponentModel.Container();
      this.cmbAuthor = new System.Windows.Forms.ComboBox();
      this.label1 = new System.Windows.Forms.Label();
      this.label2 = new System.Windows.Forms.Label();
      this.txtVol = new System.Windows.Forms.TextBox();
      this.pgbVol = new System.Windows.Forms.ProgressBar();
      this.grdArticle = new System.Windows.Forms.DataGridView();
      this.tmrRefresh = new System.Windows.Forms.Timer(this.components);
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this._tsbBuild = new System.Windows.Forms.ToolStripButton();
      this._tsbZip = new System.Windows.Forms.ToolStripButton();
      this._tsbVersionHistory = new System.Windows.Forms.ToolStripButton();
      this._tsbBible = new System.Windows.Forms.ToolStripButton();
      this._tsbCreateEpub = new System.Windows.Forms.ToolStripButton();
      this._tsbCreateCollections = new System.Windows.Forms.ToolStripButton();
      this._tsbCreateEpubScripture = new System.Windows.Forms.ToolStripButton();
      this._tsbEpubHymn = new System.Windows.Forms.ToolStripButton();
      this.tabResults = new System.Windows.Forms.TabControl();
      this.tabArticles = new System.Windows.Forms.TabPage();
      this.tabBuildErrors = new System.Windows.Forms.TabPage();
      this.grdError = new System.Windows.Forms.DataGridView();
      ((System.ComponentModel.ISupportInitialize)(this.grdArticle)).BeginInit();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      this._tspMain.SuspendLayout();
      this.tabResults.SuspendLayout();
      this.tabArticles.SuspendLayout();
      this.tabBuildErrors.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.grdError)).BeginInit();
      this.SuspendLayout();
      // 
      // cmbAuthor
      // 
      this.cmbAuthor.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmbAuthor.FormattingEnabled = true;
      this.cmbAuthor.Location = new System.Drawing.Point(206, 6);
      this.cmbAuthor.Margin = new System.Windows.Forms.Padding(6);
      this.cmbAuthor.Name = "cmbAuthor";
      this.cmbAuthor.Size = new System.Drawing.Size(382, 39);
      this.cmbAuthor.TabIndex = 1;
      // 
      // label1
      // 
      this.label1.AutoSize = true;
      this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(6, 0);
      this.label1.Margin = new System.Windows.Forms.Padding(6, 0, 6, 0);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(104, 31);
      this.label1.TabIndex = 2;
      this.label1.Text = "Author";
      // 
      // label2
      // 
      this.label2.AutoSize = true;
      this.label2.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label2.Location = new System.Drawing.Point(6, 58);
      this.label2.Margin = new System.Windows.Forms.Padding(6, 0, 6, 0);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(113, 31);
      this.label2.TabIndex = 3;
      this.label2.Text = "Volume";
      // 
      // txtVol
      // 
      this.txtVol.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtVol.Location = new System.Drawing.Point(206, 64);
      this.txtVol.Margin = new System.Windows.Forms.Padding(6);
      this.txtVol.Name = "txtVol";
      this.txtVol.Size = new System.Drawing.Size(124, 39);
      this.txtVol.TabIndex = 4;
      // 
      // pgbVol
      // 
      this.tableLayoutPanel1.SetColumnSpan(this.pgbVol, 3);
      this.pgbVol.Dock = System.Windows.Forms.DockStyle.Fill;
      this.pgbVol.Location = new System.Drawing.Point(6, 122);
      this.pgbVol.Margin = new System.Windows.Forms.Padding(6);
      this.pgbVol.Name = "pgbVol";
      this.pgbVol.Size = new System.Drawing.Size(1939, 46);
      this.pgbVol.TabIndex = 5;
      // 
      // grdArticle
      // 
      this.grdArticle.Dock = System.Windows.Forms.DockStyle.Fill;
      this.grdArticle.Location = new System.Drawing.Point(3, 3);
      this.grdArticle.Margin = new System.Windows.Forms.Padding(6);
      this.grdArticle.Name = "grdArticle";
      this.grdArticle.ReadOnly = true;
      this.grdArticle.ShowEditingIcon = false;
      this.grdArticle.Size = new System.Drawing.Size(1923, 906);
      this.grdArticle.TabIndex = 6;
      // 
      // tmrRefresh
      // 
      this.tmrRefresh.Tick += new System.EventHandler(this.tmrRefresh_Tick);
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this.tableLayoutPanel1);
      this.toolStripContainer1.ContentPanel.Margin = new System.Windows.Forms.Padding(6);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(1951, 1139);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Margin = new System.Windows.Forms.Padding(6);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(1951, 1194);
      this.toolStripContainer1.TabIndex = 8;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this._tspMain);
      // 
      // tableLayoutPanel1
      // 
      this.tableLayoutPanel1.ColumnCount = 3;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 200F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 1028F));
      this.tableLayoutPanel1.Controls.Add(this.label1, 0, 0);
      this.tableLayoutPanel1.Controls.Add(this.cmbAuthor, 1, 0);
      this.tableLayoutPanel1.Controls.Add(this.label2, 0, 1);
      this.tableLayoutPanel1.Controls.Add(this.pgbVol, 0, 2);
      this.tableLayoutPanel1.Controls.Add(this.txtVol, 1, 1);
      this.tableLayoutPanel1.Controls.Add(this.tabResults, 0, 3);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Margin = new System.Windows.Forms.Padding(6);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 4;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 58F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 58F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 58F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(1951, 1139);
      this.tableLayoutPanel1.TabIndex = 0;
      // 
      // _tspMain
      // 
      this._tspMain.Dock = System.Windows.Forms.DockStyle.None;
      this._tspMain.ImageScalingSize = new System.Drawing.Size(48, 48);
      this._tspMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._tsbBuild,
            this._tsbZip,
            this._tsbVersionHistory,
            this._tsbBible,
            this._tsbCreateEpub,
            this._tsbCreateCollections,
            this._tsbCreateEpubScripture,
            this._tsbEpubHymn});
      this._tspMain.Location = new System.Drawing.Point(3, 0);
      this._tspMain.Name = "_tspMain";
      this._tspMain.Size = new System.Drawing.Size(1075, 55);
      this._tspMain.TabIndex = 0;
      // 
      // _tsbBuild
      // 
      this._tsbBuild.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbBuild.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Build;
      this._tsbBuild.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbBuild.Name = "_tsbBuild";
      this._tsbBuild.Size = new System.Drawing.Size(52, 52);
      this._tsbBuild.Text = "Build Database from source files";
      this._tsbBuild.ToolTipText = "Build";
      this._tsbBuild.Click += new System.EventHandler(this.BuildDatabaseFromSourceFiles);
      // 
      // _tsbZip
      // 
      this._tsbZip.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbZip.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Zip;
      this._tsbZip.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbZip.Name = "_tsbZip";
      this._tsbZip.Size = new System.Drawing.Size(52, 52);
      this._tsbZip.Text = "toolStripButton2";
      this._tsbZip.ToolTipText = "Export to Zip for Web";
      this._tsbZip.Click += new System.EventHandler(this.CreateZippedDataFile);
      // 
      // _tsbVersionHistory
      // 
      this._tsbVersionHistory.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbVersionHistory.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Copy;
      this._tsbVersionHistory.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbVersionHistory.Name = "_tsbVersionHistory";
      this._tsbVersionHistory.Size = new System.Drawing.Size(52, 52);
      this._tsbVersionHistory.Text = "toolStripButton3";
      this._tsbVersionHistory.ToolTipText = "Copy Version History from Bugzilla";
      this._tsbVersionHistory.Click += new System.EventHandler(this.CopyBugzillaVersionHistoryToMySQL);
      // 
      // _tsbBible
      // 
      this._tsbBible.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Bible;
      this._tsbBible.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbBible.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbBible.Name = "_tsbBible";
      this._tsbBible.Size = new System.Drawing.Size(182, 52);
      this._tsbBible.Text = "Parse Bible";
      this._tsbBible.ToolTipText = "Parse Bible";
      this._tsbBible.Click += new System.EventHandler(this.BuildBibleDatabase);
      // 
      // _tsbCreateEpub
      // 
      this._tsbCreateEpub.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Books;
      this._tsbCreateEpub.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbCreateEpub.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbCreateEpub.Name = "_tsbCreateEpub";
      this._tsbCreateEpub.Size = new System.Drawing.Size(122, 52);
      this._tsbCreateEpub.Text = "EPUB";
      this._tsbCreateEpub.Click += new System.EventHandler(this.CreateEpubFiles);
      // 
      // _tsbCreateCollections
      // 
      this._tsbCreateCollections.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Books;
      this._tsbCreateCollections.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbCreateCollections.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbCreateCollections.Name = "_tsbCreateCollections";
      this._tsbCreateCollections.Size = new System.Drawing.Size(184, 52);
      this._tsbCreateCollections.Text = "Collections";
      this._tsbCreateCollections.Click += new System.EventHandler(this.CreateEpubCollections);
      // 
      // _tsbCreateEpubScripture
      // 
      this._tsbCreateEpubScripture.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Books;
      this._tsbCreateEpubScripture.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbCreateEpubScripture.Name = "_tsbCreateEpubScripture";
      this._tsbCreateEpubScripture.Size = new System.Drawing.Size(224, 52);
      this._tsbCreateEpubScripture.Text = "EPUB Scripture";
      this._tsbCreateEpubScripture.Click += new System.EventHandler(this.CreateEpubScriptureFiles);
      // 
      // _tsbEpubHymn
      // 
      this._tsbEpubHymn.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Books;
      this._tsbEpubHymn.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbEpubHymn.Name = "_tsbEpubHymn";
      this._tsbEpubHymn.Size = new System.Drawing.Size(195, 52);
      this._tsbEpubHymn.Text = "Hymnbooks";
      this._tsbEpubHymn.Click += new System.EventHandler(this.CreateEpubHymnFiles);
      // 
      // tabResults
      // 
      this.tableLayoutPanel1.SetColumnSpan(this.tabResults, 3);
      this.tabResults.Controls.Add(this.tabArticles);
      this.tabResults.Controls.Add(this.tabBuildErrors);
      this.tabResults.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tabResults.Location = new System.Drawing.Point(3, 177);
      this.tabResults.Name = "tabResults";
      this.tabResults.SelectedIndex = 0;
      this.tabResults.Size = new System.Drawing.Size(1945, 959);
      this.tabResults.TabIndex = 7;
      // 
      // tabArticles
      // 
      this.tabArticles.Controls.Add(this.grdArticle);
      this.tabArticles.Location = new System.Drawing.Point(8, 39);
      this.tabArticles.Name = "tabArticles";
      this.tabArticles.Padding = new System.Windows.Forms.Padding(3);
      this.tabArticles.Size = new System.Drawing.Size(1929, 912);
      this.tabArticles.TabIndex = 0;
      this.tabArticles.Text = "Articles";
      this.tabArticles.UseVisualStyleBackColor = true;
      // 
      // tabBuildErrors
      // 
      this.tabBuildErrors.Controls.Add(this.grdError);
      this.tabBuildErrors.Location = new System.Drawing.Point(8, 39);
      this.tabBuildErrors.Name = "tabBuildErrors";
      this.tabBuildErrors.Padding = new System.Windows.Forms.Padding(3);
      this.tabBuildErrors.Size = new System.Drawing.Size(1929, 912);
      this.tabBuildErrors.TabIndex = 1;
      this.tabBuildErrors.Text = "Build Errors";
      this.tabBuildErrors.UseVisualStyleBackColor = true;
      // 
      // grdError
      // 
      this.grdError.AllowUserToAddRows = false;
      this.grdError.AllowUserToDeleteRows = false;
      this.grdError.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this.grdError.Dock = System.Windows.Forms.DockStyle.Fill;
      this.grdError.Location = new System.Drawing.Point(3, 3);
      this.grdError.Margin = new System.Windows.Forms.Padding(6);
      this.grdError.Name = "grdError";
      this.grdError.ReadOnly = true;
      this.grdError.Size = new System.Drawing.Size(1923, 906);
      this.grdError.TabIndex = 1;
      // 
      // MseBuilder
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(1951, 1194);
      this.Controls.Add(this.toolStripContainer1);
      this.Margin = new System.Windows.Forms.Padding(6);
      this.Name = "MseBuilder";
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Ministry Search Engine Data Builder";
      this.Load += new System.EventHandler(this.MseBuilder_Load);
      ((System.ComponentModel.ISupportInitialize)(this.grdArticle)).EndInit();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this.tableLayoutPanel1.ResumeLayout(false);
      this.tableLayoutPanel1.PerformLayout();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      this.tabResults.ResumeLayout(false);
      this.tabArticles.ResumeLayout(false);
      this.tabBuildErrors.ResumeLayout(false);
      ((System.ComponentModel.ISupportInitialize)(this.grdError)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ComboBox cmbAuthor;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.TextBox txtVol;
    private System.Windows.Forms.ProgressBar pgbVol;
    private System.Windows.Forms.DataGridView grdArticle;
    private System.Windows.Forms.Timer tmrRefresh;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.ToolStrip _tspMain;
    private System.Windows.Forms.ToolStripButton _tsbBuild;
    private System.Windows.Forms.ToolStripButton _tsbZip;
    private System.Windows.Forms.ToolStripButton _tsbVersionHistory;
    //private MseData mseData;
    private System.Windows.Forms.ToolStripButton _tsbBible;
    private System.Windows.Forms.BindingSource _bdsBugs;
    private System.Windows.Forms.ToolStripButton _tsbCreateEpub;
    private System.Windows.Forms.ToolStripButton _tsbEpubHymn;
    private System.Windows.Forms.ToolStripButton _tsbCreateEpubScripture;
    private System.Windows.Forms.ToolStripButton _tsbCreateCollections;
    private System.Windows.Forms.TabControl tabResults;
    private System.Windows.Forms.TabPage tabArticles;
    private System.Windows.Forms.TabPage tabBuildErrors;
    private System.Windows.Forms.DataGridView grdError;
  }
}

