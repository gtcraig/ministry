/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: MseBuilder.Designer.cs 1311 2011-01-03 23:13:42Z craig $
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
        this._grbOptions = new System.Windows.Forms.GroupBox();
        this._radMobi = new System.Windows.Forms.RadioButton();
        this._radEpub = new System.Windows.Forms.RadioButton();
        this._tspMain = new System.Windows.Forms.ToolStrip();
        this._tsbBuild = new System.Windows.Forms.ToolStripButton();
        this._tsbZip = new System.Windows.Forms.ToolStripButton();
        this._tsbVersionHistory = new System.Windows.Forms.ToolStripButton();
        this._tsbBible = new System.Windows.Forms.ToolStripButton();
        this._tsbCreateEpub = new System.Windows.Forms.ToolStripButton();
        this._tsbEpubHymn = new System.Windows.Forms.ToolStripButton();
        this.mseData = new FrontBurner.Ministry.MseBuilder.Data.MseData();
        this._bdsBugs = new System.Windows.Forms.BindingSource(this.components);
        this._bugsTableAdapter = new FrontBurner.Ministry.MseBuilder.Data.MseDataTableAdapters.CompletedBugsTableAdapter();
        ((System.ComponentModel.ISupportInitialize)(this.grdArticle)).BeginInit();
        this.toolStripContainer1.ContentPanel.SuspendLayout();
        this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
        this.toolStripContainer1.SuspendLayout();
        this.tableLayoutPanel1.SuspendLayout();
        this._grbOptions.SuspendLayout();
        this._tspMain.SuspendLayout();
        ((System.ComponentModel.ISupportInitialize)(this.mseData)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this._bdsBugs)).BeginInit();
        this.SuspendLayout();
        // 
        // cmbAuthor
        // 
        this.cmbAuthor.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.cmbAuthor.FormattingEnabled = true;
        this.cmbAuthor.Location = new System.Drawing.Point(103, 3);
        this.cmbAuthor.Name = "cmbAuthor";
        this.cmbAuthor.Size = new System.Drawing.Size(193, 24);
        this.cmbAuthor.TabIndex = 1;
        // 
        // label1
        // 
        this.label1.AutoSize = true;
        this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.label1.Location = new System.Drawing.Point(3, 0);
        this.label1.Name = "label1";
        this.label1.Size = new System.Drawing.Size(54, 16);
        this.label1.TabIndex = 2;
        this.label1.Text = "Author";
        // 
        // label2
        // 
        this.label2.AutoSize = true;
        this.label2.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.label2.Location = new System.Drawing.Point(3, 30);
        this.label2.Name = "label2";
        this.label2.Size = new System.Drawing.Size(55, 16);
        this.label2.TabIndex = 3;
        this.label2.Text = "Volume";
        // 
        // txtVol
        // 
        this.txtVol.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.txtVol.Location = new System.Drawing.Point(103, 33);
        this.txtVol.Name = "txtVol";
        this.txtVol.Size = new System.Drawing.Size(64, 23);
        this.txtVol.TabIndex = 4;
        // 
        // pgbVol
        // 
        this.tableLayoutPanel1.SetColumnSpan(this.pgbVol, 3);
        this.pgbVol.Dock = System.Windows.Forms.DockStyle.Fill;
        this.pgbVol.Location = new System.Drawing.Point(3, 63);
        this.pgbVol.Name = "pgbVol";
        this.pgbVol.Size = new System.Drawing.Size(852, 24);
        this.pgbVol.TabIndex = 5;
        // 
        // grdArticle
        // 
        this.tableLayoutPanel1.SetColumnSpan(this.grdArticle, 3);
        this.grdArticle.Dock = System.Windows.Forms.DockStyle.Fill;
        this.grdArticle.Location = new System.Drawing.Point(3, 93);
        this.grdArticle.Name = "grdArticle";
        this.grdArticle.ReadOnly = true;
        this.grdArticle.ShowEditingIcon = false;
        this.grdArticle.Size = new System.Drawing.Size(852, 470);
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
        this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(858, 566);
        this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
        this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
        this.toolStripContainer1.Name = "toolStripContainer1";
        this.toolStripContainer1.Size = new System.Drawing.Size(858, 621);
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
        this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
        this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
        this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 535F));
        this.tableLayoutPanel1.Controls.Add(this.label1, 0, 0);
        this.tableLayoutPanel1.Controls.Add(this.cmbAuthor, 1, 0);
        this.tableLayoutPanel1.Controls.Add(this.grdArticle, 0, 3);
        this.tableLayoutPanel1.Controls.Add(this.label2, 0, 1);
        this.tableLayoutPanel1.Controls.Add(this.pgbVol, 0, 2);
        this.tableLayoutPanel1.Controls.Add(this.txtVol, 1, 1);
        this.tableLayoutPanel1.Controls.Add(this._grbOptions, 2, 0);
        this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
        this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
        this.tableLayoutPanel1.Name = "tableLayoutPanel1";
        this.tableLayoutPanel1.RowCount = 4;
        this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
        this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
        this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
        this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
        this.tableLayoutPanel1.Size = new System.Drawing.Size(858, 566);
        this.tableLayoutPanel1.TabIndex = 0;
        // 
        // _grbOptions
        // 
        this._grbOptions.Anchor = System.Windows.Forms.AnchorStyles.None;
        this._grbOptions.Controls.Add(this._radMobi);
        this._grbOptions.Controls.Add(this._radEpub);
        this._grbOptions.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this._grbOptions.Location = new System.Drawing.Point(529, 8);
        this._grbOptions.Name = "_grbOptions";
        this.tableLayoutPanel1.SetRowSpan(this._grbOptions, 2);
        this._grbOptions.Size = new System.Drawing.Size(123, 43);
        this._grbOptions.TabIndex = 7;
        this._grbOptions.TabStop = false;
        this._grbOptions.Text = "Options";
        // 
        // _radMobi
        // 
        this._radMobi.AutoSize = true;
        this._radMobi.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this._radMobi.Location = new System.Drawing.Point(62, 19);
        this._radMobi.Name = "_radMobi";
        this._radMobi.Size = new System.Drawing.Size(51, 17);
        this._radMobi.TabIndex = 3;
        this._radMobi.Text = "MOBI";
        this._radMobi.UseVisualStyleBackColor = true;
        this._radMobi.CheckedChanged += new System.EventHandler(this.MobiChecked);
        // 
        // _radEpub
        // 
        this._radEpub.AutoSize = true;
        this._radEpub.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this._radEpub.Location = new System.Drawing.Point(6, 19);
        this._radEpub.Name = "_radEpub";
        this._radEpub.Size = new System.Drawing.Size(50, 17);
        this._radEpub.TabIndex = 2;
        this._radEpub.Text = "EPUB";
        this._radEpub.UseVisualStyleBackColor = true;
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
            this._tsbEpubHymn});
        this._tspMain.Location = new System.Drawing.Point(3, 0);
        this._tspMain.Name = "_tspMain";
        this._tspMain.Size = new System.Drawing.Size(526, 55);
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
        this._tsbBible.Size = new System.Drawing.Size(116, 52);
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
        this._tsbCreateEpub.Size = new System.Drawing.Size(87, 52);
        this._tsbCreateEpub.Text = "EPUB";
        this._tsbCreateEpub.Click += new System.EventHandler(this.CreateEpubFiles);
        // 
        // _tsbEpubHymn
        // 
        this._tsbEpubHymn.Image = global::FrontBurner.Ministry.MseBuilder.Properties.Resources.Books;
        this._tsbEpubHymn.ImageTransparentColor = System.Drawing.Color.Magenta;
        this._tsbEpubHymn.Name = "_tsbEpubHymn";
        this._tsbEpubHymn.Size = new System.Drawing.Size(124, 52);
        this._tsbEpubHymn.Text = "Hymnbooks";
        this._tsbEpubHymn.Click += new System.EventHandler(this.CreateEpubHymnFiles);
        // 
        // mseData
        // 
        this.mseData.DataSetName = "MseData";
        this.mseData.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
        // 
        // _bdsBugs
        // 
        this._bdsBugs.DataMember = "CompletedBugs";
        this._bdsBugs.DataSource = this.mseData;
        // 
        // _bugsTableAdapter
        // 
        this._bugsTableAdapter.ClearBeforeFill = true;
        // 
        // MseBuilder
        // 
        this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
        this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
        this.ClientSize = new System.Drawing.Size(858, 621);
        this.Controls.Add(this.toolStripContainer1);
        this.Name = "MseBuilder";
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
        this._grbOptions.ResumeLayout(false);
        this._grbOptions.PerformLayout();
        this._tspMain.ResumeLayout(false);
        this._tspMain.PerformLayout();
        ((System.ComponentModel.ISupportInitialize)(this.mseData)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this._bdsBugs)).EndInit();
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
    private MseData mseData;
    private System.Windows.Forms.ToolStripButton _tsbBible;
    private System.Windows.Forms.BindingSource _bdsBugs;
    private FrontBurner.Ministry.MseBuilder.Data.MseDataTableAdapters.CompletedBugsTableAdapter _bugsTableAdapter;
    private System.Windows.Forms.ToolStripButton _tsbCreateEpub;
    private System.Windows.Forms.GroupBox _grbOptions;
    private System.Windows.Forms.ToolStripButton _tsbEpubHymn;
    private System.Windows.Forms.RadioButton _radMobi;
    private System.Windows.Forms.RadioButton _radEpub;
  }
}

