//package com.asidua.mse;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Options {
    private static Options options;

    String strDefaultBrowser;
    String strSearchString;
    String strSearchType;
    boolean bAuthBible;
    boolean bAuthJND;
    boolean bAuthJBS;
    boolean bAuthCHM;
    boolean bAuthFER;
    boolean bAuthCAC;
    boolean bAuthJT;
    boolean bAuthGRC;
    boolean bAuthAJG;
    boolean bAuthSMC;
    boolean bAuthMisc;
    boolean bAuthHymns;
    boolean bBeep;
    boolean bSplashWindow;
    boolean bAutoLoad;
    boolean bFullScan;
    boolean bDebugOn;
    int intLogDetail;

    private Options() {
        
        // MJP Test 1x 15/3/15
        System.out.println("Options File: " + Constants.BASIC_FILE_PATH + "settings.txt");
        setDefaults();
        // MJP 1x 21/3/15
        File fOptions = new File(Constants.BASIC_FILE_PATH + "settings.txt");
        if (!fOptions.isFile()) {
            saveOptions();
        } else {
            try {
                BufferedReader brSettings = new BufferedReader(new FileReader(Constants.BASIC_FILE_PATH + "settings.txt"));

                boolean bLastSetting = false;
                while (!bLastSetting) {
                    String strCurrSetting = brSettings.readLine();
                    if (strCurrSetting == null) {
                        bLastSetting = true;
                        continue;
                    }
                    String strCurrSettingKey = strCurrSetting.substring(0, strCurrSetting.indexOf("="));
                    String strCurrSettingValue = strCurrSetting.substring(strCurrSetting.indexOf("=") + 1);
                    strCurrSettingValue = strCurrSettingValue.substring(1, strCurrSettingValue.length() - 1);
                    if (strCurrSettingKey.equals("DEFAULT_BROWSER")) {
                        strDefaultBrowser = strCurrSettingValue;
                    } else if (strCurrSettingKey.equals("LAST_SEARCH")) {
                        strSearchString = strCurrSettingValue;
                    } else if (strCurrSettingKey.equals("SEARCH_TYPE")) {
                        strSearchType = strCurrSettingValue;
                    } else if (strCurrSettingKey.equals("BIBLE_SEARCH")) {
                        bAuthBible = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("CAC_SEARCH")) {
                        bAuthCAC = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("FER_SEARCH")) {
                        bAuthFER = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("JBS_SEARCH")) {
                        bAuthJBS = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("CHM_SEARCH")) {
                        bAuthCHM = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("JND_SEARCH")) {
                        bAuthJND = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("JT_SEARCH")) {
                        bAuthJT = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("GRC_SEARCH")) {
                        bAuthGRC = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("AJG_SEARCH")) {
                        bAuthAJG = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("SMC_SEARCH")) {
                        bAuthSMC = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("MISC_SEARCH")) {
                        bAuthMisc = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("HYMNS_SEARCH")) {
                        bAuthHymns = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("BEEP")) {
                        bBeep = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("SPLASH_WINDOW")) {
                        bSplashWindow = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("AUTO_LOAD")) {
                        bAutoLoad = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("FULL_SCAN")) {
                        bFullScan = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("DEBUG_ON")) {
                        bDebugOn = (new Boolean(strCurrSettingValue)).booleanValue();
                    } else if (strCurrSettingKey.equals("LOG_DETAIL")) {
                        intLogDetail = (new Integer(strCurrSettingValue)).intValue();
                    }
                }
                brSettings.close();
            } catch (IOException ioe) {
                Log.getLog().write(Constants.LOG_HIGH, "<br>Error reading options file (htm/settings.txt): " + ioe);
            }
        }
    }//Options

    public void saveOptions() {
        PrintWriter pwSettings = null;
        try {
            // MJP 1x 21/3/15
            pwSettings = new PrintWriter(new FileWriter(Constants.BASIC_FILE_PATH + "settings.txt", false));
            pwSettings.println("DEFAULT_BROWSER=\"" + strDefaultBrowser + "\"");
            pwSettings.println("LAST_SEARCH=\"" + strSearchString + "\"");
            pwSettings.println("SEARCH_TYPE=\"" + strSearchType + "\"");
            pwSettings.println("BIBLE_SEARCH=\"" + bAuthBible + "\"");
            pwSettings.println("CAC_SEARCH=\"" + bAuthCAC + "\"");
            pwSettings.println("FER_SEARCH=\"" + bAuthFER + "\"");
            pwSettings.println("JBS_SEARCH=\"" + bAuthJBS + "\"");
            pwSettings.println("CHM_SEARCH=\"" + bAuthCHM + "\"");
            pwSettings.println("JND_SEARCH=\"" + bAuthJND + "\"");
            pwSettings.println("JT_SEARCH=\"" + bAuthJT + "\"");
            pwSettings.println("GRC_SEARCH=\"" + bAuthGRC + "\"");
            pwSettings.println("AJG_SEARCH=\"" + bAuthAJG + "\"");
            pwSettings.println("SMC_SEARCH=\"" + bAuthSMC + "\"");
            pwSettings.println("MISC_SEARCH=\"" + bAuthMisc + "\"");
            pwSettings.println("HYMNS_SEARCH=\"" + bAuthHymns + "\"");
            pwSettings.println("BEEP=\"" + bBeep + "\"");
            pwSettings.println("SPLASH_WINDOW=\"" + bSplashWindow + "\"");
            pwSettings.println("AUTO_LOAD=\"" + bAutoLoad + "\"");
            pwSettings.println("FULL_SCAN=\"" + bFullScan + "\"");
            pwSettings.println("DEBUG_ON=\"" + bDebugOn + "\"");
            pwSettings.println("LOG_DETAIL=\"" + intLogDetail + "\"");
            pwSettings.close();
        } catch (IOException ioe) {
            // MJP 1x 21/3/15
            Log.getLog().write(Constants.LOG_HIGH, "<br>Error writing options file (" + Constants.BASIC_FILE_PATH + "settings.txt" + "): " + ioe);
        }
    }//saveOptions

    public String getDefaultBrowser() {
        return strDefaultBrowser;
    }

    public void setDefaults() {
        strDefaultBrowser = "C:\\Program Files\\Internet Explorer\\IEXPLORE.EXE";
        strSearchString = "";
        strSearchType = "Phrase";
        bAuthBible = true;
        bAuthJND = false;
        bAuthJBS = false;
        bAuthCHM = false;
        bAuthFER = false;
        bAuthCAC = false;
        bAuthJT = false;
        bAuthGRC = false;
        bAuthAJG = false;
        bAuthSMC = false;
        bAuthMisc = false;
        bAuthHymns = false;
        bBeep = true;
        bSplashWindow = true;
        bAutoLoad = false;
        bFullScan = false;
        bDebugOn = false;
        intLogDetail = 0;
    }

    public void setDefaultBrowser(String message) {
        strDefaultBrowser = message;
//        if (strDefaultBrowser.equals("")) {
//            strDefaultBrowser = "C:\\Program Files\\Internet Explorer\\IEXPLORE.EXE";
//        }
   }

    public String getSearchString() {
        return strSearchString;
    }

    public void setSearchString(String message) {
        strSearchString = message;
    }

    public String getSearchType() {
        return strSearchType;
    }

    public void setSearchType(String message) {
        strSearchType = message;
    }

    public boolean getAuthSelected(int intAuth) {
        boolean bRet = false;
        switch (intAuth) {
            case Constants.BIBLE_POS:
                bRet = bAuthBible;
                break;
            case Constants.JND_POS:
                bRet = bAuthJND;
                break;
            case Constants.JBS_POS:
                bRet = bAuthJBS;
                break;
            case Constants.CHM_POS:
                bRet = bAuthCHM;
                break;
            case Constants.FER_POS:
                bRet = bAuthFER;
                break;
            case Constants.CAC_POS:
                bRet = bAuthCAC;
                break;
            case Constants.JT_POS:
                bRet = bAuthJT;
                break;
            case Constants.GRC_POS:
                bRet = bAuthGRC;
                break;
            case Constants.AJG_POS:
                bRet = bAuthAJG;
                break;
            case Constants.SMC_POS:
                bRet = bAuthSMC;
                break;
            case Constants.MISC_POS:
                bRet = bAuthMisc;
                break;
            case Constants.HYMNS_POS:
                bRet = bAuthHymns;
                break;
        }
        return bRet;
    }

    public void setAuthSelected(int intAuth, boolean selected) {
        switch (intAuth) {
            case Constants.BIBLE_POS:
                bAuthBible = selected;
                break;
            case Constants.JND_POS:
                bAuthJND = selected;
                break;
            case Constants.JBS_POS:
                bAuthJBS = selected;
                break;
            case Constants.CHM_POS:
                bAuthCHM = selected;
                break;
            case Constants.FER_POS:
                bAuthFER = selected;
                break;
            case Constants.CAC_POS:
                bAuthCAC = selected;
                break;
            case Constants.JT_POS:
                bAuthJT = selected;
                break;
            case Constants.GRC_POS:
                bAuthGRC = selected;
                break;
            case Constants.AJG_POS:
                bAuthAJG = selected;
                break;
            case Constants.SMC_POS:
                bAuthSMC = selected;
                break;
            case Constants.MISC_POS:
                bAuthMisc = selected;
                break;
            case Constants.HYMNS_POS:
                bAuthHymns = selected;
                break;
        }
    }

    public boolean getBeep() {
        return bBeep;
    }

    public void setBeep(boolean selected) {
        bBeep = selected;
    }

    public boolean getSplashWindow() {
        return bSplashWindow;
    }

    public void setSplashWindow(boolean selected) {
        bSplashWindow = selected;
    }

    public boolean getAutoLoad() {
        return bAutoLoad;
    }

    public void setAutoLoad(boolean selected) {
        bAutoLoad = selected;
    }

    public boolean getFullScan() {
        return bFullScan;
    }

    public void setFullScan(boolean selected) {
        bFullScan = selected;
    }

    public boolean getDebugOn() {
        return bDebugOn;
    }

    public void setDebugOn(boolean selected) {
        bDebugOn = selected;
        if (selected) {
            Log.getLog().writeAlways("<br><font color=#FF0000>Logging turned on</font>");
        } else {
            Log.getLog().writeAlways("<br><font color=#FF0000>Logging turned off</font>");
        }
    }

    public int getLogDetail() {
        return intLogDetail;
    }

    public void setLogDetail(int selected) {
        intLogDetail = selected;
    }

    public static Options getOptions() {
        if (options == null) {
            options = new Options();
        }
        return options;
    }
}//Options