//package com.asidua.mse;

import java.awt.AWTEvent;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.net.URL;
import javax.swing.event.HyperlinkEvent;
import javax.swing.event.HyperlinkListener;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JEditorPane;
import javax.swing.JFrame;
import javax.swing.JScrollPane;

public class BrowserGUI extends JFrame
        implements ActionListener, HyperlinkListener  {
    private static final int MIN_WIDTH = 550;
    private static final int MIN_HEIGHT = 250;

    JEditorPane editorPane = new JEditorPane();
    JScrollPane editorScrollPane = new JScrollPane(editorPane);
    JButton buttonOK = new JButton("Close");

    String url = "";

    public BrowserGUI(String urlConstructor) {
        url = urlConstructor;

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
        editorPane.addHyperlinkListener(this);

        ComponentHandler ch = new ComponentHandler(this, MIN_WIDTH, MIN_HEIGHT);
        addComponentListener(ch);
    }//BrowserGUI

    public void actionPerformed(ActionEvent e) {
        Object buttonSource = e.getSource();
        if (buttonSource == buttonOK) {
            setVisible(false);
            dispose();
        }
    }

    public void hyperlinkUpdate(HyperlinkEvent e) {
        if (e.getEventType() == HyperlinkEvent.EventType.ACTIVATED) {
            JEditorPane pane = (JEditorPane) e.getSource();
            try {
                pane.setPage(e.getURL());
            } catch (Throwable t) {
                Log.getLog().write(Constants.LOG_HIGH,
                    "<br>Error opening link: " + t);
            }
        }
    }

    private void init() {
        setTitle(" Ministry Search Engine - Browser");
        ImageIcon image = new ImageIcon("images/books.gif");
        setIconImage(image.getImage());

        editorPane.setEditable(false);
        try {
            URL urlPage = new URL("file:///" +
                Constants.WORKING_DIR + "/" + url);
            editorPane.setPage(urlPage);
        } catch (Exception e) {
            new Alert("Error", "Failed to open internal browser");
            Log.getLog().write(Constants.LOG_HIGH,
                "<br>Failed to open internal browser: " + e);
        }

        getContentPane().setLayout(new BorderLayout());

        getContentPane().add(editorScrollPane, BorderLayout.CENTER);
        getContentPane().add(buttonOK, BorderLayout.SOUTH);
        validate();
    }//init
}//BrowserGUI