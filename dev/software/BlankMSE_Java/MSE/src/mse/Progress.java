//package com.asidua.mse;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.SwingUtilities;
import javax.swing.Timer;

class Progress extends JFrame implements ActionListener {
    private static final int MIN_WIDTH = 300;
    private static final int MIN_HEIGHT = 100;

    private JPanel panelButtons = new JPanel();
    JLabel labelProgress;
    JProgressBar pgProgress;
    JButton buttonHide = new JButton("Hide");
    JButton buttonStop = new JButton("Stop");

    boolean bStop = false;
    Timer timerUpdate = new Timer(100, this);

    String strCurrentStatus = "Initialising ...";
    int intCurrentValue = 0;

    Progress(String strTitle, int intMax) {
        super();

        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
                dispose();
            }
        });

        ComponentHandler ch = new ComponentHandler(this, MIN_WIDTH, MIN_HEIGHT);
        addComponentListener(ch);

        setLocation(0, 0);
        setTitle(" " + strTitle);
        ImageIcon image = new ImageIcon("images/books.gif");
        setIconImage(image.getImage());

        pgProgress = new JProgressBar(0, intMax);
        labelProgress = new JLabel(strTitle);
        panelButtons.add(buttonHide);
        panelButtons.add(buttonStop);

        getContentPane().setLayout(new BorderLayout());
        getContentPane().add(labelProgress, BorderLayout.NORTH);
        getContentPane().add(pgProgress, BorderLayout.CENTER);
        getContentPane().add(panelButtons, BorderLayout.SOUTH);

        pgProgress.setValue(0);

        buttonHide.addActionListener(this);
        buttonStop.addActionListener(this);

        validate();
        setVisible(true);
        timerUpdate.start();
    }

    public void actionPerformed(ActionEvent e) {
        Object buttonSource = e.getSource();
        if (buttonSource == timerUpdate) {
            Runnable doGUIChange = new Runnable() {
                public void run() {
                    labelProgress.setText(strCurrentStatus);
                    pgProgress.setValue(intCurrentValue);
                }
            };
            SwingUtilities.invokeLater(doGUIChange);
        } else if (buttonSource == buttonHide) {
            setVisible(false);
        } else if (buttonSource == buttonStop) {
            bStop = true;
        }
    }

    public void set(String strProgress, int intValue) {
        strCurrentStatus = strProgress;
        if (intValue > Constants.PROGRESS_BAR_MAX) {
            intCurrentValue = Constants.PROGRESS_BAR_MAX;
        } else {
            intCurrentValue = intValue;
        }
    }

    public void increment(String strProgress) throws StopException {
        if (bStop) {
            throw new StopException();
        }
        strCurrentStatus = strProgress;
        if (intCurrentValue < Constants.PROGRESS_BAR_MAX) {
            intCurrentValue++;
        }
    }

    public void updateStatus(String strStatus) throws StopException {
        if (bStop) {
            throw new StopException();
        }
        strCurrentStatus = strStatus;
    }

    public void close() {
        timerUpdate.stop();
        setVisible(false);
        dispose();
    }
}//Progress