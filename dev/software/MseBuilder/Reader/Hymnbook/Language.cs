/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2011 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Added LanguageList and LanguageName.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public enum Language
  {
    English,
    Dutch,
    German,
    Italian,
    French
  }

  public class LanguageList : List<Language>
  {
    public LanguageList()
      : base()
    {
    }
  }

  public static class Languages
  {
    public static LanguageList List
    {
      get
      {
        LanguageList list = new LanguageList();
        list.Add(Language.English);
        list.Add(Language.German);
        list.Add(Language.Dutch);
        list.Add(Language.Italian);
        //list.Add(Language.French);
        return list;
      }
    }

    public static string LanguageCode(Language language)
    {
      switch (language)
      {
        case Language.Dutch:
          return "nl";
        case Language.German:
          return "de";
        case Language.Italian:
          return "it";
        case Language.French:
          return "fr";
        default:
          break;
      }

      return "en-gb";
    }

    public static string LanguageName(Language language)
    {
      switch (language)
      {
        case Language.Dutch:
          return "Dutch";
        case Language.German:
          return "Deutsche";
        case Language.Italian:
          return "Italiano";
        case Language.French:
          return "Français";
        default:
          break;
      }

      return "English";
    }

    /// <summary>
    /// Language Suffix is used on table names to indicate the language of the contents.
    /// (Terrible design... shoot me!)
    /// </summary>
    /// <param name="language"></param>
    /// <returns></returns>
    public static string LanguageSuffix(Language language)
    {
      switch (language)
      {
        case Language.Dutch:
          return "_nl";
        case Language.German:
          return "_de";
        case Language.Italian:
          return "_it";
        case Language.French:
          return "_fr";
        default:
          break;
      }

      return String.Empty;
    }
  }
}
