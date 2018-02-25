/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Who  When         Why
 * CAM  13-Jan-2010  10551 : Added JndHtmlVolumes.
 * CAM  24-Dec-2010  10902 : Added BuildModes.
 * CAM  31-Dec-2015  886930 : Removed ancient SonyEpub references - no longer required.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Ministry.MseBuilder.Engine
{
  public enum BuildMode
  {
    StandardEpub,
    KindleMobiEpub
  }

  /// <summary>
  /// All Business data and processes
  /// </summary>
  public class EngineSettings
  {
    private static EngineSettings _settings;
    protected static readonly object _semaphore = new object();

    private BuildMode _mode;

    public BuildMode Mode
    {
      get { return _mode; }
      set { _mode = value; }
    }

    private EngineSettings()
    {
    }

    public static EngineSettings Instance
    {
      get
      {
        lock (_semaphore)
        {
          if (_settings == null)
          {
            _settings = new EngineSettings();
            _settings.Mode = BuildMode.StandardEpub;
          }
          return _settings;
        }
      }
    }
  }
}
