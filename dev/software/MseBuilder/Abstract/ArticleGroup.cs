/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2020 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  14-Apr-2020  361011 : Added Article Group.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class ArticleGroup
  {
    protected Volume _vol;
    protected string _title;
    protected string _city;
    protected string _groupDate;
    protected string _summary;
    protected int _localRow;

    public string Id
    {
      get
      {
        return GetId(_vol, _localRow);
      }
    }
    public Volume Volume
    {
      get
      {
        return _vol;
      }
    }
    public string City { get => _city; set => _city = value; }
    public string GroupDate { get => _groupDate; set => _groupDate = value; }
    public string Summary { get => _summary; set => _summary = value; }
    public int LocalRow { get => _localRow; set => _localRow = value; }
    public string Title
    {
      get
      {
        return _title;
      }
      set
      {
        _title = GetTitle(value);
      }
    }


    public static string GetTitle(string title)
    {
      if (title.StartsWith("$")) title = title.Substring(1).Trim();
      return title;
    }

    public ArticleGroup(Volume vol, string title, string city, string groupDate, string summary, int localRow)
    {
      _vol = vol;
      Title = title;
      City = city;
      GroupDate = groupDate;
      Summary = summary;
      LocalRow = localRow;
  }

  public override string ToString()
    {
      return String.Format("{0}: {1}", _vol.Id, _title);
    }

    public static string GetId(Volume vol, int localRow)
    {
      return String.Format("{0}-{1:000000}", vol.Id, localRow);
    }
  }


  public class ArticleGroupCollection : KeyedCollection<string, ArticleGroup>
  {
    public ArticleGroupCollection()
      : base()
    {
    }

    public void Add(Article article)
    {
      foreach (ArticleGroup ag in this)
      {
        if (article.Title.StartsWith(ag.Title))
        {
          article.Group = ag;
        }
      }
    }

    protected override string GetKeyForItem(ArticleGroup articleGroup)
    {
      return articleGroup.Title;
    }
  }
}
