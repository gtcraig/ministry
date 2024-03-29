//package com.asidua.mse;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.StreamCorruptedException;
import java.util.Hashtable;
import java.util.Vector;

public class Index {
    private static Index index;

    //bible always is, "Bible", "JND", "JBS", "CHM", "FER", "CAC", "JT", "GRC", "AJG", "SMC", "Misc", "Hymns"
    boolean[] bIndexAvailable = {true, false, false, false, false, false, false,
        false, false, false, false, false};
    boolean[] bIndexLoaded = {false, false, false, false, false, false, false,
        false, false, false, false, false};

    //generated from saWords, key is word id
    Hashtable htWords;

    //generated from laOffsets, key from same index in saVolPages
    Hashtable htOffsets;

    //generated from laLengths, key from same index in saVolPages
    Hashtable htLengths;

    public String[] saWords; //List of words indexed by word id and stored in index file
    Vector vOccurs; //List of occurrences "strings" and stored in index file
    String[] saVolPages; //List of vol/page numbers and stored in index file
    long[] laOffsets; //List of page offsets in html file (same index as saVolPages) and stored in index file
    long[] laLengths; //List of page lengths in html file (same index as saVolPages) and stored in index file

    String[][] saAuthWords = new String[Constants.MAX_AUTH_POS + 1][]; //cache of saWords for each author
    Hashtable[] htAuthWords = new Hashtable[Constants.MAX_AUTH_POS + 1]; //cache of htWords for each author
    Hashtable[] htAuthOffsets = new Hashtable[Constants.MAX_AUTH_POS + 1]; //cache of htOffsets for each author
    Hashtable[] htAuthLengths = new Hashtable[Constants.MAX_AUTH_POS + 1]; //cache of htLengths for each author
    Vector[] vAuthOccurs = new Vector[Constants.MAX_AUTH_POS + 1]; //cache of vOccurs for each author

    Hashtable htBookNames = new Hashtable();
    Hashtable htBookPages = new Hashtable();

    Log log;
    Options options;

    private Index() {
        log = Log.getLog();
        options = Options.getOptions();

        File fJND = new File("jnd");
        if (fJND.isDirectory()) {
            bIndexAvailable[Constants.JND_POS] = true;
        }
        File fJBS = new File("jbs");
        if (fJBS.isDirectory()) {
            bIndexAvailable[Constants.JBS_POS] = true;
        }
        File fCHM = new File("chm");
        if (fCHM.isDirectory()) {
            bIndexAvailable[Constants.CHM_POS] = true;
        }
        File fFER = new File("fer");
        if (fFER.isDirectory()) {
            bIndexAvailable[Constants.FER_POS] = true;
        }
        File fCAC = new File("cac");
        if (fCAC.isDirectory()) {
            bIndexAvailable[Constants.CAC_POS] = true;
        }
        File fJT = new File("jt");
        if (fJT.isDirectory()) {
            bIndexAvailable[Constants.JT_POS] = true;
        }
        File fGRC = new File("grc");
        if (fGRC.isDirectory()) {
            bIndexAvailable[Constants.GRC_POS] = true;
        }
        File fAJG = new File("ajg");
        if (fAJG.isDirectory()) {
            bIndexAvailable[Constants.AJG_POS] = true;
        }
        File fSMC = new File("smc");
        if (fSMC.isDirectory()) {
            bIndexAvailable[Constants.SMC_POS] = true;
        }
        File fMisc = new File("misc");
        if (fMisc.isDirectory()) {
            bIndexAvailable[Constants.MISC_POS] = true;
        }
        File fHymns = new File("hymns");
        if (fHymns.isDirectory()) {
            bIndexAvailable[Constants.HYMNS_POS] = true;
        }

        if (options.getAutoLoad()) {
            Progress progressAutoLoad = new Progress("Pre-loading indexes ...",
                Constants.MAX_AUTH_POS + 1);
            try {
                for (int intAuth = 0; intAuth <= Constants.MAX_AUTH_POS;
                        intAuth++) {
                    progressAutoLoad.increment("Loading " +
                        Constants.getAuthDisplay(intAuth) + " index ...");
                    loadIndex(intAuth);
                }
            } catch (StopException se) {
                log.write(Constants.LOG_LOW, "<br>Stopped index pre-load");
            }
            progressAutoLoad.close();
        }

        //load book titles etc.
        for (int intAuth = 0; intAuth <= Constants.MAX_AUTH_POS; intAuth++) {
            if (bIndexAvailable[intAuth]) {
                String strAuth = Constants.getAuth(intAuth);
                
                // MJP 1x 20/3/15
                String strBooksFilename = Constants.BASIC_JAVA_FILE_PATH + strAuth + File.separator + strAuth +
                    "_vols.txt";
                boolean bLastPage = false;
                try {
                    BufferedReader brBookDetails =
                        new BufferedReader(new FileReader(strBooksFilename));
                    while (!bLastPage) {
                        String strCurrPage = brBookDetails.readLine();
                        if (strCurrPage == null) {
                            bLastPage = true;
                            continue;
                        }
                        int intFirstComma = strCurrPage.indexOf("~");
                        int intSecondComma =
                            strCurrPage.indexOf("~", intFirstComma + 1);
                        String strCurrBookKey =
                            strCurrPage.substring(0, intFirstComma);
                        String strCurrBookTitle =
                            strCurrPage.substring(intFirstComma + 1,
                            intSecondComma);
                        String strCurrBookPages =
                            strCurrPage.substring(intSecondComma + 1);
                        htBookNames.put(strCurrBookKey, strCurrBookTitle);
                        htBookPages.put(strCurrBookKey, strCurrBookPages);
                    }
                } catch (IOException ioe) {
                    new Alert("Error",
                        "Failed to open file " + strBooksFilename);
                    log.write(Constants.LOG_LOW,
                        "<br>Error opening file: " + ioe);
                }
            }
        }
    }//Index

    public boolean isAvailable(int pos) {
        return bIndexAvailable[pos];
    }//isAvailable

    public int loadIndex(int intAuth) {
        int intResult;
        String strAuth = Constants.getAuth(intAuth);
        String strIndexFilename;

        if (!bIndexLoaded[intAuth]) {
            //try to read indexes
            // MJP 1x 15/3/15
            strIndexFilename = Constants.BASIC_JAVA_FILE_PATH + strAuth + "/" + strAuth + ".idx";
            File fIndex = new File(strIndexFilename);
            if (fIndex.exists()) {
                htWords = new Hashtable();
                htOffsets = new Hashtable();
                htLengths = new Hashtable();
                vOccurs = new Vector();

                FileInputStream fisIndex = null;
                try {
                    fisIndex = new  FileInputStream(fIndex);
                } catch (FileNotFoundException fnfe) {
                    new Alert("Error",
                        "Failed to open index " + strIndexFilename);
                    log.write(Constants.LOG_LOW,
                        "<br>Error opening index file: " + fnfe);
                }

                ObjectInputStream oisIndex = null;
                try {
                    oisIndex = new ObjectInputStream(fisIndex);
                } catch (StreamCorruptedException sce) {
                    new Alert("Error",
                        "Failed to open index " + strIndexFilename);
                    log.write(Constants.LOG_LOW,
                        "<br>Error opening index stream: " + sce);
                } catch (IOException ioe) {
                    new Alert("Error",
                        "Failed to open index " + strIndexFilename);
                    log.write(Constants.LOG_LOW,
                        "<br>Error opening index stream: " + ioe);
                }
                try {
                    saWords = (String[])oisIndex.readObject();
                    vOccurs = (Vector)oisIndex.readObject();
                    saVolPages = (String[])oisIndex.readObject();
                    laOffsets = (long[])oisIndex.readObject();
                    laLengths = (long[])oisIndex.readObject();
                } catch (IOException ioe) {
                    new Alert("Error",
                        "Failed to read index " + strIndexFilename);
                    log.write(Constants.LOG_LOW,
                        "<br>Error reading index: " + ioe);
                } catch (ClassNotFoundException cnfe) {
                    new Alert("Error",
                        "Failed to read index " +  strIndexFilename);
                    log.write(Constants.LOG_LOW,
                        "<br>Error reading index: " + cnfe);
                }

                htWords.clear();
                for (int x = 0; x < saWords.length; x++) {
                    htWords.put(saWords[x], new Integer(x));
                }
                htOffsets.clear();
                for (int x = 0; x < saVolPages.length; x++) {
                    htOffsets.put(saVolPages[x], new Long(laOffsets[x]));
                }
                htLengths.clear();
                for (int x = 0; x < laLengths.length; x++) {
                    htLengths.put(saVolPages[x], new Long(laLengths[x]));
                }

                saAuthWords[intAuth] = saWords;
                htAuthWords[intAuth] = htWords;
                htAuthOffsets[intAuth] = htOffsets;
                htAuthLengths[intAuth] = htLengths;
                vAuthOccurs[intAuth] = vOccurs;
                bIndexLoaded[intAuth] = true;

                log.write(Constants.LOG_HIGH,
                    "<br>Loaded " + Constants.getAuthDisplay(intAuth) +
                    " index (" + saWords.length + " words)");
                intResult = Constants.INDEX_LOADED;
            } else {
                log.write(Constants.LOG_LOW,
                    "<br>Index " + fIndex.getAbsoluteFile() + " not found");
                intResult = Constants.INDEX_NOT_LOADED;
            }
        } else {
            saWords = saAuthWords[intAuth];
            htWords = htAuthWords[intAuth];
            htOffsets = htAuthOffsets[intAuth];
            htLengths = htAuthLengths[intAuth];
            vOccurs = vAuthOccurs[intAuth];

            intResult = Constants.INDEX_RELOADED;
        }
        return intResult;
    }//loadIndex

    public int getIndexPos(String strWord) {
        Integer integerIndex = (Integer)htWords.get(strWord);
        if (integerIndex != null) {
            return integerIndex.intValue();
        } else {
            return Constants.NOT_FOUND;
        }
    }

    public long getPageOffset(String strRef) {
        Long longOffset = (Long)htOffsets.get(strRef);
        if (longOffset != null) {
            return longOffset.longValue();
        } else {
            return Constants.NOT_FOUND;
        }
    }

    public int getPageLength(String strRef) {
        Long longLength = (Long)htLengths.get(strRef);
        if (longLength != null) {
            return longLength.intValue();
        } else {
            return Constants.NOT_FOUND;
        }
    }

    public byte[] getRefs(int intIndex) {
        return (byte[])vOccurs.elementAt(intIndex);
    }

    public String getBookName(int intAuth, int intVol) {
        String strAuthDisplay = Constants.getAuthDisplay(intAuth);
        String strBookName =
            (String)htBookNames.get(Constants.getAuth(intAuth) + intVol);
        if ((strBookName == null) || (strBookName.equals(""))) {
            strBookName = strAuthDisplay + " Volume " + intVol;
        }
        return strBookName;
    }

    public int getBookPages(int intAuth, int intVol) {
        String strAuthDisplay = Constants.getAuthDisplay(intAuth);
        String strBookPages =
            (String)htBookPages.get(Constants.getAuth(intAuth) + intVol);
        int intBookPages = -1;
        if (strBookPages != null) {
            intBookPages = Integer.parseInt(strBookPages);
        }
        return intBookPages;
    }

    public static Index getIndex() {
        if (index == null) {
            index = new Index();
        }
        return index;
    }
}//Index