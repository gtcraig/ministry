//package com.asidua.mse;

import javax.swing.JCheckBox;

public class SearchEngine {
    Options options;
    Index index;
    Log log;

    JCheckBox[] cbToBeSearched = new JCheckBox[Constants.MAX_AUTH_POS + 1];

    public SearchEngine() {
    }

    int intFromByte(byte byteIn) {
        int byteCurr = (int)byteIn;
        if (byteCurr < 0) {
            byteCurr = 256 + byteCurr;
        }
        return byteCurr;
    }

    String getBasicWords(String strIn, boolean bDropPunctuation, boolean bDropTableTags) {
        StringBuffer sbIn = new StringBuffer(strIn);
        StringBuffer sbOut = new StringBuffer();
        char charCurr;
        int intCurrPos = 0;
        int intNumSpaces = 0;
        int intNumCols = 0;
        int intLength = sbIn.length();

       //remove html tags & page numbers
        while (intCurrPos < intLength) {
            charCurr = sbIn.charAt(intCurrPos);
            if ((charCurr == 13) || (charCurr == 10)) {
                //ignore carriage returns & line feeds
            } else if (charCurr == '<') {
                int intKeepCurrPos = intCurrPos;
                while ((intCurrPos < sbIn.length()) && (sbIn.charAt(intCurrPos) != '>')) {
                    intCurrPos++;
                }

                if ((intCurrPos < sbIn.length()) && (bDropTableTags == false)) {
                    String strTag = sbIn.toString().substring(intKeepCurrPos, intCurrPos);
                    if ((strTag.equals("</td"))  && (intNumCols < 2)) {
                        sbOut.append("</td><td>");
                        intNumCols++;
                    } else if (strTag.equals("</tr")) {
                        sbOut.append("</td></tr><tr><td>");
                        intNumCols = 0;
                    }
                }

                if ((sbIn.length() - intCurrPos) > 10) {//possibly new page
                    String strNextBit = sbIn.toString().substring(intCurrPos + 1, intCurrPos + 7);
                    if (strNextBit.equals("[Page ")) {//throw away word 'page'
                        while ((intCurrPos < sbIn.length()) && (sbIn.charAt(intCurrPos) != ']')) {
                            intCurrPos++;
                        }
                    }
                }

                if (intNumSpaces == 0) {
                    sbOut.append(" ");
                    intNumSpaces++;
                }
            } else {
                if (bDropPunctuation) {
                    if (Character.isLetter(charCurr) || Character.isDigit(charCurr)) {
                        sbOut.append(charCurr);
                        intNumSpaces = 0;
                    } else if (charCurr == '-' || charCurr == '\'') {
                        if ((Character.isLetter(sbOut.charAt(sbOut.length() - 1))) && (intNumSpaces == 0)) {
                            sbOut.append(charCurr);
                        } else if (intNumSpaces == 0) {
                            sbOut.append(" ");
                            intNumSpaces++;
                        }
                    } else if (intNumSpaces == 0) {
                        sbOut.append(" ");
                        intNumSpaces++;
                    }
                } else {
                    sbOut.append(charCurr);
                    intNumSpaces = 0;
                }
            }
            intCurrPos++;
        }
        return sbOut.toString();
    }

    int findSentence(String strSearchArea, int intStartCharPos, int intAuth) {
        boolean bFoundNextBit = false;
        while (!bFoundNextBit) {
            intStartCharPos = strSearchArea.indexOf("<a name=", intStartCharPos + 1);
            if (intStartCharPos == -1) {//end of page
                intStartCharPos = strSearchArea.length();
                bFoundNextBit = true;
            } else if ((strSearchArea.indexOf(":", intStartCharPos) < strSearchArea.indexOf(">", intStartCharPos)) &&
                    (strSearchArea.indexOf(":", intStartCharPos) != -1)) {//found full stop
                bFoundNextBit = true;
            } else if (intAuth == Constants.BIBLE_POS) {
                bFoundNextBit = true;
            }
        }
        return intStartCharPos;
    }

    int findParagraph(String strSearchArea, int intStartCharPos) {
        boolean bFoundNextBit = false;
        while (!bFoundNextBit) {
            intStartCharPos = strSearchArea.indexOf("<a name=", intStartCharPos + 1);
            if (intStartCharPos == -1) {//end of page
                intStartCharPos = strSearchArea.length();
                bFoundNextBit = true;
            } else {
                int intColonPos = strSearchArea.indexOf(":", intStartCharPos);
                int intBookmarkEnd = strSearchArea.indexOf(">", intStartCharPos);
                if ((intColonPos < intBookmarkEnd) && (intColonPos != -1)) {//found full stop
                    if (strSearchArea.substring(intBookmarkEnd + 5, intBookmarkEnd + 8).equals("<p>")) {
                        bFoundNextBit = true;
                    }
                }
            }
        }
        return intStartCharPos;
    }

    boolean phraseSearch(String strExtract, String strSearch) {
        int intPos = getBasicWords(" " + strExtract + " ", true, true).toLowerCase().indexOf(" " + strSearch + " ");
        if (intPos == -1) {
            return false;
        } else {
            return true;
        }
    }

    boolean wildSearch(String strExtract, String[] saSearchWords) {
        boolean bFound = false;
        strExtract = getBasicWords(" " + strExtract + " ", true, true).toLowerCase();

        for (int x = 0; (x < saSearchWords.length) && (!bFound); x++) {
            int intPos = strExtract.indexOf(" " + saSearchWords[x] + " ");
            if (intPos != -1) {
                bFound = true;
            }
        }
        return bFound;
    }

    boolean wordSearch(String strExtract, String[] saSearchWords) {
        boolean bFound = true;
        strExtract = getBasicWords(" " + strExtract + " ", true, true).toLowerCase();

        for (int x = 0; (x < saSearchWords.length) && (bFound); x++) {
            int intPos = strExtract.indexOf(" " + saSearchWords[x] + " ");
            if (intPos == -1) {
                bFound = false;
            }
        }
        return bFound;
    }

    String formatSection(String strIn, String[] saSearchWords, boolean bDropTableTags) {
        String strOut;
        int intCurrPos = 0;

        //bold words that match search words
        strOut = getBasicWords(strIn, false, bDropTableTags);
        for (int x = 0; x < saSearchWords.length; x++) {
            String strWord = saSearchWords[x];
            intCurrPos = strOut.toLowerCase().indexOf(strWord);
            while (intCurrPos != -1) {
                //determine letter before & after match
                char charPre = ' ';
                char charPost = ' ';
                if (intCurrPos > 0) {
                    charPre = strOut.charAt(intCurrPos - 1);
                }
                if (intCurrPos + strWord.length() < strOut.length()) {
                    charPost = strOut.charAt(intCurrPos + strWord.length());
                }
                //only bold if not letter before & after match
                if (!Character.isLetterOrDigit(charPre) && !Character.isLetterOrDigit(charPost)) {
                    strOut = strOut.substring(0, intCurrPos) + "<b>" +
                        strOut.substring(intCurrPos, intCurrPos + strWord.length()) + "</b>" +
                        strOut.substring(intCurrPos + strWord.length());
                }
                intCurrPos = strOut.toLowerCase().indexOf(strWord, intCurrPos + 4);
            }
        }
        return strOut;
    }
}//SearchEngine


