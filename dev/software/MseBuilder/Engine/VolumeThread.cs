/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2008,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: VolumeThread.cs 1310 2011-01-03 16:41:38Z craig $
 *
 * Who  When         Why
 * CAM  11-May-2008  10265 : File created (for clarity).
 * CAM  17-May-2008  10266 : Return Errors found during Build.
 * CAM  15-Jan-2010  10528 : Added BbebThread.
 * CAM  19-Jan-2010  10540 : Added EpubThread.
 * CAM  23-Jan-2010  10551 : Added ParseJndThread.
 * CAM  03-Jan-2011  10917 : Added EpubHymnThread.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

using FrontBurner.Ministry.MseBuilder.Engine;

namespace FrontBurner.Ministry.MseBuilder.Engine
{
  public class VolumeThread
  {
    protected Thread _process;
    protected string _author;
    protected int _vol;
    protected bool _specificVolume;
    protected MseEngine _engine;

    public Thread Process
    {
      get
      {
        return _process;
      }
    }
    public MseEngine Engine
    {
      get
      {
        return _engine;
      }
    }
    public bool AnyErrors
    {
      get
      {
        if (_engine != null) return _engine.AnyErrors;
        return false;
      }
    }

    public VolumeThread(string author, int vol, bool specificVolume)
    {
      _author = author;
      _vol = vol;
      _specificVolume = specificVolume;
    }
  }

  public class BuilderThread : VolumeThread
  {
    public BuilderThread(string author, int vol, bool specificVolume)
      : base(author, vol, specificVolume)
    {
      _process = new Thread(new ThreadStart(Build));
      _process.IsBackground = true;
      _process.Start();
    }

    private void Build()
    {
      _engine = new MseEngine();

      if (_specificVolume)
      {
        _engine.Build(_author, _vol);
      }
      else
      {
        _engine.Build();
      }
    }
  }

  public class ZipperThread : VolumeThread
  {
    public ZipperThread(string author, int vol, bool specificVolume)
      : base(author, vol, specificVolume)
    {
      _process = new Thread(new ThreadStart(Zip));
      _process.IsBackground = true;
      _process.Start();
    }

    private void Zip()
    {
      _engine = new MseEngine();

      if (_specificVolume)
      {
        _engine.Zip(_author, _vol);
      }
      else
      {
        _engine.Zip();
      }
    }
  }

  public class BbebThread : VolumeThread
  {
    public BbebThread(string author, int vol, bool specificVolume)
      : base(author, vol, specificVolume)
    {
      _process = new Thread(new ThreadStart(CreateBbebFiles));
      _process.IsBackground = true;
      _process.Start();
    }

    private void CreateBbebFiles()
    {
      _engine = new MseEngine();

      if (_specificVolume)
      {
        _engine.CreateBbebFiles(_author, _vol);
      }
      else
      {
        _engine.CreateBbebFiles();
      }
    }
  }

  public class EpubThread : VolumeThread
  {
    public EpubThread(string author, int vol, bool specificVolume)
      : base(author, vol, specificVolume)
    {
      _process = new Thread(new ThreadStart(CreateEpubFiles));
      _process.IsBackground = true;
      _process.Start();
    }

    private void CreateEpubFiles()
    {
      _engine = new MseEngine();

      if (_specificVolume)
      {
        _engine.CreateEpubFiles(_author, _vol);
      }
      else
      {
        _engine.CreateEpubFiles();
      }
    }
  }

  public class EpubHymnThread : VolumeThread
  {
    public EpubHymnThread()
      : base("JND", 1, false)
    {
      _process = new Thread(new ThreadStart(CreateEpubFiles));
      _process.IsBackground = true;
      _process.Start();
    }

    private void CreateEpubFiles()
    {
      new MseEngine().CreateEpubHymnFiles();
    }
  }

  public class ParseJndThread : VolumeThread
  {
    public ParseJndThread(string author, int vol, bool specificVolume)
      : base(author, vol, specificVolume)
    {
      _process = new Thread(new ThreadStart(CreateJndFiles));
      _process.IsBackground = true;
      _process.Start();
    }

    private void CreateJndFiles()
    {
      _engine = new MseEngine();

      if (_specificVolume)
      {
        _engine.CreateJndFiles(_author, _vol);
      }
      else
      {
        _engine.CreateJndFiles();
      }
    }
  }
}
