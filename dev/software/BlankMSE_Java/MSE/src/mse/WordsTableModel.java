//package com.asidua.mse;

import java.io.File;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import javax.swing.table.AbstractTableModel;

public class WordsTableModel extends AbstractTableModel {
    String[] saWords;
    int[][] iaaRefs;

    String[] saColumnNames = {"Row", "Word", "Total Refs", "Bible", "JND", "JBS", "CHM", "FER", "CAC", "JT", "GRC", "AJG", "SMC", "Misc", "Hymns"};

    public WordsTableModel() {
        try {
            
            // MJP 1x 21/3/15
            File fIndex = new File(Constants.BASIC_FILE_PATH + "target" + File.separator + "bible" + File.separator + "superset.idx");
            if (fIndex.exists()) {
                FileInputStream fisIndex = new  FileInputStream(fIndex);
                ObjectInputStream oisIndex = new ObjectInputStream(fisIndex);
                saWords = (String[])oisIndex.readObject();
                iaaRefs = (int[][])oisIndex.readObject();
                oisIndex.close();
            }
        } catch (Exception e) {
            
            // MJP 1x 15/3/15
            new Alert("Error", "Error reading superset index (" + Constants.BASIC_FILE_PATH + "target" + File.separator + "bible" + File.separator + "superset.idx)");
            Log.getLog().write(Constants.LOG_LOW, "<br>Error reading superset index: " + e);
        }
    }//WordsListModel

    public int getRowCount() {
        return saWords.length;
    }//getSize

    public int getColumnCount() {
        return saColumnNames.length;
    }

    public String getColumnName(int intCol) {
        return saColumnNames[intCol].toString();
    }

    public Object getValueAt(int intRow, int intCol) {
        Object oValue;
        if (intCol == 0) {
            oValue = intRow + "";
        } else if (intCol == 1) {
            oValue = saWords[intRow];
        } else if (intCol == 2) {
            int intTotal = 0;
            for (int intAuth = 0; intAuth <= Constants.MAX_AUTH_POS; intAuth++) {
                if (iaaRefs[intRow][intAuth] == -1) {
                    intTotal = -1;
                    break;
                } else {
                    intTotal = intTotal + iaaRefs[intRow][intAuth];
                }
            }
            oValue = new Integer(intTotal);
        } else {
            oValue = new Integer(iaaRefs[intRow][intCol - 3]);
        }

        if (oValue.toString().equals("-1")) {
            oValue = new Integer(9999);
        }

        return oValue;
    }

    public int find(String strFind) {
        int intIndex = 0;
        for (int x = 0; x < saWords.length; x++) {
            if (saWords[x].length() >= strFind.length()) {
                String strSubWord = saWords[x].substring(0, strFind.length());
                if (strSubWord.equals(strFind)) {
                    intIndex = x;
                    break;
                }
            }
        }
        return intIndex;
    }
}//WordsListModel