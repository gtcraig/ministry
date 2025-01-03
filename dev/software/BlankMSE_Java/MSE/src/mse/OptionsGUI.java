//package com.asidua.mse;

import java.awt.AWTEvent;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;
import javax.swing.JTextField;

public class OptionsGUI extends JFrame implements ActionListener {
    private static final int MIN_WIDTH = 550;
    private static final int MIN_HEIGHT = 260;

    Options options;

    JTabbedPane tpOptions = new JTabbedPane();

    private JPanel panelGeneralTab = new JPanel();
    private JPanel panelSetupTab = new JPanel();
    private JPanel panelButtons = new JPanel();

    JLabel labelDefaultBrowser = new JLabel("Default browser");
    JTextField tfDefaultBrowser = new JTextField(30);

    JLabel labelBeep = new JLabel("Beep when search complete");
    JCheckBox cbBeep = new JCheckBox();
    JLabel labelAutoLoad = new JLabel("Load all indexes at startup");
    JCheckBox cbAutoLoad = new JCheckBox();
    JLabel labelSplashWindow = new JLabel("Show splash screen at startup");
    JCheckBox cbSplashWindow = new JCheckBox();
    JLabel labelFullScan = new JLabel("Perform full scan for frequent words");
    JCheckBox cbFullScan = new JCheckBox();
    JLabel labelCreateLog = new JLabel("Create log file (slower search)");
    JCheckBox cbCreateLog = new JCheckBox();
    String[] straLogDetail = {"Low", "Medium", "High"};
    JComboBox cboLogDetail = new JComboBox(straLogDetail);

    JButton buttonOK = new JButton("OK");
    JButton buttonCancel = new JButton("Cancel");

    public OptionsGUI(Options optionsHandle) {
        options = optionsHandle;

        //add window listener
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
                setVisible(false);
                dispose();
            }
        });
        enableEvents(AWTEvent.WINDOW_EVENT_MASK);

        init();

        buttonOK.addActionListener(this);
        buttonCancel.addActionListener(this);
        ComponentHandler ch = new ComponentHandler(this, MIN_WIDTH, MIN_HEIGHT);
        addComponentListener(ch);
    }//OptionsGUI

    public void actionPerformed(ActionEvent e) {
        Object buttonSource = e.getSource();
        if (buttonSource == buttonOK) {
            options.setDefaultBrowser(tfDefaultBrowser.getText());
            options.setAutoLoad(cbAutoLoad.isSelected());
            options.setSplashWindow(cbSplashWindow.isSelected());
            options.setBeep(cbBeep.isSelected());
            options.setFullScan(cbFullScan.isSelected());
            options.setDebugOn(cbCreateLog.isSelected());
            options.setLogDetail(cboLogDetail.getSelectedIndex());
            options.saveOptions();

            setVisible(false);
            dispose();
        } else if (buttonSource == buttonCancel) {
            setVisible(false);
            dispose();
        }
    }

    private void init() {
        setTitle(" Ministry Search Engine - Options");
        ImageIcon image = new ImageIcon("images/books.gif");
        setIconImage(image.getImage());

        getContentPane().setLayout(new GridBagLayout());

        panelGeneralTab.setLayout(new GridBagLayout());
        panelSetupTab.setLayout(new GridBagLayout());
        panelButtons.setLayout(new GridBagLayout());

        //beep
        cbBeep.setSelected(options.getBeep());
        panelGeneralTab.add(labelBeep, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelGeneralTab.add(cbBeep, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        //new window
        cbSplashWindow.setSelected(options.getSplashWindow());
        panelGeneralTab.add(labelSplashWindow, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelGeneralTab.add(cbSplashWindow, new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        //show icons
        cbAutoLoad.setSelected(options.getAutoLoad());
        panelGeneralTab.add(labelAutoLoad, new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelGeneralTab.add(cbAutoLoad, new GridBagConstraints(1, 2, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        //full scan
        cbFullScan.setSelected(options.getFullScan());
        panelGeneralTab.add(labelFullScan, new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelGeneralTab.add(cbFullScan, new GridBagConstraints(1, 3, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        //debug
        cbCreateLog.setSelected(options.getDebugOn());
        panelGeneralTab.add(labelCreateLog, new GridBagConstraints(0, 4, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelGeneralTab.add(cbCreateLog, new GridBagConstraints(1, 4, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        cboLogDetail.setSelectedIndex(options.getLogDetail());
        panelGeneralTab.add(cboLogDetail, new GridBagConstraints(2, 4, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        //default browser
        tfDefaultBrowser.setText(options.getDefaultBrowser());
        panelSetupTab.add(labelDefaultBrowser, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelSetupTab.add(tfDefaultBrowser, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        //buttons
        panelButtons.add(buttonOK, new GridBagConstraints(2, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelButtons.add(buttonCancel, new GridBagConstraints(3, 0, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));

        tpOptions.addTab("General", null, panelGeneralTab, "General Options");
        tpOptions.addTab("Setup", null, panelSetupTab, "Setup Options");
        tpOptions.setSelectedIndex(0);

        getContentPane().add(tpOptions, new GridBagConstraints(0, 0, 1, 1, 1.0, 1.0
                ,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 2, 2));
        getContentPane().add(panelButtons, new GridBagConstraints(0, 1, 1, 1, 1.0, 1.0
                ,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(0, 0, 0, 0), 2, 2));

        validate();
    }//init
}//OptionsGUI