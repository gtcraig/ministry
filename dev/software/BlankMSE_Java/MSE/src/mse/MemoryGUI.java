//package com.asidua.mse;

import java.awt.AWTEvent;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.Toolkit;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.Timer;

public class MemoryGUI extends JFrame implements ActionListener {
    private static final int MIN_WIDTH = 400;
    private static final int MIN_HEIGHT = 220;

    Timer timerUpdate = new Timer(1000, this);

    GridBagLayout gridBagLayout1 = new GridBagLayout();
    GridBagLayout gridBagLayout2 = new GridBagLayout();
    GridBagLayout gridBagLayout3 = new GridBagLayout();

    private JPanel panelDisplay = new JPanel();
    private JPanel panelButtons = new JPanel();

    JLabel labelUsedMemory  = new JLabel("Used memory: ");
    JLabel labelUsedMemoryValue = new JLabel("");
    JButton buttonStoreUsedMemory = new JButton("Store");
    JLabel labelStoredUsedMemoryValue = new JLabel("");

    JLabel labelFreeMemory  = new JLabel("Free memory: ");
    JLabel labelFreeMemoryValue = new JLabel("");
    JButton buttonStoreFreeMemory = new JButton("Store");
    JLabel labelStoredFreeMemoryValue = new JLabel("");

    JLabel labelHeapSize  = new JLabel("Total heap size: ");
    JLabel labelHeapSizeValue = new JLabel("");
    JButton buttonStoreHeapSize = new JButton("Store");
    JLabel labelStoredHeapSizeValue = new JLabel("");

    JLabel labelAutoRefresh = new JLabel("Auto collect: ");
    JCheckBox cbAutoRefresh = new JCheckBox();

    JButton buttonRefresh = new JButton("Refresh");
    JButton buttonCollectGarbage = new JButton("Collect Garbage");
    JButton buttonClose = new JButton("Close");

    public MemoryGUI() {
        //add window listener
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
                setVisible(false);
                dispose();
            }
        });
        enableEvents(AWTEvent.WINDOW_EVENT_MASK);

        init();

        buttonStoreUsedMemory.addActionListener(this);
        buttonStoreFreeMemory.addActionListener(this);
        buttonStoreHeapSize.addActionListener(this);
        cbAutoRefresh.addActionListener(this);

        buttonRefresh.addActionListener(this);
        buttonCollectGarbage.addActionListener(this);
        buttonClose.addActionListener(this);
        ComponentHandler ch = new ComponentHandler(this, MIN_WIDTH, MIN_HEIGHT);
        addComponentListener(ch);

        Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
        setLocation((d.width - getSize().width) / 2, 0);
        setVisible(true);
    }//MemoryGUI

    public void actionPerformed(ActionEvent e) {
        Object buttonSource = e.getSource();
        if (buttonSource == buttonStoreHeapSize) {
            labelStoredHeapSizeValue.setText(labelHeapSizeValue.getText());
        } else if (buttonSource == buttonStoreUsedMemory) {
            labelStoredUsedMemoryValue.setText(labelUsedMemoryValue.getText());
        } else if (buttonSource == buttonStoreFreeMemory) {
            labelStoredFreeMemoryValue.setText(labelFreeMemoryValue.getText());
        } else if (buttonSource == buttonRefresh) {
            refreshDisplay();
        } else if (buttonSource == buttonCollectGarbage) {
            System.gc();
            refreshDisplay();
        } else if (buttonSource == buttonClose) {
            timerUpdate.stop();
            setVisible(false);
            dispose();
        } else if (buttonSource == cbAutoRefresh) {
            if (cbAutoRefresh.isSelected()) {
                timerUpdate.start();
            } else {
                timerUpdate.stop();
            }
        } else if (buttonSource == timerUpdate) {
            System.gc();
            refreshDisplay();
        }
    }

    private void init() {
        setTitle(" Ministry Search Engine - Memory Management");
        ImageIcon image = new ImageIcon("images/books.gif");
        setIconImage(image.getImage());

        getContentPane().setLayout(gridBagLayout1);

        panelDisplay.setLayout(gridBagLayout2);
        panelButtons.setLayout(gridBagLayout3);

        //display area
        panelDisplay.add(labelUsedMemory, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(labelUsedMemoryValue, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(buttonStoreUsedMemory, new GridBagConstraints(2, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(labelStoredUsedMemoryValue, new GridBagConstraints(3, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        panelDisplay.add(labelFreeMemory, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(labelFreeMemoryValue, new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(buttonStoreFreeMemory, new GridBagConstraints(2, 1, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(labelStoredFreeMemoryValue, new GridBagConstraints(3, 1, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        panelDisplay.add(labelHeapSize, new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(labelHeapSizeValue, new GridBagConstraints(1, 2, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(buttonStoreHeapSize, new GridBagConstraints(2, 2, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(labelStoredHeapSizeValue, new GridBagConstraints(3, 2, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        panelDisplay.add(labelAutoRefresh, new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelDisplay.add(cbAutoRefresh, new GridBagConstraints(1, 3, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        //buttons
        panelButtons.add(buttonRefresh, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelButtons.add(buttonCollectGarbage, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelButtons.add(buttonClose, new GridBagConstraints(2, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        getContentPane().add(panelDisplay, new GridBagConstraints(0, 0, 1, 1, 1.0, 1.0
                ,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 2, 2));
        getContentPane().add(panelButtons, new GridBagConstraints(0, 1, 1, 1, 1.0, 1.0
                ,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(0, 0, 0, 0), 2, 2));

        refreshDisplay();
        validate();
    }//init

    private void refreshDisplay() {
        String strUsedMemory = (Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())/1024 + "";
        labelUsedMemoryValue.setText(formatLongString(strUsedMemory) + " k");
        String strFreeMemory = Runtime.getRuntime().freeMemory()/1024 + "";
        labelFreeMemoryValue.setText(formatLongString(strFreeMemory) + " k");
        String strHeapSize = Runtime.getRuntime().totalMemory()/1024 + "";
        labelHeapSizeValue.setText(formatLongString(strHeapSize) + " k");
    }

    private String formatLongString(String strInput) {
        int intDotPos = strInput.indexOf(".");
        if (intDotPos != -1) {
            strInput = strInput.substring(0, intDotPos - 1);
        }
        if (strInput.length() > 3) {
            strInput = strInput.substring(0, strInput.length() - 3) + "," + strInput.substring(strInput.length() - 3);
        }
        return strInput;
    }

    protected void processWindowEvent(WindowEvent e) {
        super.processWindowEvent(e);
        if(e.getID() == WindowEvent.WINDOW_CLOSING) {
            setVisible(false);
            dispose();
        }
    }//processWindowEvent
}//MemoryGUI