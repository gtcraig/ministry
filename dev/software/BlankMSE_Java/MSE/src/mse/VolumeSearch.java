//package com.asidua.mse;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;

public class VolumeSearch extends SearchEngine implements Runnable {
    SearchGUI gui;
    Progress progressSearch;
    Options options;
    Index index;
    Log log;

    public VolumeSearch (SearchGUI searchGUI, Progress progressIn) {
        
        gui = searchGUI;
        progressSearch = progressIn;
        options = Options.getOptions();
        log = Log.getLog();
        index = Index.getIndex();
    }

    public void run() {
        
        byte[] baRefs = null;
        String[] saRefsLeft = null;
        int intRefCount = 0;
        int intTotalRefs = 0;
        boolean bSearchedSomething = false;
        boolean bPhraseSearch = false;
        boolean bSentenceScope = false;
        boolean bParagraphScope = false;
        boolean bPageScope = false;
        int intRefsLeft = 0;
        boolean bstop = false;
        int intAuthCount = 0;
        int intAuthCurrCount = 0;
        int intProgress = 0;

        try {
            String strSearchText = gui.tfSearchString.getText().toLowerCase();
            log.writeTime(Constants.LOG_LOW, "<br>Starting search for \"" + strSearchText + "\"", false);
            //open results page & write header
            PrintWriter pwLog = null;
            try {
                pwLog = new PrintWriter(new FileWriter(Constants.RESULTS_FILE, false));
            } catch (IOException ioe) {
                new Alert("Error", "Failed to open " + Constants.RESULTS_FILE);
                log.write(Constants.LOG_LOW, "<br>Error opening results file: " + ioe);
            }
            pwLog.println("<html><head><title>Search Results</title></head>");
            pwLog.println("<body bgcolor=\"#FFFFFF\" link=\"#0000FF\" vlink=\"#0000FF\" alink=\"#0000FF\">");
            pwLog.println("<center><img src=\"../images/results.gif\"></center>");

            for (int intAuth = 0; intAuth < Constants.MAX_AUTH_POS + 1; intAuth++) {
                if (gui.cbToBeSearched[intAuth].isSelected()) {
                    intAuthCount++;
                }
            }
            float floatAuthsFactor = Constants.PROGRESS_BAR_MAX/(intAuthCount * 2);

            for (int intAuth = 0; intAuth < Constants.MAX_AUTH_POS + 1; intAuth++) {
                if (gui.rbPhrase.isSelected()) {
                    bPhraseSearch = true;
                    bSentenceScope = true;
                } else if (gui.rbSentence.isSelected()) {
                    bSentenceScope = true;
                } else if ((gui.rbParagraph.isSelected()) || (intAuth == Constants.BIBLE_POS) || (intAuth == Constants.HYMNS_POS)) {
                    bParagraphScope = true;
                } else if (gui.rbPage.isSelected()) {
                    bPageScope = true;
                }

                String strAuthDisplay = Constants.getAuthDisplay(intAuth);
                if (gui.cbToBeSearched[intAuth].isSelected()) {
                    bSearchedSomething = true;
                    String strAuth = Constants.getAuth(intAuth);
                    log.write(Constants.LOG_MEDIUM, "<br>Searching author: " + strAuthDisplay);
                    Hashtable htCompareWord = new Hashtable();
                    int intLowCount = Constants.TOO_FREQUENT;
                    int intLowIndex = -1;
                    int intCriteriaCount = 0;
                    boolean bFoundAll = true;
                    String strBasicSearchText = getBasicWords(strSearchText, true, true).trim();
                    int intFirstStarPos = strSearchText.indexOf("*");
                    int intSecondStarPos;

                    progressSearch.updateStatus("Loading " + strAuthDisplay + " index ...");
                    int intResult = index.loadIndex(intAuth);
                    switch (intResult) {
                        case Constants.INDEX_LOADED:
                            log.write(Constants.LOG_HIGH, "<br>Loaded " + strAuthDisplay + " index");
                            break;
                        case Constants.INDEX_RELOADED:
                            log.write(Constants.LOG_HIGH, "<br>Reloaded " + strAuthDisplay + " index");
                            break;
                        case Constants.INDEX_NOT_LOADED:
                            new Alert("Error", "Failed to load " + strAuthDisplay + " index");
                            progressSearch.close();
                            log.write(Constants.LOG_LOW, "<br>Failed to load " + strAuthDisplay + " index");
                            break;
                    }

                    progressSearch.updateStatus("Searching " + strAuthDisplay + " ...");

                    pwLog.print("<center><hr><h1><font color=\"#A00000\">Results of search through " + strAuthDisplay);
                    pwLog.println("</font></h1></center>");

                    boolean bWildSearch = true;
                    boolean bFirstWildWord = true;
                    StringBuffer sbSearchStrings = new StringBuffer();
                    if (intFirstStarPos == 0) {//wildcard at start (and end?)
                        pwLog.println("<b>Searching for: </b>");
                        intSecondStarPos = strSearchText.indexOf("*", intFirstStarPos + 1);
                        if (intSecondStarPos == -1) {//wildcard at start only
                            for (int x = 0; x < index.saWords.length; x++) {
                                int intExpectedPos = index.saWords[x].length() - strSearchText.length() + 1;
                                if ((intExpectedPos >= 0) &&
                                        (index.saWords[x].indexOf(strSearchText.substring(1, strSearchText.length())) == intExpectedPos)) {
                                    if (bFirstWildWord) {
                                        bFirstWildWord = false;
                                        pwLog.println(index.saWords[x]);
                                    } else {
                                        pwLog.println(", " + index.saWords[x]);
                                    }
                                    if (sbSearchStrings.length() > 0) {
                                        sbSearchStrings.append(",");
                                    }
                                    sbSearchStrings.append(index.saWords[x]);
                                }
                            }
                        } else {//wildcard at start & end
                            for (int x = 0; x < index.saWords.length; x++) {
                                if (index.saWords[x].indexOf(strSearchText.substring(1, strSearchText.length() - 1)) != -1) {
                                    if (bFirstWildWord) {
                                        bFirstWildWord = false;
                                        pwLog.println(index.saWords[x]);
                                    } else {
                                        pwLog.println(", " + index.saWords[x]);
                                    }
                                    if (sbSearchStrings.length() > 0) {
                                        sbSearchStrings.append(",");
                                    }
                                    sbSearchStrings.append(index.saWords[x]);
                                }
                            }
                        }
                    } else if (intFirstStarPos == strSearchText.length() - 1) {//wildcard at end only
                        pwLog.println("<b>Searching for: </b>");
                        for (int x = 0; x < index.saWords.length; x++) {
                            if (index.saWords[x].indexOf(strSearchText.substring(0, strSearchText.length() - 1)) == 0) {
                                if (bFirstWildWord) {
                                    bFirstWildWord = false;
                                    pwLog.println(index.saWords[x]);
                                } else {
                                    pwLog.println(", " + index.saWords[x]);
                                }
                                if (sbSearchStrings.length() > 0) {
                                    sbSearchStrings.append(",");
                                }
                                sbSearchStrings.append(index.saWords[x]);
                            }
                        }
                    } else {//no wildcard
                        bWildSearch = false;
                        sbSearchStrings.append(strBasicSearchText.replace(' ',','));
                    }
                    log.write(Constants.LOG_HIGH, "<br>Search Strings: " + sbSearchStrings.toString());

                    String strSearchStrings = sbSearchStrings.toString();

                    //compile list of search words
                    StringTokenizer stSearchWords = new StringTokenizer(strSearchStrings, ",");
                    String[] saSearchWords = new String[stSearchWords.countTokens()];
                    int intWordIndex = 0;
                    while (stSearchWords.hasMoreTokens()) {//each word in search string
                        saSearchWords[intWordIndex] = stSearchWords.nextToken();
                        intWordIndex++;
                    }

                    for (int x = 0; x < saSearchWords.length; x++) {
                        String strWord = saSearchWords[x];
                        int intIndex = index.getIndexPos(strWord);
                        if (intIndex != Constants.NOT_FOUND) {//found word in index
                            baRefs = index.getRefs(intIndex);
                            if (baRefs != null) {//infrequent word
                                int intCurrCount = baRefs.length;
                                if (intCurrCount < intLowCount) {//lowest so far
                                    intLowCount = intCurrCount;
                                    intLowIndex = intIndex;
                                }//lowest so far
                                intCriteriaCount++;
                            } else {//too frequent word
                                log.write(Constants.LOG_MEDIUM, "<br>'" + strWord + "' is too frequent");
                            }
                        } else {//didn't find word in index
                            log.write(Constants.LOG_MEDIUM, "<br>Couldn't find any occurrence of '" + strWord + "'");
                            bFoundAll = false;
                        }//didn't find word in index
                    }//each word in search string

                    String strLowestWordRefs = "";
                    if ((intLowIndex != -1) && (bFoundAll)) {//at least one searchable word
                        progressSearch.updateStatus("Found least frequent word: " + index.saWords[intLowIndex]);

                        StringBuffer sbLowestWordRefs = new StringBuffer();
                        String strPage = "";
                        baRefs = index.getRefs(intLowIndex);
                        if (baRefs != null) {//infrequent word - should always be true
                            int intCurrVol = 0;
                            int intCurrPage = 0;
                            for (int x = 0; x <= baRefs.length - 1; x++) {//each reference
                                int byteCurr = intFromByte(baRefs[x]);
                                if (byteCurr == 0) {//new volume
                                    x++;
                                    intCurrVol = intFromByte(baRefs[x]);
                                    intCurrPage = 0;
                                } else {//reference
                                    if (byteCurr == 255) {//large delta
                                        x++;
                                        int intHigh = intFromByte(baRefs[x]);
                                        x++;
                                        int intLow = intFromByte(baRefs[x]);
                                        intCurrPage = intCurrPage + (intHigh * 254) + intLow;
                                    } else {//small delta
                                        intCurrPage = intCurrPage + byteCurr;
                                    }//small delta
                                    sbLowestWordRefs.append(Utils.leftZeroPad(intCurrVol, Constants.MAX_DIGITS_IN_VOL_NUM) + "/" +
                                        Utils.leftZeroPad(intCurrPage, Constants.MAX_DIGITS_IN_PAGE_NUM) + " ");
                                }//reference
                            }//each reference
                        }//infrequent word - should always be true
                        progressSearch.updateStatus("Built index for: " + index.saWords[intLowIndex]);
                        log.write(Constants.LOG_HIGH, "<br>References to " + index.saWords[intLowIndex] + " (least frequent): " + sbLowestWordRefs.toString());

                        strLowestWordRefs = sbLowestWordRefs.toString();

                        if (intCriteriaCount > 1) {//more than one infrequent word
                            StringBuffer sbCurrentWordRefs = new StringBuffer();

                            for (int y = 0; y < saSearchWords.length; y++) {
                                String strWord = saSearchWords[y];
                                int intIndex = index.getIndexPos(strWord);
                                if (intIndex != Constants.NOT_FOUND) {//found word in index
                                    if (intIndex != intLowIndex) {//not Lowest
                                        htCompareWord.clear();
                                        sbCurrentWordRefs.setLength(0);

                                        baRefs = index.getRefs(intIndex);
                                        if (baRefs != null) {//infrequent word
                                        log.write(Constants.LOG_HIGH, "<br>" + strWord + ": ");

                                            int intCurrVol = 0;
                                            int intCurrPage = 0;
                                            for (int x = 0; x < baRefs.length; x++) {//each reference
                                                int byteCurr = intFromByte(baRefs[x]);
                                                if (byteCurr == 0) {//new volume
                                                    x++;
                                                    intCurrVol = intFromByte(baRefs[x]);
                                                    intCurrPage = 0;
                                                } else {//reference
                                                    if (byteCurr == 255) {//large delta
                                                        x++;
                                                        int intHigh = intFromByte(baRefs[x]);
                                                        x++;
                                                        int intLow = intFromByte(baRefs[x]);
                                                        intCurrPage = intCurrPage + (intHigh * 254) + intLow;
                                                    } else {//small delta
                                                        intCurrPage = intCurrPage + byteCurr;
                                                    }//small delta
                                                    String strRef = Utils.leftZeroPad(intCurrVol, Constants.MAX_DIGITS_IN_VOL_NUM) + "/" +
                                                        Utils.leftZeroPad(intCurrPage, Constants.MAX_DIGITS_IN_PAGE_NUM);
                                                    log.write(Constants.LOG_HIGH, strRef + " ");
                                                    if (bWildSearch) {
                                                        sbCurrentWordRefs.append(strRef + " ");
                                                    } else {
                                                        htCompareWord.put(strRef, "");
                                                    }
                                                }//reference
                                            }//each reference
                                            progressSearch.updateStatus("Built index for: " + strWord);

                                            if (bWildSearch) {
                                                log.write(Constants.LOG_HIGH, "<table border=\"1\"><tr><td>strRefLowest</td><td>strRefCurr</td><td>intCompare</td></tr>");
                                                int intCharPosLowest = 0;
                                                int intCharPosCurr = 0;
                                                String strCurrentWordRefs = sbCurrentWordRefs.toString();

                                                while ((intCharPosLowest < strLowestWordRefs.length()) &&
                                                        (intCharPosCurr < strCurrentWordRefs.length())) {

                                                    String strRefLowest = strLowestWordRefs.substring(intCharPosLowest, intCharPosLowest +
                                                        Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 1);
                                                    String strRefCurr = strCurrentWordRefs.substring(intCharPosCurr, intCharPosCurr +
                                                        Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 1);

                                                    int intCompare = strRefLowest.compareTo(strRefCurr);
                                                    log.write(Constants.LOG_HIGH, "<tr><td>" + strRefLowest + "</td><td>" + strRefCurr + "</td><td>" + intCompare + "</td></tr>");
                                                    if (intCompare == 0) {//already in lowest - increment both
                                                        intCharPosLowest = intCharPosLowest + Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2;
                                                        intCharPosCurr = intCharPosCurr + Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2;
                                                    } else if (intCompare > 0) {//not in lowest
                                                        //ref is not already in list of references for least frequent word
                                                        //add to sbLowestWordRefs
                                                        strLowestWordRefs = strLowestWordRefs.substring(0, intCharPosLowest) +
                                                            strRefCurr + " " +
                                                            strLowestWordRefs.substring(intCharPosLowest);
                                                        intCharPosLowest = intCharPosLowest + Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2;
                                                        intCharPosCurr = intCharPosCurr + Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2;
                                                    } else {//in lowest but not curr
                                                        intCharPosLowest = intCharPosLowest + Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2;
                                                    }
                                                }//each ref
                                                while (intCharPosCurr < strCurrentWordRefs.length()) {
                                                        //some refs left in strCurrentWordRefs - add to sbLowestWordRefs
                                                        String strRefCurr = strCurrentWordRefs.substring(intCharPosCurr, intCharPosCurr +
                                                            Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 1);
                                                        log.write(Constants.LOG_HIGH, "<tr><td>n/a</td><td>" + strRefCurr + "</td><td>n/a</td></tr>");

                                                        strLowestWordRefs = strLowestWordRefs.substring(0, intCharPosLowest) +
                                                            strRefCurr + " " +
                                                            strLowestWordRefs.substring(intCharPosLowest);
                                                        intCharPosLowest = intCharPosLowest + Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2;
                                                        intCharPosCurr = intCharPosCurr + Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2;
                                                }
                                                log.write(Constants.LOG_HIGH, "</tr></table>");
                                                log.write(Constants.LOG_HIGH, "<br>Union: " + strLowestWordRefs);
                                            } else {//not wildcard search
                                                //check lowest array against this one
                                                int intCharPos = 0;
                                                String strRef = "";
                                                String strVol = "";
                                                int intPage = 0;
                                                String strPreRef = "";
                                                String strPostRef = "";
                                                while ((intCharPos < strLowestWordRefs.length()) && (htCompareWord.size() > 0)) {
                                                    strRef = strLowestWordRefs.substring(intCharPos, intCharPos +
                                                        Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 1);
                                                    strVol = strRef.substring(0, Constants.MAX_DIGITS_IN_VOL_NUM + 1);
                                                    intPage = Integer.parseInt(strRef.substring(Constants.MAX_DIGITS_IN_VOL_NUM + 1));
                                                    strPreRef = strVol + Utils.leftZeroPad(intPage - 1, Constants.MAX_DIGITS_IN_PAGE_NUM);
                                                    strPostRef = strVol + Utils.leftZeroPad(intPage + 1, Constants.MAX_DIGITS_IN_PAGE_NUM);

                                                    if ((htCompareWord.get(strRef) == null) &&
                                                            (htCompareWord.get(strPreRef) == null) &&
                                                            (htCompareWord.get(strPostRef) == null)) {
                                                        //ref is not page before/after ref in list of references for least frequent word
                                                        //remove from sbLowestWordRefs
                                                        strLowestWordRefs = strLowestWordRefs.substring(0, intCharPos) +
                                                            strLowestWordRefs.substring(intCharPos +
                                                            Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2);
                                                    } else {
                                                        intCharPos = intCharPos  + Constants.MAX_DIGITS_IN_VOL_NUM + Constants.MAX_DIGITS_IN_PAGE_NUM + 2;
                                                    }
                                                }//each ref
                                            }//not wildcard search
                                        }//infrequent word
                                    }//not Lowest
                                }//found word in index
                            }//each word again
                        }//more than one infrequent word
                    } else if ((bFoundAll) && (options.getFullScan())) {//need full scan
                        progressSearch.updateStatus("Preparing full scan for " + strAuthDisplay + " ...");
                        StringBuffer sbLowestWordRefs = new StringBuffer();
                        boolean bLastVolume = false;
                        int intCurrTryVolume = 1;
                        while (!bLastVolume) {
                            int intPages = index.getBookPages(intAuth, intCurrTryVolume);
                            if (intPages == Constants.NOT_FOUND) {
                                bLastVolume = true;
                            } else {
                                for (int intCurrPage = 1; intCurrPage <= intPages; intCurrPage++) {
                                    String strRef = Utils.leftZeroPad(intCurrTryVolume, Constants.MAX_DIGITS_IN_VOL_NUM) + "/" +
                                        Utils.leftZeroPad(intCurrPage, Constants.MAX_DIGITS_IN_PAGE_NUM);
                                    sbLowestWordRefs.append(" " + strRef);
                                }
                                intCurrTryVolume++;
                            }
                        }
                        strLowestWordRefs = sbLowestWordRefs.toString();
                    }

                    //compile list of refs left
                    StringTokenizer stLowestWordRefs = new StringTokenizer(strLowestWordRefs, " ");
                    intRefsLeft = stLowestWordRefs.countTokens();
                    saRefsLeft = new String[intRefsLeft];
                    log.write(Constants.LOG_MEDIUM, "<br>Pages to be searched: ");
                    for (int x = 0; x < intRefsLeft; x++) {//each word in search string
                        saRefsLeft[x] = stLowestWordRefs.nextToken();
                        log.write(Constants.LOG_MEDIUM, saRefsLeft[x] + " ");
                    }

                    //print what's left
                    int intMatchesFound = 0;
                    intRefCount = 0;
                    String strLastVol = "";
                    String strCurrVol = "";
                    int intRead = 0;
                    File fVol;
                    FileInputStream fisVol;
                    long longOffset = -1;
                    int intLength = -1;
                    String strExtract;
                    String strVolFilename;
                    String strExtractRef;
                    String strSearchArea;
                    String strPrev;
                    String strLowestWord;
                    StringBuffer sbExtract;
                    int intLowestPos = -1;
                    String strLastExtractRef = "";

                    //process each page that contains a match
                    float floatRefsFactor = floatAuthsFactor/intRefsLeft;
                    progressSearch.updateStatus("Building results page for " + strAuthDisplay + " ...");
                    for (int x = 0; x < intRefsLeft; x++) {
                        String strRef = saRefsLeft[x];

                        //extract volume & page number
                        int intCurrVol = Integer.parseInt(strRef.substring(0, Constants.MAX_DIGITS_IN_VOL_NUM));
                        intProgress = (int)((intAuthCurrCount * 2 * floatAuthsFactor) + (floatAuthsFactor) + (x * floatRefsFactor));
      //                  intProgress = (int)(((((float)x)/intRefsLeft) * (Constants.PROGRESS_BAR_MAX/(intAuthCount * 2))) +
      //                      (((float)(intAuthCurrCount)/intAuthCount) * (Constants.PROGRESS_BAR_MAX)) + (Constants.PROGRESS_BAR_MAX/(intAuthCount * 2)));
                        progressSearch.set("Searching " + strAuthDisplay + " " + strRef + " ... ", intProgress);
                        int intCurrPage = Integer.parseInt(strRef.substring(Constants.MAX_DIGITS_IN_VOL_NUM + 1));
                        strCurrVol = intCurrVol + "";
                        strRef = intCurrVol + "/" + intCurrPage;

                        //find offset within file & length of page containing match
                        longOffset = index.getPageOffset(strRef);
                        if (longOffset != Constants.NOT_FOUND) {
                            intLength = index.getPageLength(strRef);
                            byte[] bytesIn = new byte[intLength];

                            //compile file name
                            if (strAuth.equals("bible")) {
                                
                                // MJP 1x 15/3/15
                                strVolFilename = "bible" + File.separator + Constants.getBook(intCurrVol - 1) + ".htm";
                            } else {
                                // MJP 21/3/15
                                strVolFilename = strAuth + File.separator + strAuth + strCurrVol + ".htm";
                            }

                            //open file
                            fVol = new File(strVolFilename);
                            fisVol = null;
                            try {
                                fisVol = new FileInputStream(fVol);
                            } catch (FileNotFoundException fnfe) {
                                new Alert("Error", "Failed to open " + strVolFilename);
                                log.write(Constants.LOG_LOW, "<br>Error opening volume: " + fnfe);
                            }

                            try {
                                //skip to the start of the sentence at the top of the page
                                fisVol.skip(longOffset);
                                //read in full page
                                intRead = fisVol.read(bytesIn);
                            } catch (IOException ioe) {
                                new Alert("Error", "Failure reading " + strVolFilename);
                                log.write(Constants.LOG_LOW, "<br>Error reading page: " + ioe);
                            }

                            strSearchArea = (new String(bytesIn)).substring(0, intRead - 1);

                            log.write(Constants.LOG_HIGH, "<table border=\"1\"><tr><td valign=\"top\">" + strRef + "<br>offset:" + longOffset + "<br>expected&nbsp;length:" + intLength +
                                "<br>actual&nbsp;length:" + intRead + "</td><td>" + strSearchArea + "</td></tr></table>");

                            if (intLength > 0) {//not an empty page
                                //carve off first bit
                                boolean bFinished = false;
                                int intStartCharPos = 0;
                                int intEndCharPos = 0;

                                if (bSentenceScope) {
                                    intEndCharPos = findSentence(strSearchArea, intStartCharPos, intAuth);
                                } else if (bParagraphScope) {
                                    intEndCharPos = findParagraph(strSearchArea, intStartCharPos);
                                } else if (bPageScope) {
                                    intEndCharPos = strSearchArea.length();
                                }

                                while (!bFinished) {
                                    strExtract = strSearchArea.substring(intStartCharPos, intEndCharPos);
                                    int intRefStart = strSearchArea.indexOf("name=", intStartCharPos);
                                    strExtractRef =
                                        strSearchArea.substring(intRefStart + 5, strSearchArea.indexOf(">", intRefStart + 5)).trim();

                                    log.write(Constants.LOG_HIGH, "<table border=\"1\"><tr><td valign=\"top\">" + strExtractRef + "<br>start&nbsp;position:" + intStartCharPos +
                                        "<br>end&nbsp;position:" + intEndCharPos + "</td><td>" + strExtract + "</td></tr></table>");

                                    boolean bFoundMatch = false;
                                    if (bWildSearch) {
                                        bFoundMatch = wildSearch(strExtract, saSearchWords);
                                    } else if (bPhraseSearch) {
                                        bFoundMatch = phraseSearch(strExtract, strBasicSearchText);
                                    } else {
                                        bFoundMatch = wordSearch(strExtract, saSearchWords);
                                    }

                                    if ((bFoundMatch) && (!strLastExtractRef.equals(strCurrVol + "/" + strExtractRef))) {
                                        strLastExtractRef = strCurrVol + "/" + strExtractRef;
                                        //found match
                                        log.write(Constants.LOG_HIGH, "<br>Found match in <b>" + strCurrVol + "/" + strExtractRef + "</b>");
                                        if (!strCurrVol.equals(strLastVol)) {
                                            //print volume
                                            String strBookName = index.getBookName(intAuth, intCurrVol);
                                            if (intAuth == Constants.BIBLE_POS) {
                                                pwLog.println("</table><br><h3>" + strBookName + "</h3><table cellspacing=\"0\" cellpadding=\"5\" border =\"1\">");
                                                pwLog.println("<tr><td>&nbsp;</td><td><b>Darby Translation (1889)</b></td><td><b>Authorised (King James) Version (1769)</b></td></tr>");
                                            } else {
                                                pwLog.println("<h3>" + strBookName + "</h3>");
                                            }
                                        }
                                        //print sentence containing match
                                        String strPrintedRef;
                                        if (strExtractRef.indexOf(":") != -1) {
                                            strPrintedRef = strExtractRef.substring(0, strExtractRef.indexOf(":"));
                                        } else {
                                            strPrintedRef = strExtractRef;
                                        }

                                        if (strAuth.equals("bible")) {
                                            if (bParagraphScope) {
                                                //remove leading headers
                                                String strHeaderEnd = "(1769)</b>";
                                                String strFormattedResult = strExtract.substring(strExtract.indexOf(strHeaderEnd) + strHeaderEnd.length());
                                                int intChapterEnd = strFormattedResult.indexOf(":0");
                                                if (intChapterEnd != -1) {//remove trailing headers
                                                    strFormattedResult = formatSection(strFormattedResult.substring(0, intChapterEnd + 7), saSearchWords, false);
                                                } else {
                                                    strFormattedResult = formatSection(strFormattedResult, saSearchWords, false);
                                                }

                                                pwLog.println("<tr bgcolor=\"#D0D0D0\"><td colspan=\"3\" align=\"center\" valign=\"middle\"><b><a href=\"../bible/" + Constants.getBook(intCurrVol - 1) +
                                                    ".htm#" + strExtractRef + "\">Chapter " + strPrintedRef + "</a></b></td></tr>");
                                                pwLog.println(strFormattedResult + "</td></tr>");
                                            } else {
                                                String strFormattedResult = formatSection(strExtract, saSearchWords, false);
                                                strFormattedResult = strFormattedResult.substring(strFormattedResult.indexOf("</td><td>") + 9);
                                                pwLog.println("<tr valign=\"top\"><td><a href=\"../bible/" + Constants.getBook(intCurrVol - 1) +
                                                    ".htm#" + strExtractRef + "\">" +
                                                    strExtractRef + "</a></td><td>" + strFormattedResult +
                                                    "</td></tr>");
                                            }
                                        } else {
                                            //set up appropriate name for a 'page'
                                            String strPageTitle;
                                            if (strAuth.equals("bible")) {
                                                strPageTitle = "";
                                            } else if (strAuth.equals("hymns") && (intCurrVol <= Constants.LAST_HYMNBOOK)) {
                                                strPageTitle = "Hymn";
                                            } else {
                                                strPageTitle = "Page";
                                            }

                                            pwLog.print("<a href=\"../" + strAuth + "/" + strAuth +
                                                strCurrVol + ".htm#" + strExtractRef + "\">" + strPageTitle + " ");
                                            pwLog.print(strPrintedRef);
                                            pwLog.println("</a> " + formatSection(strExtract, saSearchWords, true) + "<br>");
                                        }
                                        intRefCount++;
                                        strLastVol = strCurrVol;
                                    }//found match

                                    if (intEndCharPos == strSearchArea.length()) {
                                        bFinished = true;
                                    } else {
                                        //look for next bit
                                        intStartCharPos = intEndCharPos;
                                        if (bSentenceScope) {
                                            intEndCharPos = findSentence(strSearchArea, intStartCharPos, intAuth);
                                        } else {//must be paragraph
                                            intEndCharPos = findParagraph(strSearchArea, intStartCharPos);
                                        }
                                    }
                                }
                            }

                            //close volume
                            try {
                                fisVol.close();
                            } catch (IOException ioe) {
                                new Alert("Error", "Failed to close " + strVolFilename);
                                log.write(Constants.LOG_LOW, "<br>Error closing volume: " + ioe);
                            }
//                        } else {
//                            pwLog.println(Constants.LOG_HIGH, "ERROR: Couldn't find page offset for " + strRef);
                        }
                        intMatchesFound++;
                    }

                    //summarise success rate
                    if (strAuth.equals("bible")) {
                        pwLog.println("</tr></table>");
                    }
                    pwLog.println("<br><center><b><font color=\"#FF0000\">");
                    if (intMatchesFound == 0) {
                        if (intCriteriaCount == 0 && bFoundAll) {
                            pwLog.println("All the search words occur too frequently to be used as search criteria - ");
                            pwLog.println("specify more words in search string or use File/Options to enable full scan");
                        } else {
                            pwLog.println("No matches found in " + strAuthDisplay);
                        }
                    } else if (intRefCount == 0) {
                        pwLog.println("Found no references in " + strAuthDisplay);
                    } else if (intRefCount == 1) {
                        pwLog.println("Found only one reference in " + strAuthDisplay);
                    } else {
                        pwLog.println("Found " + intRefCount + " references in " + strAuthDisplay);
                    }
                    pwLog.println("</font></b></center>");
                    intTotalRefs = intTotalRefs + intRefCount;
                    intAuthCurrCount++;
                    intProgress = (int)(((intAuthCurrCount) * 2 * floatAuthsFactor) + (floatAuthsFactor));
//                intProgress = (int)(((float)intAuthCurrCount/intAuthCount) * Constants.PROGRESS_BAR_MAX);
                    progressSearch.set("Searched " + strAuthDisplay, intProgress);
                }
            }//for

            pwLog.println("<hr>Total References: " + intTotalRefs);
            pwLog.println("</body></html>");
            pwLog.close();
            progressSearch.set("Built results page", Constants.PROGRESS_BAR_MAX); //finished
            gui.buttonRefine.setEnabled(true);

            if (bSearchedSomething) {
                Utils.openPage(options.getDefaultBrowser(), Constants.RESULTS_FILE);
            } else {
                new Alert("Information", "Select at least one checkbox before clicking the Search button");
            }

            //save settings for next time
            options.setSearchString(strSearchText);
            if (gui.rbPhrase.isSelected()) {
                options.setSearchType("Phrase");
            } else if (gui.rbSentence.isSelected()) {
                options.setSearchType("Sentence");
            } else if (gui.rbParagraph.isSelected()) {
                options.setSearchType("Paragraph");
            } else if (gui.rbPage.isSelected()) {
                options.setSearchType("Page");
            }

            for (int x = 0; x <= Constants.MAX_AUTH_POS; x++) {
                options.setAuthSelected(x, gui.cbaAuths[x].isSelected());
            }
            options.saveOptions();

            log.writeTime(Constants.LOG_LOW, "<br>Completed search", true);
            log.write(Constants.LOG_LOW, "<br><hr>");
        } catch (StopException se) {
            log.writeTime(Constants.LOG_LOW, "<br>Aborted search", true);
            log.write(Constants.LOG_LOW, "<br><hr>");
        }

        progressSearch.close();
        gui.enableButtons(true);
    }
}//VolumeSearch


