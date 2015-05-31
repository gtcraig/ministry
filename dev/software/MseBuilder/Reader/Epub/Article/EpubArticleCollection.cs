/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: EpubArticleCollection.cs 1132 2010-01-21 13:44:41Z craig $
 *
 * Who  When         Why
 * CAM  21-Jan-2010  10546 : Class moved from EpubArticle.cs.
 * CAM  31-May-2015  998637 : Added Cover page.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubArticleCollection : KeyedCollection<long, EpubArticle>
  {
    private EpubDocument _doc;
    private long _nextId;

    public EpubArticleCollection(EpubDocument doc)
      : base()
    {
      _doc = doc;
      _nextId = 1;

      CreateArticle(CoverPageFactory());
      CreateArticle(TitlePageFactory());
    }

    protected long GetNextId()
    {
      return _nextId++;
    }

    protected override long GetKeyForItem(EpubArticle item)
    {
      return item.Id;
    }

    public EpubArticle CreateArticle()
    {
      return CreateArticle(ArticleFactory());
    }

    protected EpubArticle CreateArticle(EpubArticle article)
    {
      Add(article);
      return article;
    }

    public EpubArticle ArticleFactory()
    {
      return new EpubArticle(GetNextId(), _doc);
    }

    public EpubArticle TitlePageFactory()
    {
      return new EpubTitlePage(GetNextId(), _doc);
    }

    public EpubArticle CoverPageFactory()
    {
      return new EpubCoverPage(GetNextId(), _doc);
    }
  }
}
