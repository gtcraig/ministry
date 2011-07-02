/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: BbebUtil.cs 1116 2010-01-15 17:19:25Z craig $
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebUtil
  {
    protected static BbebUtil _instance;
    protected static readonly object _semaphore = new object();

    private int _objId;
    private int _bookId;

    protected BbebUtil()
    {
      Reset();

      _bookId = 88880000;
    }

    public static BbebUtil Instance
    {
      get
      {
        lock (_semaphore)
        {
          if (_instance == null)
          {
            _instance = new BbebUtil();
          }
          return _instance;
        }
      }
    }

    public int NextObjId()
    {
      return _objId++;
    }

    public string NextBookId()
    {
      return String.Format("FB{0}", _bookId++);
    }

    public void Reset()
    {
      _objId = 1;
    }
  }
}
