/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubXmlFile.cs 1310 2011-01-03 16:41:38Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Class renames to make Hymn EPUB more obviously separate.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public abstract class EpubXmlFile : XmlDocument, IEpubGenerator
  {
    private EpubHymnbookDocument _doc;
    private DirectoryInfo _dir;
    private FileInfo _file;
    private XmlElement _root;

    public EpubHymnbookDocument Doc
    {
      get { return _doc; }
      set { _doc = value; }
    }
    public abstract string XmlFilename
    {
      get;
    }
    public abstract string RootName
    {
      get;
    }
    public DirectoryInfo Dir
    {
      get { return _dir; }
      set
      {
        _dir = value;
        _file = new FileInfo(String.Format(@"{0}\{1}", _dir.FullName, XmlFilename));
      }
    }
    public FileInfo File
    {
      get { return _file; }
    }
    protected XmlElement Root
    {
      get { return _root; }
      set { _root = value; }
    }

    public EpubXmlFile(EpubHymnbookDocument doc, DirectoryInfo dir)
      : base()
    {
      Doc = doc;
      Dir = dir;
    }

    public virtual void GenerateEpub()
    {
      RemoveAll();
      AppendChild(CreateNode(XmlNodeType.XmlDeclaration, "", ""));

      AddDocumentType();

      Root = CreateElement("", RootName, "");
      AppendChild(Root);
    }

    public void SaveFile()
    {
      try
      {
        this.Save(File.FullName);
      }
      catch (Exception)
      {
      }
    }

    protected virtual void AddDocumentType()
    {
    }

    protected XmlElement AppendElement(XmlElement parent, string elementName)
    {
      return AppendElement(parent, elementName, "", "");
    }

    protected XmlElement AppendElement(XmlElement parent, string elementName, string elementText)
    {
      return AppendElement(parent, elementName, "", elementText);
    }

    protected XmlElement AppendElement(XmlElement parent, string elementName, string ns, string elementText)
    {
      XmlElement rval = CreateElement(elementName, ns);
      if (elementText.Length > 0) rval.AppendChild(CreateTextNode(elementText));
      parent.AppendChild(rval);
      return rval;
    }

    protected void AppendAttribute(XmlElement element, string attributeName, string attributeValue)
    {
      XmlAttribute attribute = CreateAttribute(attributeName);
      attribute.Value = attributeValue;
      element.Attributes.Append(attribute);
    }

    protected void AppendAttribute(XmlElement element, string attributeName, string ns, string attributeValue)
    {
      XmlAttribute attribute = CreateAttribute(attributeName, ns);
      attribute.Value = attributeValue;
      element.Attributes.Append(attribute);
    }
  }
}
