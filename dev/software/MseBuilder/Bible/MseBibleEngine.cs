/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2008,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  22-Jun-2008  10409 : File created.
 * CAM  04-Apr-2009  10413 : Parse Footnote refs and record ALL of them, and the phrases that they are connected to.
 * CAM  04-Apr-2009  10414 : Moved CrossReference to BibleVerse.
 * CAM  15-Jan-2010  10528 : Use Properties rather than methods.
 * CAM  25-Feb-2018  790063 : Used correct namespace for Data.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.IO;
using System.Windows.Forms;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Data;
using FrontBurner.Ministry.MseBuilder.Engine;

namespace FrontBurner.Ministry.MseBuilder.Bible
{
  public class Sourcefiles : Collection<FileInfo>
  {
    private DirectoryInfo _dir;

    public Sourcefiles(string dirName)
      : base()
    {
      _dir = new DirectoryInfo(dirName);
      foreach (FileInfo file in _dir.GetFiles())
      {
        this.Add(file);
      }
    }
  }

  public class MseBibleEngine
  {
    private const string AnchorStartOpen = "<A HREF=\"";
    private const string AnchorStartClose = "\">";
    private const string AnchorEnd = "</A>";

    private Sourcefiles _jndText;
    private Sourcefiles _jndFootnotes;
    private Sourcefiles _kjvText;

    public MseBibleEngine()
    {
      _jndText = new Sourcefiles(@"C:\Dev\Scriptures\Bible\Darby\tx");
      _jndFootnotes = new Sourcefiles(@"C:\Dev\Scriptures\Bible\Darby\fn");
      _kjvText = new Sourcefiles(@"C:\Dev\Scriptures\Bible\AV\tx");
    }

    public void Build()
    {
      BibleVersionCollection versions = BusinessLayer.Instance.Versions;

      foreach (BibleVersion version in versions)
      {
        version.Clear();
      }

      BuildText(_jndText, versions[1]);
      //BuildText(_kjvText, versions[2]);

      BuildFootnotes(_jndFootnotes, versions[1]);

      foreach (BibleBook book in versions[1])
      {
        CrossReference(book);
      }

      DatabaseLayer.Instance.ExecuteSql("TRUNCATE TABLE mse_bible_text");
      DatabaseLayer.Instance.ExecuteSql("TRUNCATE TABLE mse_bible_footnote");
      DatabaseLayer.Instance.ExecuteSql("TRUNCATE TABLE mse_bible_footnote_ref");
      DatabaseLayer.Instance.ExecuteSql("TRUNCATE TABLE mse_bible_footnote_xref");

      foreach (BibleVersion version in versions)
      {
        foreach (BibleBook book in version)
        {
          DatabaseLayer.Instance.SaveBibleBook(book);
        }
      }
    }

    protected void BuildText(Sourcefiles files, BibleVersion version)
    {
      string buffer;
      int p;
      string bookName;
      string shortCode;
      string text;
      BibleBookCollection books = BusinessLayer.Instance.Books;
      BibleBook book = null;

      foreach (FileInfo file in files)
      {
        using (StreamReader sr = new StreamReader(file.FullName))
        {
          while ((buffer = sr.ReadLine()) != null)
          {
            if ((p = buffer.IndexOf("<BR>")) >= 0)
            {
              bookName = buffer.Substring(p + 4, buffer.Length - p - 4);
              if ((p = bookName.IndexOf("<")) >= 0)
              {
                bookName = bookName.Substring(0, p);
              }
              if ((book = books.FindByFullname(bookName)) != null)
              {
                book = book.AddCopy(version);
                book.ShortCode = ParseShortCode(book, file);
              }
              else
              {
                // Error
                MessageBox.Show("Couldn't find bookname " + bookName, "Error!");
              }
            }
            else if ((p = buffer.IndexOf("<DT>")) >= 0)
            {
              buffer = buffer.Substring(p + 4, buffer.Length - p - 4); // remove dt
              p = buffer.IndexOf(">");
              buffer = buffer.Substring(p + 1, buffer.Length - p - 1); // remove anchor
              p = buffer.IndexOf("<");
              shortCode = buffer.Substring(0, p);
              p = buffer.IndexOf("<DD>");
              text = buffer.Substring(p + 4, buffer.Length - p - 4); // remove remaining prefix
              book.Verses.Add(new BibleVerse(book, shortCode, text));
            }
          }
        }
      }
    }

    protected void BuildFootnotes(Sourcefiles files, BibleVersion version)
    {
      string buffer;
      int p;
      string shortCode;
      char symbol = 'z';
      string text;
      BibleBookCollection books = BusinessLayer.Instance.Books;
      BibleBook book = null;
      BibleFootnote footnote = null;

      foreach (FileInfo file in files)
      {
        using (StreamReader sr = new StreamReader(file.FullName))
        {
          book = version.FindBookByShortCode(ParseShortCode(book, file));

          while ((buffer = sr.ReadLine()) != null)
          {
            if ((p = buffer.IndexOf("<DT>")) >= 0)
            {
              buffer = buffer.Substring(p + 4, buffer.Length - p - 4); // remove dt
              p = buffer.IndexOf("=\"");
              buffer = buffer.Substring(p + 2, buffer.Length - p - 2); // remove anchor tag
              p = buffer.IndexOf("\">");
              shortCode = buffer.Substring(0, p);
              buffer = buffer.Substring(p + 2, buffer.Length - p - 2); // remove anchor completely

              // Now look for the first alpha - this is the symbol
              for (int i = 0; i < buffer.Length; i++)
              {
                if (buffer[i] >= 97 && buffer[i] <= 122)
                {
                  symbol = buffer[i];
                  break;
                }
              }

              p = buffer.IndexOf("<DD>");
              text = buffer.Substring(p + 4, buffer.Length - p - 4); // remove remaining prefix
              footnote = new BibleFootnote(book, shortCode, symbol, text);
              book.Footnotes.Add(footnote);

              // Now parse the Refs
              // Usually there is only one ref.  Where there are two, the ref word can either follow the list meaning
              // the same word is used in each ref.  Alternatively, if different words are used, they will follow each ref.
              p = buffer.IndexOf("</A>");
              ParseRefs(footnote, buffer.Substring(0, p));
            }
          }
        }
      }
    }

    /// <summary>
    /// Parse multiple refs to the same footnote, usually on the one page.
    /// Not to be confused with Xrefs which is a reference to one footnote from another.
    /// </summary>
    /// <remarks>
    /// Unfortunately we can't use a comma as the separator, because the same verse may have several refs to the same footnote, e.g.
    /// Acts "16:6c through, forbidden, 16:7c down"
    /// Is really three refs:
    ///   16:6c through
    ///   16:6c forbidden
    ///   16:7c down
    /// Also, each ref may not specify the word
    /// "8:15h appearance, 8:16h, 8:26h vision"
    ///   8:15h appearance
    ///   8:16h vision
    ///   8:26h vision
    /// "8:10a, 8:14a horses of blood" - 'word' can really be a phrase
    /// </remarks>
    /// <param name="footnote"></param>
    /// <param name="refs"></param>
    protected void ParseRefs(BibleFootnote footnote, string refs)
    {
      char[] r = refs.ToCharArray();
      int i = 0;
      int prevSt = r.Length;
      string prevPhrase = null;
      bool nextSpace = false;

      for (i = r.Length - 1; i >= 0; i--)
      {
        if (r[i] == ':')
        {
          nextSpace = true;
        }
        if (r[i] == ' ' && nextSpace)
        {
          prevPhrase = ParseRef(footnote, refs.Substring(i, prevSt - i).Trim(), prevPhrase);

          nextSpace = false;
          prevSt = i;
        }
      }

      ParseRef(footnote, refs.Substring(i + 1, prevSt).ToString(), prevPhrase);
    }

    protected string ParseRef(BibleFootnote footnote, string fullRef, string prevPhrase)
    {
      if (fullRef.EndsWith(","))
      {
        fullRef = fullRef.Substring(0, fullRef.Length - 1).Trim();
      }
      if (!fullRef.Contains(" "))
      {
        // If there is no space, then there is no phrase after the Chapter:VerseSymbol.
        // Therefore, use the previous Phrase.
        footnote.Refs.Add(new BibleFootnoteRef(footnote, footnote.Refs.Count + 1, fullRef, prevPhrase));
      }
      else
      {
        // If there is a space, parse to separate the Chapter:VerseSymbol and Phrase.
        prevPhrase = AddRef(footnote, fullRef);
      }

      return prevPhrase;
    }

    protected string AddRef(BibleFootnote footnote, string fullRef)
    {
      int p = fullRef.IndexOf(' ');
      string shortCode = fullRef.Substring(0, p).Trim();
      string rval = null;

      string[] phraseList = fullRef.Substring(p + 1).Trim().Split(new char[] { ',' });
      foreach (string phrase in phraseList)
      {
        if (rval == null) rval = phrase;
        footnote.Refs.Add(new BibleFootnoteRef(footnote, footnote.Refs.Count + 1, shortCode, phrase));
      }

      return rval;
    }

    protected void CrossReference(BibleBook book)
    {
      foreach (BibleVerse element in book.Elements)
      {
        // Verses and Footnotes
        element.CrossReference();
      }
    }

    protected string ParseShortCode(BibleBook book, FileInfo file)
    {
      string code = file.Name;
      code = code.Substring(0, code.Length - file.Extension.Length);
      return code;
    }
  }
}
