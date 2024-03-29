//package com.asidua.mse;

import java.awt.Cursor;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableModel;
import java.util.Arrays;

class SortedWordsTableModel extends AbstractTableModel{
    private TableModel tmWords;
    private int intSortKeyColumn;
    private Row[] raRows;

    public SortedWordsTableModel() {
        intSortKeyColumn = 1;
        tmWords = new WordsTableModel();
        raRows = new Row[tmWords.getRowCount()];
        for (int i = 0; i < raRows.length; i++) {
            raRows[i] = new Row();
            raRows[i].intIndex = i;
        }
    }

    public TableModel getModel() {
        return tmWords;
    }

    public void sort(int intSortKeyColumnIn, final JTable tWords) {
        if (intSortKeyColumnIn != 0) {
            intSortKeyColumn = intSortKeyColumnIn;
            Thread doWorkRunnable = new Thread() {
                public void run() {
                    tWords.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
                    tWords.getTableHeader().setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
                    Arrays.sort(raRows);
                    fireTableDataChanged();
                    tWords.setCursor(null);
                    tWords.getTableHeader().setCursor(null);
                }
            };
            doWorkRunnable.start();
        }
    }

    public void addMouseListener(final JTable tWords) {
        tWords.getTableHeader().addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent event) {
                // check for double click
                if (event.getClickCount() < 2) {
                    return;
                }

                // find column of click and
                int intSortKeyColumn = tWords.columnAtPoint(event.getPoint());

                // translate to table model index and sort
                int intModelColumn = tWords.convertColumnIndexToModel(intSortKeyColumn);
                sort(intModelColumn, tWords);
            }
        });
    }

   /* compute the moved row for the three methods that access
    * model elements
    */

    public Object getValueAt(int intRow, int intColumn) {
        Object oValue = "";
        if (intColumn == 0) {
            oValue = new Integer(intRow + 1);
        } else {
            oValue = tmWords.getValueAt(raRows[intRow].intIndex, intColumn);
        }
        return oValue;
    }

    // delegate all remaining methods to the model
    public int getRowCount() {
        return tmWords.getRowCount();
    }

    public int getColumnCount() {
        return tmWords.getColumnCount();
    }

    public String getColumnName(int intColumn) {
        return tmWords.getColumnName(intColumn);
    }

    public int find(String strFind) {
        int intIndex = ((WordsTableModel)tmWords).find(strFind);
        if (intSortKeyColumn != 1) {
            for (int intRow = 0; intRow < raRows.length; intRow++) {
                if (raRows[intRow].intIndex == intIndex) {
                    intIndex = intRow;
                    break;
                }
            }
        }
        return intIndex;
    }

   /* this inner class holds the index of the model row
    * Rows are compared by looking at the model row entries
    * in the sort column
    */

    private class Row implements Comparable {
        public int intIndex;

        public int compareTo(Object oOtherRow) {
            Row rOtherRow = (Row)oOtherRow;
            Object a = tmWords.getValueAt(intIndex, intSortKeyColumn);
            Object b = tmWords.getValueAt(rOtherRow.intIndex, intSortKeyColumn);
            if (a instanceof Comparable) {
                return ((Comparable)a).compareTo(b);
            } else {
                return intIndex - rOtherRow.intIndex;
            }
        }
    }
}