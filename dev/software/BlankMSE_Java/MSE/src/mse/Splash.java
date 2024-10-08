//package com.asidua.mse;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.util.Calendar;
import java.util.Properties;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JWindow;

class Splash extends JWindow implements ActionListener {
    Calendar calEndTime;

    GridBagLayout gridBagLayout1 = new GridBagLayout();
    Icon icoSplash = new ImageIcon("images/splash.gif");
    JPanel panelSplash = new JPanel();
    JLabel labelSplash = new JLabel(icoSplash);
    JLabel labelVersion = new JLabel("Version: " + Constants.MSE_VERSION);
    JLabel labelJREVendor = new JLabel("JRE Vendor: " +
        ((Properties) System.getProperties()).getProperty("java.vendor"));
    JLabel labelJREVersion = new JLabel("JRE Version: " +
        ((Properties) System.getProperties()).getProperty("java.version"));
    JLabel labelClasspath = new JLabel("Classpath: " +
        ((Properties) System.getProperties()).getProperty("java.class.path"));
    JLabel labelCopyright = new JLabel("Copyright (c) 2005 Ian Purdy. All rights reserved.");
    JButton buttonOK = new JButton("OK");

    Splash(boolean bOKButton) {
        super();

        calEndTime = Calendar.getInstance();
        calEndTime.add(Calendar.MILLISECOND, 2000);

        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
                dispose();
            }
        });

        buttonOK.addActionListener(this);

        setSize(300, 400);
        Dimension screenDim = Toolkit.getDefaultToolkit().getScreenSize();
        Rectangle frameDim = getBounds();
        setLocation((screenDim.width - frameDim.width) / 2,
		    (screenDim.height - frameDim.height) / 2);

        getContentPane().setLayout(new BorderLayout());
        getContentPane().add(labelSplash, BorderLayout.NORTH);
        panelSplash.setLayout(gridBagLayout1);
        panelSplash.setBackground(new Color(225, 255, 255));
        panelSplash.add(labelVersion, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelSplash.add(labelJREVendor, new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelSplash.add(labelJREVersion, new GridBagConstraints(0, 4, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        panelSplash.add(labelClasspath, new GridBagConstraints(0, 5, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        if (bOKButton) {
            panelSplash.add(buttonOK, new GridBagConstraints(0, 6, 1, 1, 0.0, 0.0
                    ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        }
        panelSplash.add(labelCopyright, new GridBagConstraints(0, 7, 1, 1, 0.0, 0.0
                ,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(5, 5, 5, 5), 0, 0));
        getContentPane().add(panelSplash, BorderLayout.CENTER);
        validate();
        setVisible(true);
    }

    public void close() {
        while (!Calendar.getInstance().after(calEndTime)) {
            try {
                Thread.sleep(100);
            } catch(InterruptedException ie) {
            }
        }
        setVisible(false);
        dispose();
    }

    public void actionPerformed(ActionEvent e) {
        Object buttonSource = e.getSource();
        if (buttonSource == buttonOK) {
            setVisible(false);
            dispose();
        }
    }
}//Splash