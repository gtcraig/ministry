//package com.asidua.mse;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

public class Log {
    private static Log log;
    Options options;
    Calendar calLastTime;

    private Log() {
        options = Options.getOptions();

        PrintWriter pwDebug = null;
        try {
            // MJP 1x 21/3/15
            pwDebug = new PrintWriter(new FileWriter(Constants.WORKING_DIR + File.separator + Constants.LOG_FILE, false));
            pwDebug.println("<html><head><title>Ministry Search Engine - Log File</title></head><center>");
            pwDebug.println("<img src=\"../images/log.gif\"><br></center><hr>");
            pwDebug.close();
        } catch (IOException ioe) {
            // MJP 1x 21/3/15
            new Alert("Error", "Failed to open log file " + Constants.WORKING_DIR + File.separator + Constants.LOG_FILE);
        }
    }//Log

    public void write(int intSeverity, String strMessage) {
        if (options.getDebugOn()) {
            if (intSeverity >= options.getLogDetail()) {
                writeAlways(strMessage);
            }
        }
    }//write

    public void writeAlways(String strMessage) {
        PrintWriter pwDebug = null;
        try {
            pwDebug = new PrintWriter(new FileWriter(Constants.WORKING_DIR + "/" + Constants.LOG_FILE, true));
            pwDebug.println(strMessage);
            pwDebug.close();
        } catch (IOException ioe) {
//            new Alert("Error", "Failed to open log file " + Constants.WORKING_DIR + "/" + LOG_FILE);
        }
    }//write

    public void writeTime(int intSeverity, String strMessage, boolean bShowElapsed) {
        String strElapsed = "";
        Calendar now = Calendar.getInstance();
        if ((bShowElapsed) && (calLastTime != null)) {
            strElapsed = " - " + (Utils.timeInMilliseconds(now) - Utils.timeInMilliseconds(calLastTime)) + " milliseconds elapsed";
        }
        calLastTime = now;
        String strTimeNow = Utils.leftZeroPad(now.get(Calendar.HOUR), 2) + ":" +
            Utils.leftZeroPad(now.get(Calendar.MINUTE), 2) + ":" +
            Utils.leftZeroPad(now.get(Calendar.SECOND), 2) + ":" +
            Utils.leftZeroPad(now.get(Calendar.MILLISECOND), 3);
        write(intSeverity, strMessage + " (at " + strTimeNow + strElapsed + ")");
    }//write

    public static Log getLog() {
        if (log == null) {
            log = new Log();
        }
        return log;
    }
}//Log