/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebDocument.cs 1121 2010-01-15 22:56:23Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10531 : Expose the main block publically.
 * CAM  15-Jan-2010  10533 : Added ImageStream.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebDocument : XmlDocument, IBbebGenerator
  {
    private Volume _vol;
    private FileInfo _lrsFile;
    private XmlElement _root;
    private BbebGeneratorList _generators;
    private BbebBookInformation _bookInformation;
    private BbebBookStyle _bookStyle;
    private BbebPageStyle _pageStyle;
    private BbebBlockStyle _blockStyle;
    private BbebTextStyleCollection _textStyleCollection;
    private BbebImageStream _imageStreamAuthor;
    private XmlElement _main;

    public Volume Volume
    {
      get { return _vol; }
      set { _vol = value; }
    }
    public BbebBookInformation BookInformation
    {
      get { return _bookInformation; }
    }
    public BbebBookStyle BookStyle
    {
      get { return _bookStyle; }
    }
    public BbebPageStyle PageStyle
    {
      get { return _pageStyle; }
    }
    public BbebBlockStyle BlockStyle
    {
      get { return _blockStyle; }
    }
    public BbebTextStyleCollection TextStyleCollection
    {
      get { return _textStyleCollection; }
    }
    public BbebImageStream ImageStreamAuthor
    {
      get { return _imageStreamAuthor; }
      set { _imageStreamAuthor = value; }
    }
    public XmlElement MainBlock
    {
      get { return _main; }
    }

    public BbebDocument(FileInfo lrsFile, Volume vol)
      : base()
    {
      BbebUtil.Instance.Reset();

      _vol = vol;
      _lrsFile = lrsFile;

      _generators = new BbebGeneratorList();

      _bookInformation = new BbebBookInformation(this);
      _bookStyle = new BbebBookStyle(this);
      _pageStyle = new BbebPageStyle(this);
      _blockStyle = new BbebBlockStyle(this);
      _textStyleCollection = new BbebTextStyleCollection(this);
      _imageStreamAuthor = new BbebImageStream(this, vol.Author.ImageFilename);

      _generators.Add(_bookInformation);
      _generators.Add(_bookStyle);
      _generators.Add(_pageStyle);
      _generators.Add(_blockStyle);
      _generators.Add(_textStyleCollection);
      _generators.Add(_imageStreamAuthor);
    }

    public void GenerateBbeb()
    {
      XmlNode declaration;
      XmlElement style;
      XmlElement objects;
      XmlAttribute attribute;

      // Create all subsections
      _generators.GenerateBbeb();

      declaration = CreateNode(XmlNodeType.XmlDeclaration, "", "");
      AppendChild(declaration);

      _root = CreateElement("", "BBeBXylog", "");
      AppendChild(_root);
      attribute = this.CreateAttribute("version");
      attribute.Value = "1.0";
      _root.Attributes.Append(attribute);

      _root.AppendChild(BookInformation);

      _main = CreateElement("", "Main", "");
      _root.AppendChild(_main);

      BbebTitlePage titlePage = new BbebTitlePage(this, PageStyle);
      _main.AppendChild(titlePage);
      titlePage.GenerateBbeb();

      style = CreateElement("", "Style", "");
      _root.AppendChild(style);
      style.AppendChild(BookStyle);
      style.AppendChild(PageStyle);
      style.AppendChild(BlockStyle);

      foreach (BbebTextStyle textStyle in TextStyleCollection)
      {
        style.AppendChild(textStyle);
      }

      objects = CreateElement("", "Objects", "");
      _root.AppendChild(objects);
      objects.AppendChild(ImageStreamAuthor);
    }

    public void SaveFile()
    {
      try
      {
        this.Save(_lrsFile.FullName);
      }
      catch (Exception)
      {

      }
    }
  }
}
