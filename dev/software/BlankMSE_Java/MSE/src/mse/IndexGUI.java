//package com.asidua.mse;

import java.awt.AWTEvent;
import java.awt.BorderLayout;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;

public class IndexGUI extends JFrame implements ActionListener, MouseListener {
    private static final int MIN_WIDTH = 600;
    private static final int MIN_HEIGHT = 600;

    Options options;
    SearchGUI gui;

    private JPanel panelTop = new JPanel();
    private JPanel panelButtons = new JPanel();

    JLabel labelFind = new JLabel("Go to");
    JTextField tfFind = new JTextField(8);
    private JTable tWords;
    JScrollPane spWords;

    JButton buttonCopy = new JButton("Copy");
    JButton buttonOK = new JButton("OK");
    JButton buttonCancel = new JButton("Cancel");

    public IndexGUI(SearchGUI guiIn, Options optionsHandle) {
        options = optionsHandle;
        gui = guiIn;

        //add window listener
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
                setVisible(false);
                dispose();
            }
        });
        enableEvents(AWTEvent.WINDOW_EVENT_MASK);

        init();

        tfFind.addActionListener(this);
        buttonCopy.addActionListener(this);
        buttonOK.addActionListener(this);
        buttonCancel.addActionListener(this);
        ComponentHandler ch = new ComponentHandler(this, MIN_WIDTH, MIN_HEIGHT);
        addComponentListener(ch);
    }//IndexGUI

    public void actionPerformed(ActionEvent e) {
        Object buttonSource = e.getSource();
        if (buttonSource == buttonCopy) {
            StringBuffer sbSelection = new StringBuffer();
            int[] iaSelection = tWords.getSelectedRows();
            if (iaSelection.length < 10000) {
                for (int x = 0; x < iaSelection.length; x++) {
                    sbSelection.append(((SortedWordsTableModel)tWords.
                        getModel()).getValueAt(iaSelection[x], 1) + " ");
                }
                Clipboard cbSelection =
                    getToolkit().getSystemClipboard();
                StringSelection ssClip =
                    new StringSelection(sbSelection.toString());
                cbSelection.setContents(ssClip, ssClip);
            } else {
                new Alert("Error", "Selection is too large for clipboard");
            }
        } else if (buttonSource == buttonOK) {
            setVisible(false);
            dispose();
        } else if (buttonSource == buttonCancel) {
            setVisible(false);
            dispose();
        }
    }

    public void mouseClicked(MouseEvent e) {
        if (e.getClickCount() == 2) {
            gui.tfSearchString.setText((String)tWords.
                getValueAt(tWords.getSelectedRow(), 1));
            int intSelectedColumn = tWords.getSelectedColumn();
            //there are 3 non-auth cols
            if (intSelectedColumn < Constants.BIBLE_POS + 3) {
                gui.toggleCheckBoxes(true);
            } else {
                gui.toggleCheckBoxes(false);
                gui.cbaAuths[intSelectedColumn - 3].setSelected(true);
            }
            gui.rbPhrase.setSelected(true);
            Progress progressSearch = new Progress("Searching ...",
                Constants.PROGRESS_BAR_MAX);
            Thread t = new Thread(new VolumeSearch(gui, progressSearch));
            gui.enableButtons(false);
            t.start();
        }
    }

    //not used but required for MouseListener
    public void mouseExited(MouseEvent e) {
    }
    public void mouseEntered(MouseEvent e) {
    }
    public void mouseReleased(MouseEvent e) {
    }
    public void mousePressed(MouseEvent e) {
    }

    private void init() {
        setTitle(" Ministry Search Engine - Indexes");
        ImageIcon image = new ImageIcon("images/books.gif");
        setIconImage(image.getImage());

        getContentPane().setLayout(new BorderLayout());

        panelTop.setLayout(new GridBagLayout());
        panelButtons.setLayout(new GridBagLayout());

        //index
        panelTop.add(labelFind, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0,
            GridBagConstraints.WEST, GridBagConstraints.NONE,
            new Insets(5, 5, 5, 5), 0, 0));
        panelTop.add(tfFind, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0,
            GridBagConstraints.WEST, GridBagConstraints.NONE,
            new Insets(5, 5, 5, 5), 0, 0));

        KeyListener klFind = new KeyAdapter() {
            public void keyReleased(KeyEvent e) {
                String strFind = tfFind.getText();
                int intIndex =
                    ((SortedWordsTableModel)tWords.getModel()).find(strFind);
                if (intIndex + 30 > tWords.getRowCount()) {
                    tWords.changeSelection(tWords.getRowCount(), 0,
                        false, false);
                } else {
                    tWords.changeSelection(intIndex + 30, 0, false, false);
                }
                tWords.changeSelection(intIndex, 0, false, false);
            }
        };
        tfFind.addKeyListener(klFind);

        //words
        SortedWordsTableModel swtmSortedWords = new SortedWordsTableModel();
        tWords = new JTable(swtmSortedWords);
        spWords = new JScrollPane(tWords);
        tWords.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
        tWords.getColumnModel().getColumn(1).setPreferredWidth(200);

        swtmSortedWords.addMouseListener(tWords);
        tWords.addMouseListener(this);

        //buttons
        panelButtons.add(buttonCopy,
            new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0,
            GridBagConstraints.CENTER, GridBagConstraints.NONE,
            new Insets(5, 5, 5, 5), 0, 0));
        panelButtons.add(buttonOK,
            new GridBagConstraints(2, 0, 1, 1, 0.0, 0.0,
            GridBagConstraints.CENTER, GridBagConstraints.NONE,
            new Insets(5, 5, 5, 5), 0, 0));
        panelButtons.add(buttonCancel,
            new GridBagConstraints(3, 0, 1, 1, 0.0, 0.0,
            GridBagConstraints.CENTER, GridBagConstraints.NONE,
            new Insets(5, 5, 5, 5), 0, 0));

        getContentPane().add(panelTop, BorderLayout.NORTH);
        getContentPane().add(spWords, BorderLayout.CENTER);
        getContentPane().add(panelButtons, BorderLayout.SOUTH);
        validate();
    }//init
}//IndexGUI

