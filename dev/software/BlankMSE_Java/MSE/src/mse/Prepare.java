//package com.asidua.mse;

import java.awt.AWTEvent;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.Toolkit;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Properties;
import java.util.Vector;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class Prepare extends JFrame implements ActionListener {
    Hashtable htWords;
    Hashtable htOffsets;
    Hashtable htLengths;
    Vector vWords;
    Vector vCounts;
    Vector vOccurs;
    Vector vVolPages;
    Vector vOffsets;
    Vector vLengths;

    String[] saWords;
    String[] saVolPages;
    long[] laOffsets;
    long[] laLengths;

    public static String NEW_LINE = ((Properties) System.getProperties()).getProperty("line.separator");

/*
    String[] saBooks = {"Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy",
                            "Joshua", "Judges", "Ruth", "1Samuel", "2Samuel", "1Kings",
                            "2Kings", "1Chronicles", "2Chronicles", "Ezra", "Nehemiah",
                            "Esther", "Job", "Psalm", "Proverbs", "Ecclesiastes",
                            "SongofSongs", "Isaiah", "Jeremiah", "Lamentations",
                            "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah",
                            "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai",
                            "Zechariah", "Malachi", "Matthew", "Mark", "Luke", "John", "Acts",
                            "Romans", "1Corinthians", "2Corinthians", "Galatians", "Ephesians",
                            "Philippians", "Colossians", "1Thessalonians", "2Thessalonians",
                            "1Timothy", "2Timothy", "Titus", "Philemon", "Hebrews", "James",
                            "1Peter", "2Peter", "1John", "2John", "3John", "Jude", "Revelation", "End"
                            };
*/
    int[] iaChapters = {50, 40, 27, 36, 34, 24, 21, 4, 31, 24, 22,
                            25, 29, 36, 10, 13, 10, 42, 150, 31, 12,
                            8, 66, 52, 5, 48, 12, 14, 3, 9, 1,
                            4, 7, 3, 3, 3, 2, 14, 4, 28, 16, 24, 21, 28,
                            16, 16, 13, 6, 6, 4, 4, 5, 3,
                            6, 4, 3, 1, 13, 5, 5, 3, 5, 1, 1, 1, 22, 0
                            };

    JMenuBar mbPrepare = new JMenuBar();
    JMenu mTools = new JMenu("Tools");
    JMenuItem miBible = new JMenuItem("Generate HTML for Bible");
    JMenuItem miHymns = new JMenuItem("Generate HTML for Hymns");
    JMenuItem miRefreshAll = new JMenuItem("Refresh All");

    BorderLayout blFrame = new BorderLayout();
    JPanel panelButtons = new JPanel();
    JButton buttonTidy = new JButton("Tidy");
    JButton buttonPrepare = new JButton("Prepare");
    JButton buttonWriteIndex = new JButton("Write Index");
    JButton buttonCreateSuperIndex = new JButton("Create Super Index");
    JButton buttonSearchSuperIndex = new JButton("Search Super Index");
    JButton buttonSearchIndex = new JButton("Search Index");
    JTextArea taFilename = new JTextArea(1,20);
    JTextArea taOutput = new JTextArea(5,20);
    JTextField tfProgress = new JTextField(5);
    JScrollPane spOutput = new JScrollPane(taOutput);;
    JComboBox comboAuth = new JComboBox();

    public int intFromByte(byte byteIn) {
        int byteCurr = (int)byteIn;
        if (byteCurr < 0) {
            byteCurr = 256 + byteCurr;
        }
        return byteCurr;
    }

    public Prepare() {
        //add window listener
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
	            System.exit(0);
            }
        });
        enableEvents(AWTEvent.WINDOW_EVENT_MASK);

        miBible.addActionListener(this);
        miHymns.addActionListener(this);
        miRefreshAll.addActionListener(this);
        buttonTidy.addActionListener(this);
        buttonPrepare.addActionListener(this);
        buttonWriteIndex.addActionListener(this);
        buttonCreateSuperIndex.addActionListener(this);
        buttonSearchSuperIndex.addActionListener(this);
        buttonSearchIndex.addActionListener(this);
        try {
            init();
        } catch (Exception e) {
            taOutput.append(NEW_LINE + e);
        }
    }

    public void actionPerformed (ActionEvent e) {
        taOutput.setText(" Version " + Constants.MSE_VERSION + NEW_LINE);
        Object buttonSource = e.getSource();

        if (buttonSource == buttonPrepare) {
            Thread doWorkRunnable = new Thread() {
                public void run() {
                    if (comboAuth.getSelectedItem().toString().equalsIgnoreCase("bible")) {
                        createBibleHTML();
                    } else {
                        prepare(comboAuth.getSelectedItem().toString().toLowerCase());
                    }
                    Toolkit.getDefaultToolkit().beep();
                }
            };
            doWorkRunnable.start();
        } else if (buttonSource == buttonWriteIndex) {
            Thread doWorkRunnable = new Thread() {
                public void run() {
                    writeIndex(comboAuth.getSelectedItem().toString().toLowerCase());
                    tfProgress.setText("Done");
                    Toolkit.getDefaultToolkit().beep();
                }
            };
            doWorkRunnable.start();
        } else if (buttonSource == buttonCreateSuperIndex) {
            Thread doWorkRunnable = new Thread() {
                public void run() {
                    createSuperIndex();
                    tfProgress.setText("Done");
                    Toolkit.getDefaultToolkit().beep();
                }
            };
            doWorkRunnable.start();
        } else if (buttonSource == buttonSearchIndex) {
            Index index = Index.getIndex();
            index.loadIndex(comboAuth.getSelectedIndex());
            String strAuth = comboAuth.getSelectedItem().toString().toLowerCase();

            if (index.saWords == null) {
                taOutput.append(NEW_LINE + "Index not loaded");
            } else {
                try {
                    String strWord = taFilename.getText().toLowerCase();
                    taOutput.append(NEW_LINE + "Looking for: " + strWord);
                    if (index.htWords.get(strWord) != null) {//word in index
                        int intIndex = ((Integer)index.htWords.get(strWord)).intValue();
                        byte[] baRefs = (byte[])index.vOccurs.elementAt(intIndex);
                        if (baRefs != null) {
                            int intCurrPage = 0;
                            for (int x = 0; x < baRefs.length; x++) {
                                int byteCurr = intFromByte(baRefs[x]);
                                if (byteCurr == 0) {//new volume
                                    x++;
                                    if (strAuth.equals("bible")) {
                                        taOutput.append(NEW_LINE + Constants.getBookDisplay(baRefs[x] - 1) + " (" + baRefs[x] + ") - ");
                                    } else {
                                        taOutput.append(NEW_LINE + "Volume ");
                                        taOutput.append(baRefs[x] + " - ");
                                    }
                                    intCurrPage = 0;
                                } else if (byteCurr == 255) {//large delta
                                    x++;
                                    int intHigh = intFromByte(baRefs[x]);
                                    x++;
                                    int intLow = intFromByte(baRefs[x]);
                                    intCurrPage = intCurrPage + (intHigh * 254) + intLow;
                                    taOutput.append(intCurrPage + "(" + intHigh + "," + intLow + ") ");
                                } else {//simple delta
                                    intCurrPage = intCurrPage + byteCurr;
                                    taOutput.append(intCurrPage + "(" + byteCurr + ") ");
                                }
                            }
                        }
                    } else {
                        taOutput.append(NEW_LINE + "Couldn't find " + strWord);
                        if (index.htOffsets.get(strWord) != null) {//word in offsets
                            long longOffset = ((Long)index.htOffsets.get(strWord)).longValue();
                            taOutput.append(NEW_LINE + strWord + " is at offset " + longOffset + " and page length=" + ((Long)index.htLengths.get(strWord)).longValue());
                        } else if (strWord.charAt(strWord.length() - 1) == '*') {
                            for (int x = 0; x < index.saWords.length; x++) {
                                if (index.saWords[x].indexOf(strWord.substring(0, strWord.length() - 1)) != -1) {
                                    taOutput.append(NEW_LINE + index.saWords[x]);
                                }
                            }
                        }
                    }
                } catch (Exception de) {
                    taOutput.append(NEW_LINE + "*** Problem in searching index ***");
                    taOutput.append(NEW_LINE + e);
                }
            }
            Toolkit.getDefaultToolkit().beep();
        } else if (buttonSource == buttonSearchSuperIndex) {
            String[] saWords;
            int[][] iaaRefs;

            try {
                
                // MJP 1x 15/3/15
                File fIndex = new File(Constants.BASIC_FILE_PATH + File.separator + "target" + File.separator + "bible" + File.separator + "superset.idx");
                if (fIndex.exists()) {
                    FileInputStream fisIndex = new  FileInputStream(fIndex);
                    ObjectInputStream oisIndex = new ObjectInputStream(fisIndex);
                    saWords = (String[])oisIndex.readObject();
                    iaaRefs = (int[][])oisIndex.readObject();
                    oisIndex.close();

                    String strWord = taFilename.getText().toLowerCase();
                    for (int intRow = 0; intRow < saWords.length; intRow++) {
                        if (strWord.equals(saWords[intRow])) {
                            taOutput.append(NEW_LINE + "Bible: " + iaaRefs[intRow][Constants.BIBLE_POS]);
                            taOutput.append(NEW_LINE + "JND: " + iaaRefs[intRow][Constants.JND_POS]);
                            taOutput.append(NEW_LINE + "JBS: " + iaaRefs[intRow][Constants.JBS_POS]);
                            taOutput.append(NEW_LINE + "CHM: " + iaaRefs[intRow][Constants.CHM_POS]);
                            taOutput.append(NEW_LINE + "FER: " + iaaRefs[intRow][Constants.FER_POS]);
                            taOutput.append(NEW_LINE + "CAC: " + iaaRefs[intRow][Constants.CAC_POS]);
                            taOutput.append(NEW_LINE + "JT: " + iaaRefs[intRow][Constants.JT_POS]);
                            taOutput.append(NEW_LINE + "GRC: " + iaaRefs[intRow][Constants.GRC_POS]);
                            taOutput.append(NEW_LINE + "AJG: " + iaaRefs[intRow][Constants.AJG_POS]);
                            taOutput.append(NEW_LINE + "SMC: " + iaaRefs[intRow][Constants.SMC_POS]);
                            taOutput.append(NEW_LINE + "Misc: " + iaaRefs[intRow][Constants.MISC_POS]);
                            taOutput.append(NEW_LINE + "Hymns: " + iaaRefs[intRow][Constants.HYMNS_POS]);
                            break;
                        }
                    }
                }
            } catch (Exception se) {
                // MJP Edit 15/3/15
                new Alert("Error", "Error reading superset index (" + Constants.BASIC_FILE_PATH + "\\target\\bible\\superset.idx");
                Log.getLog().write(Constants.LOG_LOW, "<br>Error reading superset index: " + se);
            }
            Toolkit.getDefaultToolkit().beep();
        } else if (buttonSource == miRefreshAll) {
            Thread doWorkRunnable = new Thread() {
                public void run() {
                    for (int intAuth = 1; intAuth < Constants.MAX_AUTH_POS; intAuth++) {//not bible or hymnbook
                        taOutput.append(NEW_LINE + "Preparing " + Constants.saAuths[intAuth] + " ...");
                        prepare(Constants.saAuths[intAuth].toLowerCase());
                        writeIndex(Constants.saAuths[intAuth].toLowerCase());
                    }
                    createSuperIndex();
                    Toolkit.getDefaultToolkit().beep();
                }
            };
            doWorkRunnable.start();
        } else if (buttonSource == miBible) {
            Thread doWorkRunnable = new Thread() {
                public void run() {
                    createBibleHTML();
                    Toolkit.getDefaultToolkit().beep();
                }
            };
            doWorkRunnable.start();
        } else if (buttonSource == miHymns) {
            Thread doWorkRunnable = new Thread() {
                public void run() {
                    createHymnsHTML();
                    Toolkit.getDefaultToolkit().beep();
                }
            };
            doWorkRunnable.start();
        } else if ((buttonSource == buttonTidy) && (!taFilename.getText().equals(""))) {
            String strAuth = comboAuth.getSelectedItem().toString().toLowerCase();
            // MJP 2 Edit 20/3/15
            String strUntidyVolsPath = Constants.BASIC_FILE_PATH + File.separator + "src" + File.separator + strAuth + File.separator + "best" + File.separator;
            String strBackupVolsPath = Constants.BASIC_FILE_PATH + File.separator + "src" + File.separator + strAuth + File.separator + "orig" + File.separator;
            String strInfo; //line read from file
            String strLastPage = "";
            StringBuffer sbLine = new StringBuffer();
            int intCharPos = 0;
            boolean bStartedParenthesis = false;
            boolean bStartedQuote = false;
            String strQuoteStartedPage = "";
            boolean bStartedSingleQuote = false;
            String strSingleQuoteStartedPage = "";
            boolean bStartedItalic = false; //won't split over page boundary
            String strParaStart = "";
            String strSignificantParaStart = "";
            int intError = 0;
            int intWarnings = 0;
            boolean bNewPage = false;
            BufferedReader brOrig = null;
            PrintWriter pwNew = null;

            try {
                File fVolTxt = new File(strUntidyVolsPath + strAuth + taFilename.getText() + ".doc");
                File fVolTxtOrig = new File(strUntidyVolsPath + strAuth + taFilename.getText() + ".doc~");
                File fVolTxtBackup = new File(strBackupVolsPath + strAuth + taFilename.getText() + ".doc~");
                taOutput.append(NEW_LINE + "*** Tidying " + fVolTxt.getName() + " ***");
                if (fVolTxtOrig.exists()) {
                    fVolTxtOrig.delete();
                }
                fVolTxt.renameTo(fVolTxtOrig);
                brOrig = new BufferedReader(new FileReader(fVolTxtOrig));
                pwNew = new PrintWriter(new FileWriter(fVolTxt));
                while ((strInfo = brOrig.readLine()) != null) {//still more lines
                    char charPrePreLast = '=';
                    char charPreLast = '=';
                    char charLast = '=';
                    char charCurr = '=';
                    char charNext = '=';
                    char charPostNext = '=';

                    sbLine.replace(0, sbLine.length(), strInfo);

                    if (strInfo.charAt(0) != '�') {
                        if (strInfo.charAt(0) == '{') {
                            tfProgress.setText(strInfo);
                            strLastPage = strInfo;
                            bNewPage = true;
                        } else {
                            if (!bNewPage) {
                                if (bStartedQuote) {
                                    taOutput.append(NEW_LINE + "Quotes " + strQuoteStartedPage +
                                            " - " + strSignificantParaStart);
                                    bStartedQuote = false;
                                    intError++;
                                } else if (bStartedSingleQuote) {
                                    taOutput.append(NEW_LINE + "Single quote " + strSingleQuoteStartedPage +
                                            " - " + strSignificantParaStart);
                                    bStartedSingleQuote = false;
                                    intError++;
                                } else if (bStartedParenthesis) {
                                    taOutput.append(NEW_LINE + "Missing ) " + strLastPage + " - " + strParaStart);
                                    bStartedParenthesis = false;
                                    intError++;
                                } else if (bStartedItalic) {
                                    taOutput.append(NEW_LINE + "Missing asterisk " + strLastPage + " - " + strParaStart);
                                    bStartedItalic = false;
                                    intError++;
                                }
                                //start of significant paragraph
                                if (sbLine.length() > 20) {
                                    strSignificantParaStart = strInfo.substring(0, 20);
                                } else {
                                    strSignificantParaStart = strInfo.substring(0, sbLine.length() - 1);
                                }
                            }
                            bNewPage = false;
                        }
                        if (sbLine.length() > 20) {
                            strParaStart = strInfo.substring(0, 20);
                        } else {
                            strParaStart = strInfo.substring(0, sbLine.length() - 1);
                        }

                        intCharPos = 0;
                        while (intCharPos < sbLine.length()) {
                            charPrePreLast = charPreLast;
                            charPreLast = charLast;
                            charLast = charCurr;
                            charCurr = sbLine.charAt(intCharPos);
                            if (intCharPos + 1 < sbLine.length()) {
                                charNext = sbLine.charAt(intCharPos + 1);
                            } else {
                                charNext = '=';
                            }
                            if (intCharPos + 2 < sbLine.length()) {
                                charPostNext = sbLine.charAt(intCharPos + 2);
                            } else {
                                charPostNext = '=';
                            }

                            if (charCurr == '"') {
                                if (bStartedQuote) {
                                    if (charLast == ' ') {//space at end of quote
                                        sbLine.replace(intCharPos - 1, intCharPos, "");
                                    } else  if (charLast == ',') {
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "\",");
                                    } else  if ((charLast == '.') && (charPreLast != '.') && (charNext != '.') && (charNext != ',') && (charNext != ';')) {
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "\".");
                                    }
                                } else {//could be space at start of quote
                                    if (charNext == ' ') {//space at start of quote
                                        sbLine.replace(intCharPos + 1, intCharPos + 2, "");
                                    }
                                }
                                bStartedQuote = !bStartedQuote;
                                strQuoteStartedPage = strLastPage;
                            } else if (charCurr == '\'') {
                                if (bStartedSingleQuote) {
                                    if (charLast == ' ') {//space at end of single quote
                                        sbLine.replace(intCharPos - 1, intCharPos, "");
                                    } else  if (charLast == ',') {
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "\',");
                                    } else  if ((charLast == '.') && (charPreLast != '.') && (charNext != '.') && (charNext != ',') && (charNext != ';')) {
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "\'.");
                                    }
                                } else {//could be space at start of quote
                                    if (charNext == ' ') {//space at start of quote
                                        sbLine.replace(intCharPos + 1, intCharPos + 2, "");
                                    }
                                }
                                if (!(Character.isLetter(charLast) && Character.isLetter(charNext))) {
                                    bStartedSingleQuote = !bStartedSingleQuote;
                                    strSingleQuoteStartedPage = strLastPage;
                                }
                            } else if (charCurr == '(') {
                                if (bStartedParenthesis) {
                                    taOutput.append(NEW_LINE + "Nested () " + strLastPage + " - " + strParaStart);
                                    intWarnings++;
                                }
                                bStartedParenthesis = true;
                            } else if (charCurr == ')') {
                                if (!bStartedParenthesis) {
                                    taOutput.append(NEW_LINE + "Unmatched ) " + strLastPage + " - " + strParaStart);
                                    intWarnings++;
                                }
                                bStartedParenthesis = false;
                            } else if (charCurr == '&') {
                                if (!(charNext != 'p') && (charPostNext != 'o')) {
                                    taOutput.append(NEW_LINE + "Found & " + strLastPage + " - " + strParaStart);
                                    intWarnings++;
                                }
                            } else if (charCurr == '\\') {
                                taOutput.append(NEW_LINE + "Found \\ " + strLastPage + " - " + strParaStart);
                                intWarnings++;
                            } else if (charCurr == '/') {
                                if (charLast != '<') {
                                    taOutput.append(NEW_LINE + "Found / " + strLastPage + " - " + strParaStart);
                                    intWarnings++;
                                }
                            } else if (charCurr == '*') {
                                if (bStartedItalic) {
                                    if (charLast == ' ') {//space at end of italics
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "* ");
                                    } else  if (charLast == ',') {
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "*,");
                                    } else  if (charLast == '.') {
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "*.");
                                    } else  if (charLast == '?') {
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "*?");
                                    } else  if (charLast == '!') {
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, "*!");
                                    }
                                } else {//could be space at start of quote
                                    if (charNext == ' ') {//space at start of italics
                                        sbLine.replace(intCharPos + 1, intCharPos + 2, "");
                                    }
                                }
                                bStartedItalic = !bStartedItalic;
                            } else if (charCurr == '-') {
                                if ((charLast == '-') && (charPreLast == ' ') && (charNext == ' ')) {// --
                                    if (Character.isDigit(charPrePreLast) && Character.isDigit(charPostNext)) {//1 -- 2
                                        sbLine.replace(intCharPos, intCharPos + 1, "");
                                    }
                                } else if (Character.isDigit(charLast) && Character.isDigit(charNext)) {//1-2
                                    sbLine.replace(intCharPos, intCharPos + 1, " - ");
                                    } else if ((charLast == '-') && Character.isDigit(charPreLast) &&
                                            Character.isDigit(charNext)) {//1--2
                                        sbLine.replace(intCharPos - 1, intCharPos + 1, " - ");
                                    }
                            } else if (charCurr == '.') {
                                if (
                                        (!(charPrePreLast == 'n' && charPreLast == 's' && charLast == 't')) && //inst.
                                        (!(charPrePreLast == 'u' && charPreLast == 'l' && charLast == 't')) && //ult.
                                        (!(charPrePreLast == 'v' && charPreLast == 'i' && charLast == 'z')) && //viz.
                                        (!(charPrePreLast == 'S' && charPreLast == 'n' && charLast == 'r')) && //Snr.
                                        (!(charPrePreLast == 'i' && charPreLast == '.' && charLast == 'e')) && //i.e.
                                        (!(charPrePreLast == 'e' && charPreLast == '.' && charLast == 'g')) && //e.g.
                                        (!(charPrePreLast == 'e' && charPreLast == 't' && charLast == 'c')) && //etc.
                                        (!(charPrePreLast == 'M' && charPreLast == 'r' && charLast == 's')) && //Mrs.
                                        (!(charPrePreLast == 'M' && charPreLast == 'S' && charLast == 'S')) && //MSS.
                                        (!(charPreLast == 'c' && charLast == 'f')) && //cf.
                                        (!(charPreLast == 'M' && charLast == 'r')) && //Mr.
                                        (!(charPreLast == 'J' && charLast == 'r')) && //Jr.
                                        (!(charPreLast == 'S' && charLast == 'r')) && //Sr.
                                        (!(charPreLast == 'D' && charLast == 'r')) && //Dr.
                                        (!(charPreLast == 'C' && charLast == 'o')) && //Co.
                                        (!(charPreLast == 'S' && charLast == 't')) && //St.
                                        (!(charPreLast == 'M' && charLast == 'S')) && //MS.
                                        (!Character.isDigit(charLast) || !Character.isDigit(charNext))
                                        ) {
                                    if (
                                            (charNext == ' ') &&
                                            (charLast != '.') &&
                                            (charPreLast != '.') &&
                                            (charPreLast != ' ') && //e.g. Mr. S.,
                                            (Character.isLowerCase(charPostNext))
                                            ) {
                                        taOutput.append(NEW_LINE + "Dodgy dot " + strLastPage + " - " + strParaStart);
                                        intWarnings++;
                                    } else if (
                                            (charNext != ' ') &&
                                            (charPostNext != '.') &&
                                            (charPostNext != '-') &&
                                            (charPostNext != '\'') && //e.g. H.D'A.C.
                                            (charPreLast != ' ') && //e.g. Mr. S.,
                                            (charNext != '=') &&
                                            (charNext != '.') &&
                                            (charNext != '\"') &&
                                            (charNext != '�') &&
                                            (charNext != '\'') &&
                                            (charNext != ')') &&
                                            (charNext != '<') &&
                                            (!(charNext == ',' && charPreLast == '.')) && //J.B.S.,
                                            (!(charNext == 'J' && charPostNext == 'r')) && //Jr.
                                            (!(charNext == 'S' && charPostNext == 'r')) && //Sr.
                                            (!(charNext == 'M' && charPostNext == 'c')) && //Mc
                                            (!(charNext == 'M' && charPostNext == 'a')) && //Mac
                                            (charNext != '*')
                                            ) {
                                        taOutput.append(NEW_LINE + "Dodgy dot " + strLastPage + " - " + strParaStart);
                                        intWarnings++;
                                    }
                                }
                            }
                            intCharPos++;
                        }
                    }
                    pwNew.println(sbLine.toString());
                }
                brOrig.close();
                pwNew.close();
                if (intError > 0) {
                    fVolTxt.delete();
                    fVolTxtOrig.renameTo(fVolTxt);
                    taOutput.append(NEW_LINE + "*** Found " + intError + " error(s) and " + intWarnings + " warning(s) ***");
                    tfProgress.setText("Error");
                } else {
                    if (fVolTxtBackup.exists()) {
                        fVolTxtOrig.delete();
                    } else {
                        fVolTxtOrig.renameTo(fVolTxtBackup);
                    }
                    tfProgress.setText("Done");
                }
                Toolkit.getDefaultToolkit().beep();
            } catch (Exception fe) {
                taOutput.append(NEW_LINE + "*** Problem in tidying file ***");
                taOutput.append(NEW_LINE + e);
                try {
                    brOrig.close();
                    pwNew.close();
                } catch (Exception ioe) {
                    taOutput.append(NEW_LINE + "*** Can't close files ***");
                    taOutput.append(NEW_LINE + ioe);
                }
            }
        }
    }//actionPerformed

    private void createBibleHTML() {
        try {
            
            // MJP 4x 15/3/15
            String strJNDPath = Constants.BASIC_FILE_PATH + "src" + File.separator + "bible" + File.separator + "best" + File.separator;
            String strKJVPath = Constants.BASIC_FILE_PATH + "src" + File.separator + "kjv" + File.separator + "best" + File.separator;
            String strBibleDestPath = Constants.BASIC_FILE_PATH + "target" + File.separator + "bible" + File.separator;
            String strBibleTxtDestPath = Constants.BASIC_FILE_PATH + "src" + File.separator + "bible" + File.separator + "txt" + File.separator;

            String strJNDLine; //line read from JND file
            String strKJVLine; //line read from KJV file
            String strSynopsisLine; //line read from Synopsis pages file
            int intSynopsisDelimiter1;
            int intSynopsisDelimiter2;
            int intSynopsisDelimiter3;
            String strBibleBook;
            String strBibleChapter;
            String strSynopsisBook;
            String strSynopsisPage;
            String strSynopsisLink = "";
            String strBookName = null;
            String strChapter = "1";
            String strVerseNum = null;
            String strJNDVerse = null;
            String strKJVVerse = null;
            String strBuffer = null;
            String strBufferTxt = null;
            boolean bStartedItalic = false;

            Hashtable htSynopsisPages = new Hashtable();
            boolean bPagesFinished = false;
            BufferedReader brPages = new BufferedReader(new FileReader(strJNDPath + "pages.txt"));
            while (bPagesFinished == false) {//still more lines in pages.txt
               strSynopsisLine = brPages.readLine();
               if (strSynopsisLine == null) {
                  bPagesFinished = true;
               } else {
                  intSynopsisDelimiter1 = strSynopsisLine.indexOf(",");
                  intSynopsisDelimiter2 = intSynopsisDelimiter1 + 1 + strSynopsisLine.substring(intSynopsisDelimiter1 + 1).indexOf(",");
                  intSynopsisDelimiter3 = intSynopsisDelimiter2 + 1 + strSynopsisLine.substring(intSynopsisDelimiter2 + 1).indexOf(",");
                  strBibleBook = strSynopsisLine.substring(0, intSynopsisDelimiter1);
                  strBibleChapter = strSynopsisLine.substring(intSynopsisDelimiter1 + 1,intSynopsisDelimiter2);
                  strSynopsisBook = strSynopsisLine.substring(intSynopsisDelimiter2 + 1,intSynopsisDelimiter3);
                  strSynopsisPage = strSynopsisLine.substring(intSynopsisDelimiter3 + 1);
                  strSynopsisLink = " - <a href=\"../jnd/jnd" + strSynopsisBook + ".htm#" + strSynopsisPage + "\">go to synopsis</a>";
                  htSynopsisPages.put(strBibleBook + "/" + strBibleChapter, strSynopsisLink);
               }
            }
            brPages.close();

            for (int x = 1; x <= 66; x++) {
                String strJNDFilename = strJNDPath + "bible" + Integer.toString(x) + ".txt";
                String strKJVFilename = strKJVPath + "kjv" + Integer.toString(x) + ".txt";
                BufferedReader brJND = new BufferedReader(new FileReader(strJNDFilename));
                BufferedReader brKJV = new BufferedReader(new FileReader(strKJVFilename));
                PrintWriter pwBible = new PrintWriter(new FileWriter(strBibleDestPath + Constants.getBook(x - 1) + ".htm", false));
                PrintWriter pwBibleTxt = new PrintWriter(new FileWriter(strBibleTxtDestPath + "bible" + x + ".doc", false));
                pwBible.println("<html><head><title>Darby translation and King James Version of The Bible</title></head><body bgcolor=\"#FFFFFF\" link=\"#0000FF\" vlink=\"#0000FF\" alink=\"#0000FF\"><b>Chapters</b> ");
                pwBibleTxt.println("{#" + Constants.getBookDisplay(x - 1) + "}");

                for (int intChapter = 1; intChapter <= iaChapters[x - 1]; intChapter++) {
                    pwBible.println("<a href=\"#" + Integer.toString(intChapter) + "\">" + Integer.toString(intChapter) + "</a> ");
                }
                pwBible.println("<br><br><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\">");

                boolean bFinished = false;
                strJNDLine = brJND.readLine();
                strKJVLine = brKJV.readLine();

                while (bFinished == false) {//still more lines
                    if (strJNDLine.indexOf("{") == 0) {//chapter heading
                        strChapter = strJNDLine.substring(1, strJNDLine.length() - 1);
                        if (Constants.bSynopsisLinks == true) {
                           strSynopsisLink = (String)htSynopsisPages.get(x + "/" + strChapter);
                           if (strSynopsisLink == null) {
                              taOutput.append(NEW_LINE + "No synopsis page for " + Constants.getBookDisplay(x - 1) + " " + strChapter);
                              strSynopsisLink = "";
                           } else {
//                              taOutput.append(NEW_LINE + "Synopsis page for " + x + "/" + strChapter + " = " + strSynopsisLink);
                           }
                        } else {
                            strSynopsisLink = "";
                        }
                        strBuffer = "<tr bgcolor=\"#D0D0D0\"><td colspan=\"3\" align=\"center\"><br><h2><a name=" + strChapter + ">" + Constants.getBookDisplay(x - 1) + " " + strChapter + "</a></h2></td></tr><tr><td>&nbsp;</td><td><b>Darby Translation (1889)</b>" + strSynopsisLink + "</td><td><b>Authorised (King James) Version (1769)</b></td></tr>";
                        strBufferTxt = "{" + strChapter + "}";
                    } else {//verse
                        strVerseNum = strJNDLine.substring(0, strJNDLine.indexOf(" "));
                        strJNDVerse = strJNDLine.substring(strJNDLine.indexOf(" ")).trim();
                        strKJVVerse = strKJVLine.substring(strKJVLine.indexOf(" ")).trim();
                        strBuffer = "<tr><td valign=\"top\"><a name=" + strChapter + ":" + strVerseNum + "><font size=-1 color=#0000AA>" + strVerseNum + "</font></a></td><td valign=\"top\">" + strJNDVerse + "</td><td valign=\"top\">" + strKJVVerse + "</td></tr>";
                        strBufferTxt = strVerseNum + "  " + strJNDVerse + " " + strKJVVerse;

                        if (strJNDVerse.length() < 5) {
                            taOutput.append(NEW_LINE + "SHORT VERSE - " + strBuffer);
                        }

                        while (strBuffer.indexOf("*") != -1) {//contains *
                            if (bStartedItalic) {
                                strBuffer = strBuffer.substring(0, strBuffer.indexOf("*")) + "</i>" + strBuffer.substring(strBuffer.indexOf("*") + 1);
                            } else {
                                strBuffer = strBuffer.substring(0, strBuffer.indexOf("*")) + "<i>" + strBuffer.substring(strBuffer.indexOf("*") + 1);
                            }
                            bStartedItalic = !bStartedItalic;
                        }
                    }

                    pwBibleTxt.println(strBufferTxt);
                    pwBible.println(strBuffer);
                    if (bStartedItalic) {
                        taOutput.append(NEW_LINE + "ITALICS - " + strBufferTxt);
                    }
                    strJNDLine = brJND.readLine();
                    strKJVLine = brKJV.readLine();
                    if ((strJNDLine == null) && (strKJVLine == null)) {
                        bFinished = true;
                    }
                }
                pwBible.println("</table></body></html>");
                pwBibleTxt.close();
                pwBible.close();
                brJND.close();
                brKJV.close();
                taOutput.append(NEW_LINE + "*** Finished " + Constants.getBookDisplay(x - 1) + " ***");
            }

        } catch (Exception fe) {
            taOutput.append(NEW_LINE + "*** Problem in formatting bible ***");
            taOutput.append(NEW_LINE + fe);
        }
    }//createBibleHTML

    private void createHymnsHTML() {
        try {
            
            // MJP 2 Edits 15/3/15
            String strHymnsPath = Constants.BASIC_FILE_PATH + "src" + File.separator + "hymns" + File.separator + "best" + File.separator;
            String strHymnsDestPath = Constants.BASIC_FILE_PATH + "target" + File.separator + "hymns" + File.separator;

            String strHymnLine = null; //line read from hymn file
            String strHymnNo = null;
            String strHymnVerse = null;
            String strBuffer = null;
            String strBufferTxt = null;

            for (int x = 1; x <= 5; x++) {
                tfProgress.setText(Integer.toString(x));
                String strHymnFilename = strHymnsPath + "hymns" + Integer.toString(x) + ".doc";
                BufferedReader brHymns = new BufferedReader(new FileReader(strHymnFilename));
                PrintWriter pwHymns = new PrintWriter(new FileWriter(strHymnsDestPath + "hymns" + x + ".htm", false));

                boolean bFinished = false;
                strHymnLine = brHymns.readLine();
                pwHymns.println("<html>");
                if (strHymnLine.indexOf("{") == 0) {
                    if (strHymnLine.indexOf("#") == 1) {//title
                        strBuffer = "<head><title>" + strHymnLine.substring(2, strHymnLine.length() - 1) + "</title></head>";
                        strHymnLine = brHymns.readLine();
                    }
                }
                pwHymns.println("<body><br><center>");

                while (bFinished == false) {//still more lines
                    if (strHymnLine.indexOf("{") == 0) {//new hymn
                        strHymnNo = strHymnLine.substring(1, strHymnLine.length() - 1);
                        if (!strHymnNo.equals("1")) {
                            strBuffer = "</td></tr></table><hr>";
                        } else {
                            strBuffer = "";
                        }
                        strBuffer = strBuffer + "<a name=" + strHymnNo + ":0></a><p><table cellpadding=\"10\"><tr><td><font size=+3><a name=" + strHymnNo + "></a>" + strHymnNo + "</font></td>";
                        strHymnLine = brHymns.readLine();
                        int intCommaPos = strHymnLine.indexOf(",");
                        String strAuthorEtc = strHymnLine.substring(0, intCommaPos).trim();
                        String strMetre = strHymnLine.substring(intCommaPos + 1).trim();
                        strBuffer = strBuffer + "<td>" + strAuthorEtc + "</td><td><a href=\"..\\tunes\\tunes.htm#" + strMetre + "\">" + strMetre + "</a>";
                    } else if (strHymnLine.indexOf("|") == 0) {//new verse
                        strHymnVerse = strHymnLine.substring(1, strHymnLine.length() - 1);
                        strBuffer = "</td></tr><tr><td valign=\"top\"><font size=-1 color=#0000AA><a name=" + strHymnNo + ":" + strHymnVerse + "></a>" + strHymnVerse + "</font><br></td><td>";
                        taOutput.append(NEW_LINE + "Verse " + strHymnNo + ":" + strHymnVerse);
                    } else {//verse line
                        strBuffer = strHymnLine + "<br>";
                    }

                    pwHymns.println(strBuffer);

                    strHymnLine = brHymns.readLine();
                    if (strHymnLine == null) {
                        bFinished = true;
                    }
                }
                pwHymns.println("</center></body></html>");
                pwHymns.close();
                brHymns.close();
                taOutput.append(NEW_LINE + "*** Finished hymns" + x + " ***");
            }

        } catch (Exception fe) {
            taOutput.append(NEW_LINE + "*** Problem in formatting hymns ***");
            taOutput.append(NEW_LINE + fe);
        }

//        tfProgress.setText("Done");
}//createHymnsHTML

    private void prepare(String strAuth) {
        PrintWriter pwLog = null;
        BufferedReader brLog = null;
        StringBuffer sbLine = new StringBuffer();
        StringBuffer sbPageNum = new StringBuffer();
        int intVol = 0;
        int intSection = 1;
        
        // MJP 2x 15/3/15
        String strVolsPath = Constants.BASIC_FILE_PATH + "src" + File.separator + strAuth + File.separator + "best" + File.separator;
        String strVolsDestPath = Constants.BASIC_FILE_PATH + "target" + File.separator + strAuth + File.separator;

        try {
            String strInfo; //line read from file
            int intFootnotes = 0;
            int intActualFootnotes = 0;
            int intMaxFootnotes = 0;
            String strFootnotes = "";
            String strActualFootnotes = "";
            int intLineCount = 0;
            int intCharPos = 0;
            int intTempCharPos = 0;
            int intEndRef = 0;
            int intBookNamePos = 0;
            StringBuffer sbBookName = new StringBuffer();
            StringBuffer sbChapter = new StringBuffer();
            StringBuffer sbHymn = new StringBuffer();
            StringBuffer sbVerse = new StringBuffer();
            boolean bStartedItalic = false;
            String strBookName;
            String strCompressedBookName = "";
            String strReference;
            String strUCLine;
            boolean finished;
            boolean bFinishedVols = false;
            int intPageNum;
            int intKeepPageNum;
            
            intVol = 1;
            if (strAuth.equals("hymns")) {
                intVol = Constants.LAST_HYMNBOOK + 1;
            }
            while (!bFinishedVols) {
                
                File fVolTxt = new File(strVolsPath + strAuth + intVol + ".doc");
                if (!fVolTxt.exists()) {
                    bFinishedVols = true;
                } else if (taFilename.getText().equals("") || taFilename.getText().equals("" + intVol)) {
                    intPageNum = 0;
                    intKeepPageNum = 0;
                    taOutput.append(NEW_LINE + "*** Preparing " + strAuth + intVol + ".htm ***");
                    tfProgress.setText(strAuth + intVol);
                    brLog = new BufferedReader(new FileReader(strVolsPath + strAuth + intVol + ".doc"));
                    pwLog = new PrintWriter(new FileWriter(strVolsDestPath + strAuth + intVol + ".htm", false));
                    pwLog.println("<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"><style>a:hover{background-color:yellow;}</style>");
                    pwLog.println("<title>" + strAuth.toUpperCase() + " Volume " + intVol + "</title></head><body bgcolor=\"#FFFFFF\" link=\"#0000FF\" vlink=\"#0000FF\" alink=\"#0000FF\">");
                    while ((strInfo = brLog.readLine()) != null) {//still more lines
                        sbLine.replace(0, sbLine.length(), strInfo);
                        
                        if ((sbLine.length() < 400) && (sbLine.charAt(0) != '{')) {//probable heading
                            strUCLine = sbLine.toString().toUpperCase();
                            if (strUCLine.equals(sbLine.toString()) && (sbLine.charAt(0) != ' ')) {
                                taOutput.append(NEW_LINE + "<a href=\"" + strAuth + intVol + ".htm#" + sbPageNum + "\"><font size=4>" + sbLine.toString() + "</font></a><br>~");
                                sbLine.insert(0, "<h2>");
                                sbLine.append("</h2>");
                            } else {
    //                            taOutput.append(NEW_LINE + "SHORT PARA - " + sbLine.toString());
                            }
                        }

                        int intCharsInSection = 0;
                        intCharPos = 0;
                        if ((sbLine.charAt(0) != '�') && (sbLine.charAt(0) != '{') && (intActualFootnotes != 0)) {
                            taOutput.append(NEW_LINE + "FOOTNOTE not at foot of page - " + sbPageNum);
                        }

                        while (intCharPos < sbLine.length()) {
                            char charCurr = sbLine.charAt(intCharPos);
                            if (charCurr == '*') {//italics
                                if (bStartedItalic) {
                                    sbLine.replace(intCharPos, intCharPos + 1, "</i>");
                                } else {
                                    sbLine.replace(intCharPos, intCharPos + 1, "<i>");
                                }
                                bStartedItalic = !bStartedItalic;
                            } else if (charCurr == '{') {//start page number
                                intTempCharPos = intCharPos + 1;
//                                    sbPageNum.replace(0, sbLine.length(), "");
                                StringBuffer sbPageNumTmp = new StringBuffer();
                                while (sbLine.charAt(intTempCharPos) != '}') {
                                    sbPageNumTmp.append(sbLine.charAt(intTempCharPos));
                                    intTempCharPos++;
                                }
                                if (sbPageNumTmp.charAt(0) != '#') {
                                    sbPageNum = sbPageNumTmp;
                                    intPageNum = Integer.parseInt(sbPageNum.toString());
                                    if (intPageNum != intKeepPageNum + 1) {
                                        taOutput.append(NEW_LINE + "Missing page: " + (intKeepPageNum + 1));
                                    }
                                    intKeepPageNum = intPageNum;
                                    sbLine.replace(intCharPos, intCharPos + 1, "<a name=" + sbPageNum + "><center>[Page ");
                                    intCharPos = intCharPos + 23;

                                    if (intMaxFootnotes != 0) {
                                        intMaxFootnotes = 0;
                                        pwLog.println("</font>");
                                    }
                                    if (intFootnotes != intActualFootnotes) {
                                        taOutput.append(NEW_LINE + "Mismatch of actual footnotes: " + sbPageNum +
                                            ", expected = " + intFootnotes + ", found = " + intActualFootnotes);
                                    }
                                    strFootnotes = "";
                                    strActualFootnotes = "";
                                    intFootnotes = 0;
                                    intActualFootnotes = 0;
                                } else {
                                    sbLine.replace(intCharPos, intTempCharPos + 1, "");
                                }
                                taOutput.append(" " + sbPageNum.toString());
                            } else if (charCurr == '}') {//end page number
                                sbLine.replace(intCharPos, intCharPos + 1, "]</center>");
                                intSection = 1;
                            } else if (charCurr == '~') {//footnote
                                sbLine.replace(intCharPos, intCharPos + 1, "<i>see <a href=\"" + strAuth + "_footnotes.htm#" + intVol + ":" + sbPageNum.toString() + "\">footnote</a></i>");
                                intCharPos = intCharPos + 40;
                            } else if (charCurr == '�') {//possessive apostrophe
                                sbLine.replace(intCharPos, intCharPos + 1, "'");
                            } else if ((charCurr == '.') || (charCurr == '?') || (charCurr == '!')) {//new sentence
                                if (intCharsInSection > 1) {
                                    sbLine.insert(intCharPos + 1, "<a name=" + sbPageNum.toString() + ":" + intSection + "></a>");
                                    intSection++;
                                }
                                intCharsInSection = 0;
                            } else if (charCurr == '�') {
                                sbLine.replace(intCharPos, intCharPos + 1, ".");
                            } else if (charCurr == '�') {//footnote
                                if (intCharPos == 0) {
                                    if (intActualFootnotes == 0) {
//                                        strFootnotes = "";
                                        pwLog.println("<font size=\"-1\" color=\"#00A000\">");
                                    }
                                    intActualFootnotes++;
                                    strActualFootnotes = strActualFootnotes + "+";
                                    sbLine.replace(intCharPos, intCharPos + 1, "<a id=\"footnote\" name=\"#" + sbPageNum.toString() + ":f" + intActualFootnotes + "\"><sup>" + strActualFootnotes + "</sup></a>");
                                } else {
                                    intFootnotes++;
                                    if (intFootnotes > intMaxFootnotes) {
                                        intMaxFootnotes = intFootnotes;
                                    }
                                    strFootnotes = strFootnotes + "+";
                                    sbLine.replace(intCharPos, intCharPos + 1, "<a href=\"#" + sbPageNum.toString() + ":f" + intFootnotes + "\"><font size=\"-1\" color=\"#00A000\"><sup>" + strFootnotes + "</sup></font></a>");
                               }
                            } else if (charCurr == '@') {//start of scripture reference

                                //find book name
                                sbBookName.replace(0, sbBookName.length(), "");
                                intTempCharPos = intCharPos + 1;
                                while (((intTempCharPos - intCharPos) < 4) || (!Character.isDigit(sbLine.charAt(intTempCharPos)))) {
                                    sbBookName.append(sbLine.charAt(intTempCharPos));
                                    intTempCharPos++;
                                }

                                //strip white space
                                intBookNamePos = sbBookName.length() - 1;
                                while (sbBookName.charAt(intBookNamePos) == ' ') {
                                    sbBookName.deleteCharAt(intBookNamePos);
                                    intBookNamePos--;
                                }

                                //find chapter
                                sbChapter.replace(0, sbChapter.length(), "");
                                finished = false;
                                while (!finished) {
                                    if (intTempCharPos >= sbLine.length()) {
                                        finished = true;
                                    } else if (Character.isDigit(sbLine.charAt(intTempCharPos))) {
                                        sbChapter.append(sbLine.charAt(intTempCharPos));
                                        intTempCharPos++;
                                    } else {
                                        finished = true;
                                    }
                                }
                                intEndRef = intTempCharPos;

                                //skip white space
                                finished = false;
                                while (!finished) {
                                    if (intTempCharPos >= sbLine.length()) {
                                        finished = true;
                                    } else if (sbLine.charAt(intTempCharPos) == ' ') {
                                        intTempCharPos++;
                                    } else {
                                        finished = true;
                                    }
                                }

                                sbVerse.replace(0, sbVerse.length(), "");
                                if (intTempCharPos < sbLine.length()) {
                                    if (sbLine.charAt(intTempCharPos) == ':') {//find verse
                                        intTempCharPos++;
                                        //skip white space
                                        finished = false;
                                        while (!finished) {
                                            if (intTempCharPos >= sbLine.length()) {
                                                finished = true;
                                            } else if (sbLine.charAt(intTempCharPos) == ' ') {
                                                intTempCharPos++;
                                            } else {
                                                finished = true;
                                            }
                                        }

                                        finished = false;
                                        while (!finished) {
                                            if (intTempCharPos >= sbLine.length()) {
                                                finished = true;
                                            } else if (Character.isDigit(sbLine.charAt(intTempCharPos))) {
                                                sbVerse.append(sbLine.charAt(intTempCharPos));
                                                intTempCharPos++;
                                            } else {
                                                finished = true;
                                            }
                                        }
                                        intEndRef = intTempCharPos;
                                    }
                                }

                                strBookName = sbBookName.toString();

                                //strip white space from book name
                                intBookNamePos = sbBookName.length() - 1;
                                while (intBookNamePos >= 0) {
                                    if (sbBookName.charAt(intBookNamePos) == ' ') {
                                        sbBookName.deleteCharAt(intBookNamePos);
                                    }
                                    intBookNamePos--;
                                }
                                strCompressedBookName = sbBookName.toString();

                                if (sbVerse.length() > 0) {
                                    strReference = "<a href=\"../bible/" + strCompressedBookName + ".htm#" + sbChapter.toString() + ":" + sbVerse.toString() + "\">" + strBookName + " " + sbChapter.toString() + ":" + sbVerse.toString() + "</a>";
                                } else {
                                    strReference = "<a href=\"../bible/" + strCompressedBookName + ".htm#" + sbChapter.toString() + "\">" + strBookName + " " + sbChapter.toString() + "</a>";
                                }
                                sbLine.replace(intCharPos, intEndRef, strReference);
                                intCharPos = intCharPos + strReference.length() - (intEndRef - intCharPos);
                            } else if (charCurr == '`') {//start of hymn reference
                                //find hymn number
                                intTempCharPos = intCharPos + 1;
                                sbHymn.replace(0, sbHymn.length(), "");
                                finished = false;
                                while (!finished) {
                                    if (intTempCharPos >= sbLine.length()) {
                                        finished = true;
                                    } else if (Character.isDigit(sbLine.charAt(intTempCharPos))) {
                                        sbHymn.append(sbLine.charAt(intTempCharPos));
                                        intTempCharPos++;
                                    } else {
                                        finished = true;
                                    }
                                }
    //taOutput.append(NEW_LINE + "sbHymn:" + sbHymn.toString());
                                sbVerse.replace(0, sbVerse.length(), "");
                                if (intTempCharPos < sbLine.length()) {
                                    if (sbLine.charAt(intTempCharPos) == ':') {//find verse
                                        intTempCharPos++;
                                        finished = false;
                                        while (!finished) {
                                            if (intTempCharPos >= sbLine.length()) {
                                                finished = true;
                                            } else if (Character.isDigit(sbLine.charAt(intTempCharPos))) {
                                                sbVerse.append(sbLine.charAt(intTempCharPos));
                                                intTempCharPos++;
                                            } else {
                                                finished = true;
                                            }
                                        }
                                    }
                                }
    //taOutput.append(NEW_LINE + "sbVerse:" + sbVerse.toString());
                                if (Constants.bHymnPointers == true) {
                                    strReference = "<a href=\"..\\hymns\\hymns1.htm#" + sbHymn.toString() + ":" + sbVerse.toString() + "\">Hymn " + sbHymn.toString() + "</a>";
                                } else {
                                    strReference = "Hymn " + sbHymn.toString();
                                }
                                sbLine.replace(intCharPos, intTempCharPos, strReference);
                                intCharPos = intCharPos + strReference.length() - (intTempCharPos - intCharPos);
                            }
                            intCharPos++;
                            intCharsInSection++;
                        }
                        if (sbLine.length() > 0) {
                            sbLine.append("<p>");
                        }

                        pwLog.println(sbLine.toString());
                        if (bStartedItalic) {
                            taOutput.append(NEW_LINE + "ITALICS - " + sbLine.toString());
                        }

                        intLineCount = intLineCount + 1;
                    }


                    pwLog.println("</body></html>");
                    taOutput.append(NEW_LINE + "*** Finished " + strAuth + intVol + ".htm ***");
                    pwLog.close();
                    brLog.close();
                }
                intVol = intVol + 1;
            }
            tfProgress.setText("Done");
        } catch (Exception e) {
            taOutput.append(NEW_LINE + "*** Problem in volume " + taFilename.getText() + " ***");
            taOutput.append(NEW_LINE + "PageNum: " + sbPageNum.toString());
            taOutput.append(" Section: " + intSection);
            taOutput.append(" Line: '" + sbLine.toString() + "'");
            taOutput.append(NEW_LINE + e);
        }

        try {
            pwLog.close();
            brLog.close();
        } catch (Exception e) {
            taOutput.append(NEW_LINE + "*** Problem in volume " + taFilename.getText() + " ***");
            taOutput.append(NEW_LINE + "Can't close files");
        }
    }//prepare

    private void writeIndex(String strAuth) {
        htWords = new Hashtable();
        vWords = new Vector();
        vCounts = new Vector();
        vOccurs = new Vector();
        vVolPages = new Vector();
        vOffsets = new Vector();
        vLengths = new Vector();

        StringBuffer sbLine = new StringBuffer();
        StringBuffer sbPageNum = new StringBuffer();
        int intVol = 0;
        int intSection = 1;
        String strVolsPath;
        if (!strAuth.equals("bible")) {
            
            // MJP 15/3/15
            strVolsPath = Constants.BASIC_FILE_PATH + "src\\" + strAuth + "\\best\\";
        } else {
            
            // MJP 15/3/15
            strVolsPath = Constants.BASIC_FILE_PATH + "src\\" + strAuth + "\\txt\\";
        }
        
        // MJP 2x 15/3/15
        String strVolsDestPath = Constants.BASIC_FILE_PATH + "target\\" + strAuth + "\\";
        String strIndexPath = Constants.BASIC_FILE_PATH + "target\\" + strAuth + "\\";

        try {
            String strInfo; //line read from file
            String strOut;
            StringBuffer sbWord = new StringBuffer();
            int intIndex = 0;
            int intLineCount = 0;
            int intCharPos = 0;
            int intTempCharPos = 0;
            int intNewWords = 0;
            int intTooFrequent = 0;
            int intPageNum;
            boolean bFinishedWord;
            boolean bFinishedVols = false;
            Vector vLastVol = new Vector();
            Vector vLastPage = new Vector();
            PrintWriter pwVols = new PrintWriter(new FileWriter(strVolsDestPath + strAuth + "_vols.txt", false));

            intVol = 1;
            while (!bFinishedVols) {
                File fVolTxt = new File(strVolsPath + strAuth + intVol + ".doc");
                if (!fVolTxt.exists()) {
                    bFinishedVols = true;
                } else {
                    taOutput.append(NEW_LINE + "Analysing volume " + intVol);
                    tfProgress.setText(strAuth + intVol);
                    String strVolName = "";
                    intPageNum = 0;

                    FileReader frVolTxt = new FileReader(fVolTxt);
                    BufferedReader brLog = new BufferedReader(frVolTxt);
                    while ((strInfo = brLog.readLine()) != null) {//still more lines
                        sbLine.replace(0, sbLine.length(), strInfo);
                        intCharPos = 0;
                        while (intCharPos < sbLine.length()) {
                            if (sbLine.charAt(intCharPos) == '{') {//start page number
                                intCharPos++;
                                sbPageNum.replace(0, sbPageNum.length(), "");
                                while (sbLine.charAt(intCharPos) != '}') {
                                    sbPageNum.append(sbLine.charAt(intCharPos));
                                    intCharPos++;
                                }
                                if (sbPageNum.charAt(0) == '#') {//volume name
                                    strVolName = sbPageNum.toString().substring(1);
                                    intCharPos++;
                                } else {
                                    intPageNum = (new Integer(sbPageNum.toString())).intValue();
                                }
                            } else if ((Character.isLetter(sbLine.charAt(intCharPos))) || (Character.isDigit(sbLine.charAt(intCharPos)))) {
                                sbWord.replace(0, sbWord.length(), "");
                                bFinishedWord = false;
                                while (!bFinishedWord) {
                                    if (intCharPos >= sbLine.length()) {
                                        bFinishedWord = true;
                                    } else if ((Character.isLetter(sbLine.charAt(intCharPos))) || (Character.isDigit(sbLine.charAt(intCharPos)))) {
                                        sbWord.append(sbLine.charAt(intCharPos));
                                        intCharPos++;
                                    } else if (sbLine.charAt(intCharPos) == '\'') {
                                        if (intCharPos < sbLine.length() - 1) {
                                            if (Character.isLetter(sbLine.charAt(intCharPos + 1))) {
                                                sbWord.append(sbLine.charAt(intCharPos));
                                                intCharPos++;
                                            } else {
                                                bFinishedWord = true;
                                            }
                                        } else {
                                            bFinishedWord = true;
                                        }
                                    } else if (sbLine.charAt(intCharPos) == '�') {
                                        sbWord.append("'");
                                        intCharPos++;
                                    } else if (sbLine.charAt(intCharPos) == '-') {
                                        if ((intCharPos > 0) && (Character.isLetter(sbLine.charAt(intCharPos - 1)))) {
                                            //hyphens are only included if preceded by letter
                                            sbWord.append(sbLine.charAt(intCharPos));
                                            intCharPos++;
                                        } else {
                                            bFinishedWord = true;
                                        }
                                    } else {
                                        bFinishedWord = true;
                                    }
                                }

                                String strVol = intVol + "";
                                String strWord = sbWord.toString().toLowerCase();
                                if (htWords.get(strWord) != null) {//word already in index
                                    intIndex = ((Integer)htWords.get(strWord)).intValue();
                                    int intCount = ((Integer)vCounts.elementAt(intIndex)).intValue() + 1;
                                    if (intCount <= Constants.TOO_FREQUENT) {//word not too frequent yet
                                        boolean bSameVol = strVol.equals(vLastVol.elementAt(intIndex));
                                        boolean bSamePage = sbPageNum.toString().equals(vLastPage.elementAt(intIndex));

                                        Vector vBytes = (Vector)vOccurs.elementAt(intIndex);
                                        if (bSameVol && !bSamePage) {//just add page delta
                                            int intDiff = (new Integer(sbPageNum.toString())).intValue() - (new Integer((String)vLastPage.elementAt(intIndex))).intValue();
                                            if (intDiff > 254) {
                                                vBytes.add(new Byte((byte)255));
                                                int intHigh = intDiff / 254;
                                                int intLow = intDiff - (intHigh * 254);
                                                vBytes.add(new Byte((byte)intHigh));
                                                vBytes.add(new Byte((byte)intLow));
                                            } else {
                                                vBytes.add(new Byte((byte)intDiff));
                                            }
                                            vOccurs.setElementAt(vBytes, intIndex);
                                            vLastPage.setElementAt(sbPageNum.toString(), intIndex);
                                            vCounts.setElementAt(new Integer(intCount), intIndex);
                                        } else if (!bSameVol) {//add volume & page delta
                                            vBytes.add(new Byte((byte)0));
                                            vBytes.add(new Byte((byte)intVol));
                                            if (intPageNum > 254) {
                                                vBytes.add(new Byte((byte)255));
                                                int intHigh = intPageNum / 254;
                                                int intLow = intPageNum - (intHigh * 254);
                                                vBytes.add(new Byte((byte)intHigh));
                                                vBytes.add(new Byte((byte)intLow));
                                            } else {
                                                vBytes.add(new Byte((byte)intPageNum));
                                            }
                                            vOccurs.setElementAt(vBytes, intIndex);
                                            vLastVol.setElementAt(strVol, intIndex);
                                            vLastPage.setElementAt(sbPageNum.toString(), intIndex);
                                            vCounts.setElementAt(new Integer(intCount), intIndex);
                                        }
                                    } else {//word too frequent, throw away details
                                        vCounts.setElementAt(new Integer(intCount), intIndex);
                                        if (intCount == Constants.TOO_FREQUENT + 1) {
                                            intTooFrequent++;
                                            vOccurs.setElementAt(null, intIndex);
                                            taOutput.append(" " + strWord);
                                        }
                                    }
                                } else {//first occurrence of word
                                    vWords.add(strWord);
                                    vCounts.add(new Integer(1));
                                    Vector vBytes = new Vector();
                                    intPageNum = (new Integer(sbPageNum.toString())).intValue();
                                    vBytes.add(new Byte((byte)0));
                                    vBytes.add(new Byte((byte)intVol));
                                    if (intPageNum > 254) {
                                        vBytes.add(new Byte((byte)255));
                                        int intHigh = intPageNum / 254;
                                        int intLow = intPageNum - (intHigh * 254);
                                        vBytes.add(new Byte((byte)intHigh));
                                        vBytes.add(new Byte((byte)intLow));
                                    } else {
                                        vBytes.add(new Byte((byte)intPageNum));
                                    }
                                    vOccurs.add(vBytes);
                                    vLastVol.add(strVol);
                                    vLastPage.add(sbPageNum.toString());
                                    htWords.put(strWord, new Integer(intNewWords));
                                    intNewWords++;
                                }
                            } else {
                                intCharPos++;
                            }
                        }
                        intLineCount = intLineCount + 1;
                    }

                    pwVols.println(strAuth + intVol + "~" + strVolName + "~" + intPageNum);
                    brLog.close();
                    intVol++;
                }
            }
            pwVols.close();

            //convert byte vectors to byte arrays
            taOutput.append(NEW_LINE + "Convert byte vectors to byte arrays ...");
            for (int x = 0; x < vOccurs.size(); x++) {
                Vector vRefs = (Vector)vOccurs.elementAt(x);
                if (vRefs != null) {
                    byte[] baRefs = new byte[vRefs.size()];
                    for (int y = 0; y < vRefs.size(); y++) {
                        baRefs[y] = ((Byte)vRefs.elementAt(y)).byteValue();
                    }
                    vOccurs.setElementAt(baRefs, x);
                }
            }

            String[] saWords = new String[vWords.size()];
            for (int x = 0; x < vWords.size(); x++) {
                saWords[x] = (String)vWords.elementAt(x);
            }

            //generate page offsets
            taOutput.append(NEW_LINE + "Generate page offsets ...");
            String strPageNum = "";
            int intLastPageNum = 0;
            int intCurrPageNum = 0;
            int intTotalPages = 0;
            long longOffset;
            long longLastSentenceOffset;
            long longNextSentenceOffset;
            long longFirstSentenceOffset;
            long longLongestPage = 0;
            boolean bNewPage = false;

            intVol = 1;
            bFinishedVols = false;

            taOutput.append(NEW_LINE);
            while (!bFinishedVols) {
                File fOffsets;
                if (strAuth.equals("bible")) {
                    fOffsets = new File(strVolsDestPath + Constants.getBook(intVol - 1) + ".htm");
                } else {
                    fOffsets = new File(strVolsDestPath + strAuth + intVol + ".htm");
                }

                longLastSentenceOffset = 0; //absolute offset within volume of last full stop
                longFirstSentenceOffset = 0; //last fullstop before a new page
                longNextSentenceOffset = 0; //

                if (!fOffsets.exists()) {
                    bFinishedVols = true;
                } else {
                    if (strAuth.equals("bible")) {
                        taOutput.append(NEW_LINE + "Finding page references for " + Constants.getBookDisplay(intVol - 1));
                    } else {
                        taOutput.append(NEW_LINE + "Finding page references for volume " + intVol);
                    }
                    FileReader frVol = new FileReader(fOffsets);
                    BufferedReader brVol = new BufferedReader(frVol);
                    longOffset = 0;
                    while ((strInfo = brVol.readLine()) != null) {//still more lines
//taOutput.append(NEW_LINE + "********************** " + strPageNum + " (longOffset:" + longOffset + " longLastSentenceOffset:" + longLastSentenceOffset + " longFirstSentenceOffset:" + longFirstSentenceOffset + ") **********************" + NEW_LINE + strInfo + NEW_LINE + "******************************************************************************");
                        int intBookmarkPos = strInfo.indexOf("<a name=");
                        while (intBookmarkPos != -1) {
                            strPageNum = strInfo.substring(intBookmarkPos + 8, strInfo.indexOf(">", intBookmarkPos)).trim();
                            if (strPageNum.indexOf(":") != -1) {//just new sentence
                                longLastSentenceOffset = longOffset + intBookmarkPos;
//taOutput.append(NEW_LINE + intVol + "/" + strPageNum + "=" + longLastSentenceOffset);
                                if (bNewPage) {
                                    while (vLengths.size() < vOffsets.size()) {
//taOutput.append(NEW_LINE + "vLengths: " + (longLastSentenceOffset - longFirstSentenceOffset));
                                        vLengths.add(new Long(longLastSentenceOffset - longFirstSentenceOffset));
                                    }
                                    if ((longLastSentenceOffset - longFirstSentenceOffset) > longLongestPage) {
                                        longLongestPage = longLastSentenceOffset - longFirstSentenceOffset;
                                        taOutput.append(NEW_LINE + "LONGEST PAGE: " + intVol + "/" + strPageNum + "=" + longLastSentenceOffset + "-" + longFirstSentenceOffset + "=" + longLongestPage);
                                    }
                                    bNewPage = false;
                                }
                            } else {//new page
                                intCurrPageNum = (new Integer(strPageNum)).intValue();
                                if (intCurrPageNum > intLastPageNum + 1) {
                                    taOutput.append(NEW_LINE + "MISSING PAGE(S) BEFORE: " + intVol + "/" + strPageNum);
                                }
                                intLastPageNum = intCurrPageNum;
                                intTotalPages++;
                                vVolPages.add(intVol + "/" + strPageNum);
                                if (longLastSentenceOffset == 0) {//first page
                                    longLastSentenceOffset = longOffset + intBookmarkPos;
                                    longNextSentenceOffset = longLastSentenceOffset;
                                }
//taOutput.append(NEW_LINE + intVol + "/" + strPageNum + " last=" + longLastSentenceOffset);
                                vOffsets.add(new Long(longLastSentenceOffset));
                                longFirstSentenceOffset = longNextSentenceOffset;
                                longNextSentenceOffset = longLastSentenceOffset;
                                bNewPage = true;
//taOutput.append(NEW_LINE + "first=" + longFirstSentenceOffset + " next=" + longNextSentenceOffset);
                            }
                            intBookmarkPos = strInfo.indexOf("<a name=", intBookmarkPos + 1);
                        }
                        longOffset = longOffset + strInfo.length() + 2;
                    }
//taOutput.append(NEW_LINE + "vLengths: " + (longLastSentenceOffset - longFirstSentenceOffset));
                    if (longLastSentenceOffset > longFirstSentenceOffset) {
                        vLengths.add(new Long(longLastSentenceOffset - longFirstSentenceOffset));
                    }
                    brVol.close();
                }
                intVol++;
//bFinishedVols = true;
            }

taOutput.append(NEW_LINE + "Converting arrays ..." + vVolPages.size() + ", " + vOffsets.size() + ", " + vLengths.size());
            String[] saVolPages = new String[vVolPages.size()];
            for (int x = 0; x < vVolPages.size(); x++) {
                saVolPages[x] = (String)vVolPages.elementAt(x);
            }

            long[] laOffsets = new long[vOffsets.size()];
            for (int x = 0; x < vOffsets.size(); x++) {
                laOffsets[x] = ((Long)vOffsets.elementAt(x)).longValue();
            }

            long[] laLengths = new long[vLengths.size() - 1];
            for (int x = 0; x < (vLengths.size() - 1); x++) {
                laLengths[x] = ((Long)vLengths.elementAt(x + 1)).longValue();
            }

taOutput.append(NEW_LINE + "Writing index ..." + saVolPages.length + ", " + laOffsets.length + ", " + laLengths.length);
            FileOutputStream fosIndex = new  FileOutputStream(strIndexPath + strAuth + ".idx");
            ObjectOutputStream oosIndex = new ObjectOutputStream(fosIndex);
            oosIndex.writeObject(saWords);
            oosIndex.writeObject(vOccurs);
            oosIndex.writeObject(saVolPages);
            oosIndex.writeObject(laOffsets);
            oosIndex.writeObject(laLengths);
            oosIndex.flush();
            oosIndex.close();
            taOutput.append(NEW_LINE + NEW_LINE + "Wrote " + vWords.size() + " words to index (" + strIndexPath + strAuth + ".idx) - " + intTooFrequent + " were too frequent to be included in index");
            taOutput.append(NEW_LINE + "Wrote " + intTotalPages + " pages refs to index (" + strIndexPath + strAuth + ".idx)");
        } catch (Exception e) {
            taOutput.append(NEW_LINE + "*** Problem in volume " + intVol + " ***" + e);
            taOutput.append(NEW_LINE + "Line: '" + sbLine.toString() + "'");
            taOutput.append(NEW_LINE + e);
        }
    }//writeIndex

    private void createSuperIndex() {
        int intWordCount = 0;
        HashSet hsSuperset = new HashSet();
        Index index = Index.getIndex();
        Progress progressAutoLoad = new Progress("Searching indexes ...", (Constants.MAX_AUTH_POS + 1)*2);
        try {
            for (int intAuth = 0; intAuth <= Constants.MAX_AUTH_POS; intAuth++) {
                progressAutoLoad.increment("Finding words in " + Constants.getAuthDisplay(intAuth) + " index ...");
                index.loadIndex(intAuth);

                for (int x = 0; x < index.saWords.length; x++) {
                    if (!hsSuperset.contains(index.saWords[x])) {
                        hsSuperset.add(index.saWords[x]);
                        intWordCount++;
                    }
                }
            }
            String[] saSuperset = new String[intWordCount];
            Iterator iterWords = hsSuperset.iterator();
            int intWordCurr = 0;
            while (iterWords.hasNext()) {
                saSuperset[intWordCurr] = (String)iterWords.next();
                intWordCurr++;
            }
            Arrays.sort(saSuperset);
            int[][] iaaRefs = new int[intWordCount][Constants.MAX_AUTH_POS + 1];

            for (int intAuth = 0; intAuth <= Constants.MAX_AUTH_POS; intAuth++) {
                progressAutoLoad.increment("Counting references in " + Constants.getAuthDisplay(intAuth) + " index ...");
                index.loadIndex(intAuth);
                for (int x = 0; x < saSuperset.length; x++) {
                    int intIndex = index.getIndexPos(saSuperset[x]);

                    if (intIndex == Constants.NOT_FOUND) {//word not found in index
                        iaaRefs[x][intAuth] = 0;
                    } else {
                        byte[] baRefs = index.getRefs(intIndex);
                        if (baRefs == null) {//more than TOO_FREQUENT refs
                            iaaRefs[x][intAuth] = -1;
                        } else {
                            int intCount = 0;
                            int intRef = 0;
                            while (intRef < baRefs.length) {
                                if (baRefs[intRef] == 0) {
                                    intRef++; //skip page change
                                } else if (baRefs[intRef] == -1) {
                                    intRef++; //count large delta as 1 ref
                                    intRef++;
                                    intCount++;
                                } else {
                                    intCount++;
                                }
                                intRef++;
                            }
                            iaaRefs[x][intAuth] = intCount;
                        }
                    }
                }
            }

            // MJP 1x 15/3/15
            FileOutputStream fosSSIndex = new  FileOutputStream(Constants.BASIC_FILE_PATH + "target\\bible\\superset.idx");
            ObjectOutputStream oosSSIndex = new ObjectOutputStream(fosSSIndex);
            oosSSIndex.writeObject(saSuperset);
            oosSSIndex.writeObject(iaaRefs);
            oosSSIndex.flush();
            oosSSIndex.close();
            taOutput.append(NEW_LINE + NEW_LINE + "Wrote " + saSuperset.length + " words to superset index (" + Constants.BASIC_FILE_PATH + "target" + File.separator + "bible" + File.separator + "superset.idx)");

            PrintWriter pwLog = new PrintWriter(new FileWriter(Constants.BASIC_FILE_PATH + "src" + File.separator + "superindex.doc", false));
            pwLog.println("Words\tBible\tJND\tJBS\tCHM\tFER\tCAC\tJT\tGRC\tAJG\tSMC\tMisc\tHymns");
            for (int x = 0; x < saSuperset.length; x++) {
                pwLog.println(saSuperset[x] + "\t" +
                    iaaRefs[x][Constants.BIBLE_POS] + "\t" +
                    iaaRefs[x][Constants.JND_POS] + "\t" +
                    iaaRefs[x][Constants.JBS_POS] + "\t" +
                    iaaRefs[x][Constants.CHM_POS] + "\t" +
                    iaaRefs[x][Constants.FER_POS] + "\t" +
                    iaaRefs[x][Constants.CAC_POS] + "\t" +
                    iaaRefs[x][Constants.JT_POS] + "\t" +
                    iaaRefs[x][Constants.GRC_POS] + "\t" +
                    iaaRefs[x][Constants.AJG_POS] + "\t" +
                    iaaRefs[x][Constants.SMC_POS] + "\t" +
                    iaaRefs[x][Constants.MISC_POS] + "\t" +
                    iaaRefs[x][Constants.HYMNS_POS]
                    );
            }
            pwLog.close();
        } catch (Exception e) {
            taOutput.append(NEW_LINE + "*** Problem in analysing index ***" + e);
            taOutput.append(NEW_LINE + e);
        }
        progressAutoLoad.close();
    }//createSuperIndex

    //initialize
    public void init() throws Exception {
        this.setSize(new Dimension(900,500));

        taFilename.setBorder(BorderFactory.createLoweredBevelBorder());
        getContentPane().add(taFilename, BorderLayout.NORTH);

        spOutput.setBorder(BorderFactory.createLoweredBevelBorder());
        getContentPane().add(spOutput, BorderLayout.CENTER);

        mTools.add(miBible);
        mTools.add(miHymns);
        mTools.add(miRefreshAll);
        mbPrepare.add(mTools);
        setJMenuBar(mbPrepare);

        comboAuth.addItem("Bible");
        comboAuth.addItem("JND");
        comboAuth.addItem("JBS");
        comboAuth.addItem("CHM");
        comboAuth.addItem("FER");
        comboAuth.addItem("CAC");
        comboAuth.addItem("JT");
        comboAuth.addItem("GRC");
        comboAuth.addItem("AJG");
        comboAuth.addItem("SMC");
        comboAuth.addItem("Misc");
        comboAuth.addItem("Hymns");

        panelButtons.add(comboAuth);
        panelButtons.add(buttonTidy);
        panelButtons.add(buttonPrepare);
        panelButtons.add(buttonWriteIndex);
        panelButtons.add(buttonCreateSuperIndex);
        panelButtons.add(buttonSearchSuperIndex);
        panelButtons.add(buttonSearchIndex);
        panelButtons.add(tfProgress);

        getContentPane().add(panelButtons, BorderLayout.SOUTH);
        validate();
        show();
    }

    //Main method
    public static void main(String[] args) {
        JFrame frame = new Prepare();
    }
}