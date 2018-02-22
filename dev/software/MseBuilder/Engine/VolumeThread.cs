/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2008,2018 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  11-May-2008  10265 : File created (for clarity).
 * CAM  17-May-2008  10266 : Return Errors found during Build.
 * CAM  15-Jan-2010  10528 : Added BbebThread.
 * CAM  19-Jan-2010  10540 : Added EpubThread.
 * CAM  23-Jan-2010  10551 : Added ParseJndThread.
 * CAM  03-Jan-2011  10917 : Added EpubHymnThread.
 * CAM  28-Dec-2011  gc005 : Removed redundant code.
 * CAM  31-Dec-2015  886930 : Added EpubScriptureThread.
 * CAM  22-Feb-2018  732482 : Added EpubCollectionThread.
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

  public class EpubCollectionThread : VolumeThread
  {
    public EpubCollectionThread()
      : base("", 0, false)
    {
      _process = new Thread(new ThreadStart(CreateEpubCollectionFiles));
      _process.IsBackground = true;
      _process.Start();
    }

    private void CreateEpubCollectionFiles()
    {
      _engine = new MseEngine();
      _engine.CreateEpubCollectionFiles();
    }
  }

  public class EpubScriptureThread : VolumeThread
  {
    public EpubScriptureThread()
      : base("", 0, false)
    {
      _process = new Thread(new ThreadStart(CreateEpubScriptureFiles));
      _process.IsBackground = true;
      _process.Start();
    }

    private void CreateEpubScriptureFiles()
    {
      _engine = new MseEngine();
      _engine.CreateEpubScriptureFiles();
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
}
