//package com.asidua.mse;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.awt.Toolkit;

public class ResultsSearch extends SearchEngine implements Runnable {
    SearchGUI gui;
    Progress progressSearch;
    Options options;
    Index index;
    Log log;

    public ResultsSearch (SearchGUI searchGUI, Progress progressIn) {
        gui = searchGUI;
        progressSearch = progressIn;
        options = Options.getOptions();
        log = Log.getLog();
        index = Index.getIndex();
    }

    public void run() {
        byte[] baRefs = null;
        int intRefCount = 0;
        int intTotalRefs = 0;
        boolean bSearchedSomething = false;
        boolean bExclude = false;
        int intResultNumber = 1;

        String strSearchText = gui.tfSearchString.getText().toLowerCase();
        if (strSearchText.indexOf("!") == 0) {
            bExclude = true;
            strSearchText = strSearchText.substring(1);
        }
        String strBasicSearchText = getBasicWords(strSearchText, true, true).trim();
        log.writeTime(Constants.LOG_LOW, "<br>Starting refined search for \"" + strSearchText + "\"", false);

        //parse previous results file
        File fResults = new File(Constants.RESULTS_FILE);
        if (fResults.exists()) {
            try {
                BufferedReader brResults = new BufferedReader(new FileReader(Constants.RESULTS_FILE));

                //open temp results page & write header
                PrintWriter pwLog = null;
                try {
                    pwLog = new PrintWriter(new FileWriter(Constants.RESULTS_FILE_TMP, false));
                } catch (IOException ioe) {
                    new Alert("Error", "Failed to open " + Constants.RESULTS_FILE);
                    log.write(Constants.LOG_LOW, "<br>Error opening results file: " + ioe);
                }
                pwLog.println("<html><head><title>Refined Search Results</title></head>");
                pwLog.println("<body bgcolor=\"#FFFFFF\" link=\"#0000FF\" vlink=\"#0000FF\" alink=\"#0000FF\">");
                pwLog.println("<center><img src=\"../images/results.gif\"></center>");

                boolean bFirstBook = true;
                boolean bNewBook = false;
                boolean bUsedTable = false;
                String strBookLine = "";
                boolean bEndOfFile = false;
                while (!bEndOfFile) {
                    String strLine = brResults.readLine();
                    if (strLine == null) {
                        bEndOfFile = true;
                        continue;
                    }

                    if (strLine.indexOf("<h1>") != -1) {
                        if (!bFirstBook) {
                            if (bUsedTable) {
                                pwLog.println("</table>");
                                bUsedTable = false;
                            }

                            pwLog.println("<br><center><b><font color=\"#FF0000\">");
                            if (intRefCount == 0) {
                                pwLog.println("Found no references");
                            } else if (intRefCount == 1) {
                                pwLog.println("Found only one reference");
                            } else {
                                pwLog.println("Found " + intRefCount + " references");
                            }
                            pwLog.println("</font></b></center>");
                        } else {
                            bFirstBook = false;
                        }
                        pwLog.println(strLine);
                        intRefCount = 0;
                    } else if (strLine.indexOf("<h3>") != -1) {
                        strBookLine = strLine;
                        bNewBook = true;
                    } else if (strLine.indexOf("href") != -1) {
                        progressSearch.updateStatus("Refining previous result " + intResultNumber + " ...");
                        intResultNumber++;
                        boolean bMatchFound = phraseSearch(strLine, strBasicSearchText);
                        if ((bMatchFound & !bExclude) || (!bMatchFound & bExclude)) {
                            if (bNewBook) {
                                pwLog.println(strBookLine);
                                bNewBook = false;
                            }
                            pwLog.println(strLine);
                            if (strLine.indexOf("</td><td>") != -1) {
                                bUsedTable = true;
                            }
                            intRefCount = intRefCount + 1;
                            intTotalRefs = intTotalRefs + 1;
                        }
                    }
                }
                brResults.close();

                if (bUsedTable) {
                    pwLog.println("</table>");
                    bUsedTable = false;
                }

                pwLog.println("<br><center><b><font color=\"#FF0000\">");
                if (intRefCount == 0) {
                    pwLog.println("Found no references");
                } else if (intRefCount == 1) {
                    pwLog.println("Found only one reference");
                } else {
                    pwLog.println("Found " + intRefCount + " references");
                }
                pwLog.println("</font></b></center>");

                pwLog.println("<hr>Total References: " + intTotalRefs);
                pwLog.println("</body></html>");
                pwLog.close();
                progressSearch.increment("Built refined results page");

                log.writeTime(Constants.LOG_LOW, "<br>Completed search", true);
                log.write(Constants.LOG_LOW, "<br><hr>");

                fResults.delete();
                File fTempResults = new File(Constants.RESULTS_FILE_TMP);
                fTempResults.renameTo(fResults);

                Utils.openPage(options.getDefaultBrowser(), Constants.RESULTS_FILE);
            } catch (IOException ioe) {
                log.writeTime(Constants.LOG_LOW, "<br>File error", true);
                log.write(Constants.LOG_LOW, "<br><hr>");
            } catch (StopException se) {
                log.writeTime(Constants.LOG_LOW, "<br>Aborted search", true);
                log.write(Constants.LOG_LOW, "<br><hr>");
            }
            progressSearch.close();
            Toolkit.getDefaultToolkit().beep();
            gui.enableButtons(true);
        }
    }

/*
                intTotalRefs = intTotalRefs + intRefCount;
            }
            progressSearch.set("Searched " + strAuthDisplay + "", (intAuth + 1) * Constants.STEPS_IN_SEARCH);
        }//for

    }
*/
}//ResultsSearch


