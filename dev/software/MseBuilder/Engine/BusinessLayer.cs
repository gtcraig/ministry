/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  26-Sep-2007  Early working version.
 * CAM  28-Mar-2009  10409 : Added Footnote support.
 * CAM  15-Jan-2010  10528 : Added Authors and converted methods to properties.
 * CAM  23-Jan-2010  10551 : Added JndHtmlVolumes.
 * CAM  28-Dec-2011  gc005 : Removed redundant code.
 * CAM  22-Feb-2018  732482 : Added Collections property.
 * CAM  25-Feb-2018  790063 : Used correct namespace for Data.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Data;

namespace FrontBurner.Ministry.MseBuilder.Engine
{
  /// <summary>
  /// All Business data and processes
  /// </summary>
  public class BusinessLayer
  {
    private static BusinessLayer _busLayer;
    protected static readonly object _semaphore = new object();

    protected BibleBookCollection _books;
    protected BibleVersionCollection _versions;
    protected ArticleCollection _articles;
    protected AuthorCollection _authors;
    protected VolumeCollection _volumes;
    protected VolumeCollection _collections;
    protected int _nextFootnoteId;

    public ArticleCollection Articles
    {
      get
      {
        return _articles;
      }
    }

    private BusinessLayer()
    {
      _articles = new ArticleCollection();
      _nextFootnoteId = 1;
    }

    public static BusinessLayer Instance
    {
      get
      {
        lock (_semaphore)
        {
          if (_busLayer == null)
          {
            _busLayer = new BusinessLayer();
          }
          return _busLayer;
        }
      }
    }

    public BibleBookCollection Books
    {
      get
      {
        if (_books == null)
        {
          _books = DatabaseLayer.Instance.GetBooks();
        }

        return _books;
      }
    }

    public BibleVersionCollection Versions
    {
      get
      {
        if (_versions == null)
        {
          _versions = DatabaseLayer.Instance.GetBibleVersions();
        }
        return _versions;
      }
    }

    public VolumeCollection Volumes
    {
      get
      {
        if (_volumes == null)
        {
          _volumes = DatabaseLayer.Instance.GetVolumes();
        }

        return _volumes;
      }
    }

    public VolumeCollection Collections
    {
      get
      {
        if (_collections == null)
        {
          _collections = DatabaseLayer.Instance.GetCollectionVolumes();
        }

        return _collections;
      }
    }

    public AuthorCollection Authors
    {
      get
      {
        if (_authors == null)
        {
          _authors = DatabaseLayer.Instance.GetAuthors();
        }

        return _authors;
      }
    }

    public int GetNextFootnoteId()
    {
      return _nextFootnoteId++;
    }
  }
}
