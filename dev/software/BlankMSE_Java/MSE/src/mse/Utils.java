//package com.asidua.mse;

import java.io.IOException;
import java.util.Calendar;

public class Utils {
    public static void openPageExternally(String browser, String url) {
        try {
            Runtime rt = Runtime.getRuntime();
            rt.exec(browser + " file:///" + Constants.WORKING_DIR + "/" + url);
        } catch (IOException ioe) {
            new Alert("Error", "Failed to open browser - check default browser in File/Options");
            Log.getLog().write(Constants.LOG_HIGH, "<br>Error opening browser: " + ioe);
        }
    }

    public static void openPage(String browser, String url) {
        if (browser.equals("")) {
            BrowserGUI browserGUI = new BrowserGUI(url);
            browserGUI.setVisible(true);
        } else {
            openPageExternally(browser, url);
        }
    }

    public static String leftZeroPad(int intIn, int intZeros) {
        StringBuffer sbZeros = new StringBuffer("0000000000");
        sbZeros.append(intIn);
        return sbZeros.toString().substring(sbZeros.length() - intZeros);
    }

    public static long timeInMilliseconds(Calendar time) {
        if (time == null) {
            return 0;
        } else {
            long hours = (time.get(Calendar.DATE) * 24) + time.get(Calendar.HOUR);
            long mins = (hours * 60) + time.get(Calendar.MINUTE);
            long secs = (mins * 60) + time.get(Calendar.SECOND);
            return (secs * 1000) + time.get(Calendar.MILLISECOND);
        }
    }
}//Utils