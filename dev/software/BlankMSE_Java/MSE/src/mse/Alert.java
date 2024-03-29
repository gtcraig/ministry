//package com.asidua.mse;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

class Alert extends JFrame implements ActionListener {
    private static final int MIN_WIDTH = 450;
    private static final int MIN_HEIGHT = 100;

    GridBagLayout gridBagLayout1 = new GridBagLayout();
    JLabel labelMessage;
    JButton buttonOK = new JButton("OK");
    Icon icoError = new ImageIcon("images/error.gif");
    JLabel labelIcon = new JLabel(icoError);

    Alert (String strSeverity, String strMessage) {
        super();

        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
                dispose();
            }
        });
        buttonOK.addActionListener(this);

        ComponentHandler ch = new ComponentHandler(this, MIN_WIDTH, MIN_HEIGHT);
        addComponentListener(ch);

        setTitle(" " + strSeverity);
        ImageIcon image = new ImageIcon("images/books.gif");
        setIconImage(image.getImage());

        labelMessage = new JLabel(strMessage);
        if (strSeverity.toLowerCase().equals("error")) {
            labelMessage.setForeground(new Color(255, 0, 0));
        }

        getContentPane().setLayout(gridBagLayout1);
        getContentPane().add(labelMessage,
            new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0,
            GridBagConstraints.CENTER, GridBagConstraints.NONE,
            new Insets(5, 5, 5, 5), 0, 0));
        getContentPane().add(buttonOK,
            new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0,
            GridBagConstraints.CENTER, GridBagConstraints.NONE,
            new Insets(5, 5, 5, 5), 0, 0));

        validate();
        setVisible(true);
    }

    public void actionPerformed(ActionEvent e) {
        Object buttonSource = e.getSource();
        if (buttonSource == buttonOK) {
            setVisible(false);
            dispose();
        }
    }
}//Alert