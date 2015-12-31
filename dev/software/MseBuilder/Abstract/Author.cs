/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10533 : Added ImageFilename.
 * CAM  24-Dec-2010  10902 : Added Fullname and Orgname.
 * CAM  31-Dec-2015  886930 : Added ScriptureAuthor as reference author for new volume by Bible Book.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.IO;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class Author
  {
    public static readonly Author ScriptureAuthor = new Author("SCRIPTURE", "Scripture", "Scripture", "Various");

    private string _inits;
    private string _name;
    private string _fullName;
    private string _orgName;

    public string Inits
    {
      get { return _inits; }
      set { _inits = value; }
    }
    public string Name
    {
      get { return _name; }
      set { _name = value; }
    }
    public string FullName
    {
      get { return _fullName; }
      set { _fullName = value; }
    }
    public string OrgName
    {
      get { return _orgName; }
      set { _orgName = value; }
    }
    public string ImageFilename
    {
      get
      {
        return String.Format(@"{0}.png", Inits.ToLower());
      }
    }

    public Author(string inits, string name, string fullName, string orgName)
    {
      Inits = inits;
      Name = name;
      FullName = fullName;
      OrgName = orgName;
    }
  }

  public class AuthorCollection : KeyedCollection<string, Author>
  {
    public AuthorCollection()
      : base()
    {
    }

    protected override string GetKeyForItem(Author vol)
    {
      return vol.Inits;
    }
  }
}
