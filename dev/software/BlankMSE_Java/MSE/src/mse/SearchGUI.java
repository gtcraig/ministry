//package com.asidua.mse;

import java.awt.AWTEvent;
import java.awt.BorderLayout;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;

public class SearchGUI extends JFrame implements ActionListener, KeyListener {
    private static final int MIN_WIDTH = 570;
    private static final int MIN_HEIGHT = 170;

    Options options;
    Index index;
    Log log;

    JCheckBox[] cbToBeSearched = new JCheckBox[Constants.MAX_AUTH_POS + 1];

    JMenuBar mbSearch = new JMenuBar();

    JMenu mFile = new JMenu("File");
    JMenuItem miIndexes = new JMenuItem("Indexes");
    JMenuItem miPrev = new JMenuItem("Previous Search");
    JMenuItem miOptions = new JMenuItem("Options");
    JMenuItem miExit = new JMenuItem("Exit");

    JMenu mBooks = new JMenu("Books");
    JMenuItem[] miaAuths = new JMenuItem[Constants.MAX_AUTH_POS + 2]; //+2 to include tunes

    JMenu mSearchType = new JMenu("Search Type");
    ButtonGroup bgSearchType = new ButtonGroup();
    JRadioButton rbPhrase = new JRadioButton("Phrase");
    JRadioButton rbSentence = new JRadioButton("Sentence contains words");
    JRadioButton rbParagraph = new JRadioButton("Paragraph contains words");
    JRadioButton rbPage = new JRadioButton("Page contains words");

    JMenu mMaps = new JMenu("Maps");
    JMenuItem miPalestineN = new JMenuItem("Palestine - North");
    JMenuItem miPalestineSW = new JMenuItem("Palestine - South West");
    JMenuItem miPalestineSE = new JMenuItem("Palestine - South East");
    JMenuItem miMedNW = new JMenuItem("Mediterranean - North West");
    JMenuItem miMedNE = new JMenuItem("Mediterranean - North East");
    JMenuItem miMedSW = new JMenuItem("Mediterranean - South West");
    JMenuItem miMedSE = new JMenuItem("Mediterranean - South East");

    JMenu mHelp = new JMenu("Help");
    JMenuItem miHelp = new JMenuItem("Search Engine Help");
    JMenuItem miTech = new JMenuItem("Technical Support");
    JMenuItem miLog = new JMenuItem("View Log File");
    JMenuItem miMemory = new JMenuItem("View Memory Usage");
    JMenuItem miAbout = new JMenuItem("About Search Engine");

    JPanel panelButtons = new JPanel();
    JTextField tfSearchString = new JTextField(25);
    JButton buttonSearch = new JButton("Search");
    JButton buttonRefine = new JButton("Refine");

    JPanel panelAuths1 = new JPanel();
    JPanel panelAuths2 = new JPanel();

    JCheckBox[] cbaAuths = new JCheckBox[Constants.MAX_AUTH_POS + 1];
    JButton buttonAll = new JButton("All");

    public SearchGUI() {
        //add window listener
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
	            System.exit(0);
            }
        });
        enableEvents(AWTEvent.WINDOW_EVENT_MASK);

        cbaAuths[Constants.BIBLE_POS] = new JCheckBox("Bible");
        cbaAuths[Constants.JND_POS] = new JCheckBox("JND");
        cbaAuths[Constants.JBS_POS] = new JCheckBox("JBS");
        cbaAuths[Constants.CHM_POS] = new JCheckBox("CHM");
        cbaAuths[Constants.FER_POS] = new JCheckBox("FER");
        cbaAuths[Constants.CAC_POS] = new JCheckBox("CAC");
        cbaAuths[Constants.JT_POS] = new JCheckBox("JT");
        cbaAuths[Constants.GRC_POS] = new JCheckBox("GRC");
        cbaAuths[Constants.AJG_POS] = new JCheckBox("AJG");
        cbaAuths[Constants.SMC_POS] = new JCheckBox("SMC");
        cbaAuths[Constants.MISC_POS] = new JCheckBox("Misc.");
        cbaAuths[Constants.HYMNS_POS] = new JCheckBox("Hymns");

        miaAuths[Constants.BIBLE_POS] = new JMenuItem("Bible");
        miaAuths[Constants.JND_POS] = new JMenuItem("J N Darby");
        miaAuths[Constants.JBS_POS] = new JMenuItem("J B Stoney");
        miaAuths[Constants.CHM_POS] = new JMenuItem("C H Mackintosh");
        miaAuths[Constants.FER_POS] = new JMenuItem("F E Raven");
        miaAuths[Constants.CAC_POS] = new JMenuItem("C A Coates");
        miaAuths[Constants.JT_POS] = new JMenuItem("J Taylor Snr.");
        miaAuths[Constants.GRC_POS] = new JMenuItem("G R Cowell");
        miaAuths[Constants.AJG_POS] = new JMenuItem("A J Gardiner");
        miaAuths[Constants.SMC_POS] = new JMenuItem("S McCallum");
        miaAuths[Constants.MISC_POS] = new JMenuItem("Various Authors");
        miaAuths[Constants.HYMNS_POS] = new JMenuItem("Hymns");
        miaAuths[Constants.TUNES_POS] = new JMenuItem("Hymn Tunes");

        miIndexes.addActionListener(this);
        miPrev.addActionListener(this);
        miOptions.addActionListener(this);
        miExit.addActionListener(this);

        for (int x = 0; x <= Constants.MAX_AUTH_POS; x++) {
            miaAuths[x].addActionListener(this);
        }
        miaAuths[Constants.TUNES_POS].addActionListener(this);

        miPalestineN.addActionListener(this);
        miPalestineSW.addActionListener(this);
        miPalestineSE.addActionListener(this);
        miMedNW.addActionListener(this);
        miMedNE.addActionListener(this);
        miMedSW.addActionListener(this);
        miMedSE.addActionListener(this);

        miHelp.addActionListener(this);
        miTech.addActionListener(this);
        miLog.addActionListener(this);
        miMemory.addActionListener(this);
        miAbout.addActionListener(this);

        buttonSearch.addActionListener(this);
        buttonRefine.addActionListener(this);
        buttonAll.addActionListener(this);

        ComponentHandler ch = new ComponentHandler(this, MIN_WIDTH, MIN_HEIGHT);
        addComponentListener(ch);

        init();
    }

    public void toggleCheckBoxes(boolean bOn) {
        if (bOn) {
            cbaAuths[Constants.BIBLE_POS].setSelected(true); //bible is always available
            for (int x = 1; x <= Constants.MAX_AUTH_POS; x++) {
                if (index.isAvailable(x)) {
                    cbaAuths[x].setSelected(true);
                }
            }
        } else {
            for (int x = 0; x <= Constants.MAX_AUTH_POS; x++) {
                cbaAuths[x].setSelected(false);
            }
        }
    }

    public void enableButtons(boolean bEnable) {
        tfSearchString.setEnabled(bEnable);
        buttonSearch.setEnabled(bEnable);
        buttonRefine.setEnabled(bEnable);
        mFile.setEnabled(bEnable);
        mBooks.setEnabled(bEnable);
        mSearchType.setEnabled(bEnable);
        mMaps.setEnabled(bEnable);
        mHelp.setEnabled(bEnable);
        for (int x = 0; x <= Constants.MAX_AUTH_POS; x++) {
            cbaAuths[x].setEnabled(bEnable);
        }
        buttonAll.setEnabled(bEnable);
    }

    public void actionPerformed (ActionEvent e) {
        Object buttonSource = e.getSource();
        if (buttonSource == miIndexes) {
            IndexGUI indexGUI = new IndexGUI(this, options);
            indexGUI.validate();
            setVisible(false);
            setVisible(true);
            indexGUI.setVisible(true);
        } else if (buttonSource == miOptions) {
            OptionsGUI optionsGUI = new OptionsGUI(options);
            optionsGUI.validate();
            setVisible(false);
            setVisible(true);
            optionsGUI.setVisible(true);
        } else if (buttonSource == miaAuths[Constants.BIBLE_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "bible/books.htm");
        } else if (buttonSource == miaAuths[Constants.JND_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "jnd/jnd.htm");
        } else if (buttonSource == miaAuths[Constants.JBS_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "jbs/jbs.htm");
        } else if (buttonSource == miaAuths[Constants.CHM_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "chm/chm.htm");
        } else if (buttonSource == miaAuths[Constants.FER_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "fer/fer.htm");
        } else if (buttonSource == miaAuths[Constants.CAC_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "cac/cac.htm");
        } else if (buttonSource == miaAuths[Constants.JT_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "jt/jt.htm");
        } else if (buttonSource == miaAuths[Constants.GRC_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "grc/grc.htm");
        } else if (buttonSource == miaAuths[Constants.AJG_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "ajg/ajg.htm");
        } else if (buttonSource == miaAuths[Constants.SMC_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "smc/smc.htm");
        } else if (buttonSource == miaAuths[Constants.MISC_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "misc/misc.htm");
        } else if (buttonSource == miaAuths[Constants.HYMNS_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "hymns/hymns.htm");
        } else if (buttonSource == miaAuths[Constants.TUNES_POS]) {
            Utils.openPage(options.getDefaultBrowser(), "tunes/tunes.htm");
        } else if (buttonSource == miPrev) {
            File fResults = new File(Constants.RESULTS_FILE);
            if (fResults.exists()) {
                Utils.openPage(options.getDefaultBrowser(), Constants.RESULTS_FILE);
            } else {
                new Alert("Information", "No searches have been executed since the application was started");
            }
        } else if (buttonSource == miExit) {
            dispose();
            System.exit(0);
        } else if (buttonSource == miPalestineN) {
            Utils.openPage(options.getDefaultBrowser(), "images/palestine_n.jpg");
        } else if (buttonSource == miPalestineSW) {
            Utils.openPage(options.getDefaultBrowser(), "images/palestine_sw.jpg");
        } else if (buttonSource == miPalestineSE) {
            Utils.openPage(options.getDefaultBrowser(), "images/palestine_se.jpg");
        } else if (buttonSource == miMedNW) {
            Utils.openPage(options.getDefaultBrowser(), "images/med_nw.jpg");
        } else if (buttonSource == miMedNE) {
            Utils.openPage(options.getDefaultBrowser(), "images/med_ne.jpg");
        } else if (buttonSource == miMedSW) {
            Utils.openPage(options.getDefaultBrowser(), "images/med_sw.jpg");
        } else if (buttonSource == miMedSE) {
            Utils.openPage(options.getDefaultBrowser(), "images/med_se.jpg");
        } else if (buttonSource == miHelp) {
            Utils.openPage(options.getDefaultBrowser(), "htm/help.htm");
        } else if (buttonSource == miTech) {
            Utils.openPage(options.getDefaultBrowser(), "htm/techsupport.htm");
        } else if (buttonSource == miLog) {
            Utils.openPage(options.getDefaultBrowser(), Constants.LOG_FILE);
        } else if (buttonSource == miMemory) {
            setVisible(false);
            setVisible(true);
            new MemoryGUI();
        } else if (buttonSource == miAbout) {
            setVisible(false);
            setVisible(true);
            new Splash(true);
        } else if (buttonSource == buttonAll) {
            boolean bNoneSelected = true;
            for (int x = 0; x <= Constants.MAX_AUTH_POS; x++) {
                if (cbaAuths[x].isSelected() == true) {
                    bNoneSelected = false;
                }
            }
            if (bNoneSelected) {
                toggleCheckBoxes(true);
            } else {
                toggleCheckBoxes(false);
            }
        } else if (buttonSource == buttonSearch) {
            doSearch();
        } else if (buttonSource == buttonRefine) {
            if (tfSearchString.getText().indexOf("*") != -1) {
                new Alert("Error", "Refine searches cannot contain wildcards");
            } else if (tfSearchString.getText().equals("")) {
                new Alert("Error", "Invalid search string");
            } else {
                Progress progressSearch = new Progress("Searching ...", Constants.PROGRESS_BAR_MAX);
                Thread t = new Thread(new ResultsSearch(this, progressSearch));
                enableButtons(false);
                t.start();
            }
        } else {
            new Alert("Error", "Invalid action");
        }
    }//actionPerformed

    public void init() {
        Splash splash = null;

        setDefaultCloseOperation(3);
        setTitle(" Ministry Search Engine");
        ImageIcon image = new ImageIcon("images/books.gif");
        setIconImage(image.getImage());

        try {
            //restore settings
            options = Options.getOptions();
            log = Log.getLog();
            options.setDebugOn(options.getDebugOn()); //note status in log file

            if (options.getSplashWindow()) {
                splash = new Splash(false);
            }
            index = Index.getIndex();

            tfSearchString.setText(options.getSearchString());
            String strSearchType = options.getSearchType();
            if (strSearchType.equals("Phrase")) {
                rbPhrase.setSelected(true);
            } else if (strSearchType.equals("Sentence")) {
                rbSentence.setSelected(true);
            } else if (strSearchType.equals("Paragraph")) {
                rbParagraph.setSelected(true);
            } else if (strSearchType.equals("Page")) {
                rbPage.setSelected(true);
            }

            for (int x = 0; x <= Constants.MAX_AUTH_POS; x++) {
                cbaAuths[x].setSelected(options.getAuthSelected(x));
                cbToBeSearched[x] = cbaAuths[x];
            }
            panelButtons.add(tfSearchString);
            panelButtons.add(buttonSearch);
            panelButtons.add(buttonRefine);
            buttonRefine.setEnabled(true);

            bgSearchType.add(rbPhrase);
            bgSearchType.add(rbSentence);
            bgSearchType.add(rbParagraph);
            bgSearchType.add(rbPage);

            mFile.add(miIndexes);
            mFile.add(miPrev);
            mFile.add(miOptions);
            mFile.addSeparator();
            mFile.add(miExit);
            mbSearch.add(mFile);

            mBooks.add(miaAuths[Constants.BIBLE_POS]);
            panelAuths2.add(cbaAuths[Constants.BIBLE_POS]); //bible is always available
            for (int x = 1; x <= Constants.MAX_AUTH_POS; x++) {
                if (index.isAvailable(x)) {
                    if (x < Constants.MAX_AUTH_POS) {
                        panelAuths1.add(cbaAuths[x]);
                    } else {
                        panelAuths2.add(cbaAuths[x]);
                    }
                    mBooks.add(miaAuths[x]);
                } else {
                    cbaAuths[x].setSelected(false);
                }
            }
            File fTunes = new File("tunes");
            if (fTunes.isDirectory()) {
                mBooks.add(miaAuths[Constants.TUNES_POS]);
            }
            mbSearch.add(mBooks);
            panelAuths2.add(buttonAll);

            mSearchType.add(rbPhrase);
            mSearchType.add(rbSentence);
            mSearchType.add(rbParagraph);
            mSearchType.add(rbPage);
            mbSearch.add(mSearchType);

            mMaps.add(miPalestineN);
            mMaps.add(miPalestineSW);
            mMaps.add(miPalestineSE);
            mMaps.addSeparator();
            mMaps.add(miMedNW);
            mMaps.add(miMedNE);
            mMaps.add(miMedSW);
            mMaps.add(miMedSE);
            mbSearch.add(mMaps);

            mHelp.add(miHelp);
            mHelp.add(miTech);
            mHelp.add(miLog);
            mHelp.add(miMemory);
            mHelp.addSeparator();
            mHelp.add(miAbout);
            mbSearch.add(mHelp);

            setJMenuBar(mbSearch);

            getContentPane().setLayout(new BorderLayout());
            getContentPane().add(panelButtons, BorderLayout.NORTH);
            getContentPane().add(panelAuths1, BorderLayout.CENTER);
            getContentPane().add(panelAuths2, BorderLayout.SOUTH);

            if (options.getSplashWindow()) {
                splash.close();
            }

            validate();
            setVisible(true);
        } catch(Exception e) {
            log.write(Constants.LOG_HIGH, "<br>Error in search engine: " + e);
        }

        addKeyListener(this);
    }

    public void doSearch() {
        if ((tfSearchString.getText().indexOf("*") != -1) && (tfSearchString.getText().indexOf(" ") != -1)) {
            new Alert("Error", "Wildcard searches must only have one word");
        } else if (tfSearchString.getText().equals("")) {
            new Alert("Error", "Invalid search string");
        } else {
            int intAuthCount = 0;
            for (int intAuth = 0; intAuth < Constants.MAX_AUTH_POS + 1; intAuth++) {
                if (cbToBeSearched[intAuth].isSelected()) {
                    intAuthCount++;
                }
            }
            if (intAuthCount > 0) {
                Progress progressSearch = new Progress("Searching ...", Constants.PROGRESS_BAR_MAX);
                Thread t = new Thread(new VolumeSearch(this, progressSearch));
                enableButtons(false);
                t.start();
            } else {
                new Alert("Error", "At least one checkbox must be ticked");
            }
        }
    }

    public void keyPressed(KeyEvent e) {
    }
    public void keyTyped(KeyEvent e) {
    }
    public void keyReleased(KeyEvent e) {
        int intKeyCode = e.getKeyCode();
        if (intKeyCode == 10) {
            doSearch();
        }
    }

    public void dispose() {
        File fResults = new File(Constants.RESULTS_FILE);
        if (fResults.exists()) {
            fResults.delete();
        }
        File fLog = new File(Constants.LOG_FILE);
        if (fLog.exists()) {
            fLog.delete();
        }
        super.dispose();
    }

    public static void main(String[] args) {
        
        // MJP Test !x 15/3/15
        System.out.println(File.separator);
        // JOptionPane.showMessageDialog(null, "Starting");
        
        JFrame frame = new SearchGUI();
    }
}//SearchGUI


