/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BuildErrors.Designer.cs 1157 2010-02-13 14:54:18Z craig $
 *
 * Who  When         Why
 * CAM  17-May-2008  10266 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using FrontBurner.Ministry.MseBuilder.Data;

namespace FrontBurner.Ministry.MseBuilder
{
  partial class BuildErrors
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
      this._tbpBadBibleRef = new System.Windows.Forms.TabPage();
      this.dataGridView1 = new System.Windows.Forms.DataGridView();
      this.badBibleRefBindingSource = new System.Windows.Forms.BindingSource(this.components);
      this.mseData = new FrontBurner.Ministry.MseBuilder.Data.MseData();
      this.tabControl1 = new System.Windows.Forms.TabControl();
      this.badBibleRefTableAdapter = new FrontBurner.Ministry.MseBuilder.Data.MseDataTableAdapters.BadBibleRefTableAdapter();
      this.authorDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.volDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.pageDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.paraDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.refDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.errorcodeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.textDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this._tbpBadBibleRef.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.badBibleRefBindingSource)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.mseData)).BeginInit();
      this.tabControl1.SuspendLayout();
      this.SuspendLayout();
      // 
      // _tbpBadBibleRef
      // 
      this._tbpBadBibleRef.Controls.Add(this.dataGridView1);
      this._tbpBadBibleRef.Location = new System.Drawing.Point(4, 22);
      this._tbpBadBibleRef.Name = "_tbpBadBibleRef";
      this._tbpBadBibleRef.Padding = new System.Windows.Forms.Padding(3);
      this._tbpBadBibleRef.Size = new System.Drawing.Size(609, 304);
      this._tbpBadBibleRef.TabIndex = 0;
      this._tbpBadBibleRef.Text = "Bad Bible Refs";
      this._tbpBadBibleRef.UseVisualStyleBackColor = true;
      // 
      // dataGridView1
      // 
      this.dataGridView1.AllowUserToAddRows = false;
      this.dataGridView1.AllowUserToDeleteRows = false;
      this.dataGridView1.AutoGenerateColumns = false;
      this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.authorDataGridViewTextBoxColumn,
            this.volDataGridViewTextBoxColumn,
            this.pageDataGridViewTextBoxColumn,
            this.paraDataGridViewTextBoxColumn,
            this.refDataGridViewTextBoxColumn,
            this.errorcodeDataGridViewTextBoxColumn,
            this.textDataGridViewTextBoxColumn});
      this.dataGridView1.DataSource = this.badBibleRefBindingSource;
      this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.dataGridView1.Location = new System.Drawing.Point(3, 3);
      this.dataGridView1.Name = "dataGridView1";
      this.dataGridView1.ReadOnly = true;
      this.dataGridView1.Size = new System.Drawing.Size(603, 298);
      this.dataGridView1.TabIndex = 0;
      // 
      // badBibleRefBindingSource
      // 
      this.badBibleRefBindingSource.DataMember = "BadBibleRef";
      this.badBibleRefBindingSource.DataSource = this.mseData;
      // 
      // mseData
      // 
      this.mseData.DataSetName = "MseData";
      this.mseData.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // tabControl1
      // 
      this.tabControl1.Controls.Add(this._tbpBadBibleRef);
      this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tabControl1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.tabControl1.Location = new System.Drawing.Point(0, 0);
      this.tabControl1.Name = "tabControl1";
      this.tabControl1.SelectedIndex = 0;
      this.tabControl1.Size = new System.Drawing.Size(617, 330);
      this.tabControl1.TabIndex = 0;
      // 
      // badBibleRefTableAdapter
      // 
      this.badBibleRefTableAdapter.ClearBeforeFill = true;
      // 
      // authorDataGridViewTextBoxColumn
      // 
      this.authorDataGridViewTextBoxColumn.DataPropertyName = "author";
      this.authorDataGridViewTextBoxColumn.HeaderText = "author";
      this.authorDataGridViewTextBoxColumn.Name = "authorDataGridViewTextBoxColumn";
      this.authorDataGridViewTextBoxColumn.ReadOnly = true;
      // 
      // volDataGridViewTextBoxColumn
      // 
      this.volDataGridViewTextBoxColumn.DataPropertyName = "vol";
      this.volDataGridViewTextBoxColumn.HeaderText = "vol";
      this.volDataGridViewTextBoxColumn.Name = "volDataGridViewTextBoxColumn";
      this.volDataGridViewTextBoxColumn.ReadOnly = true;
      // 
      // pageDataGridViewTextBoxColumn
      // 
      this.pageDataGridViewTextBoxColumn.DataPropertyName = "page";
      this.pageDataGridViewTextBoxColumn.HeaderText = "page";
      this.pageDataGridViewTextBoxColumn.Name = "pageDataGridViewTextBoxColumn";
      this.pageDataGridViewTextBoxColumn.ReadOnly = true;
      // 
      // paraDataGridViewTextBoxColumn
      // 
      this.paraDataGridViewTextBoxColumn.DataPropertyName = "para";
      this.paraDataGridViewTextBoxColumn.HeaderText = "para";
      this.paraDataGridViewTextBoxColumn.Name = "paraDataGridViewTextBoxColumn";
      this.paraDataGridViewTextBoxColumn.ReadOnly = true;
      // 
      // refDataGridViewTextBoxColumn
      // 
      this.refDataGridViewTextBoxColumn.DataPropertyName = "ref";
      this.refDataGridViewTextBoxColumn.HeaderText = "ref";
      this.refDataGridViewTextBoxColumn.Name = "refDataGridViewTextBoxColumn";
      this.refDataGridViewTextBoxColumn.ReadOnly = true;
      // 
      // errorcodeDataGridViewTextBoxColumn
      // 
      this.errorcodeDataGridViewTextBoxColumn.DataPropertyName = "error_code";
      this.errorcodeDataGridViewTextBoxColumn.HeaderText = "error_code";
      this.errorcodeDataGridViewTextBoxColumn.Name = "errorcodeDataGridViewTextBoxColumn";
      this.errorcodeDataGridViewTextBoxColumn.ReadOnly = true;
      // 
      // textDataGridViewTextBoxColumn
      // 
      this.textDataGridViewTextBoxColumn.DataPropertyName = "text";
      this.textDataGridViewTextBoxColumn.HeaderText = "text";
      this.textDataGridViewTextBoxColumn.Name = "textDataGridViewTextBoxColumn";
      this.textDataGridViewTextBoxColumn.ReadOnly = true;
      // 
      // BuildErrors
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(617, 330);
      this.Controls.Add(this.tabControl1);
      this.Name = "BuildErrors";
      this.Text = "Build Errors";
      this.Load += new System.EventHandler(this.BuildErrors_Load);
      this._tbpBadBibleRef.ResumeLayout(false);
      ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.badBibleRefBindingSource)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.mseData)).EndInit();
      this.tabControl1.ResumeLayout(false);
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.TabPage _tbpBadBibleRef;
    private System.Windows.Forms.DataGridView dataGridView1;
    private System.Windows.Forms.TabControl tabControl1;
    private MseData mseData;
    private System.Windows.Forms.BindingSource badBibleRefBindingSource;
    private FrontBurner.Ministry.MseBuilder.Data.MseDataTableAdapters.BadBibleRefTableAdapter badBibleRefTableAdapter;
    private System.Windows.Forms.DataGridViewTextBoxColumn authorDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn volDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn pageDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn paraDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn refDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn errorcodeDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn textDataGridViewTextBoxColumn;

  }
}