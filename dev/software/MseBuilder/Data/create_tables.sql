-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 24, 2018 at 02:20 PM
-- Server version: 5.6.21
-- PHP Version: 7.1.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `goodteaching_org_min`
--

-- --------------------------------------------------------

--
-- Table structure for table `mse_article`
--

DROP TABLE IF EXISTS `mse_article`;
CREATE TABLE IF NOT EXISTS `mse_article` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT '0',
  `page` smallint(6) NOT NULL DEFAULT '0',
  `article` varchar(255) DEFAULT NULL,
  `scriptures` varchar(255) DEFAULT NULL,
  `bypass` tinyint(4) DEFAULT NULL,
  `localrow` int(11) NOT NULL,
  PRIMARY KEY (`author`,`vol`,`page`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_author`
--

DROP TABLE IF EXISTS `mse_author`;
CREATE TABLE IF NOT EXISTS `mse_author` (
  `author` char(3) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `fullname` varchar(50) DEFAULT NULL,
  `orgname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`author`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_book`
--

DROP TABLE IF EXISTS `mse_bible_book`;
CREATE TABLE IF NOT EXISTS `mse_bible_book` (
  `bookid` int(11) NOT NULL DEFAULT '0',
  `bookname` varchar(255) DEFAULT NULL,
  `testament` char(2) DEFAULT NULL,
  `testbook` int(11) DEFAULT NULL,
  `no_of_chapters` int(11) NOT NULL,
  `singlechap` tinyint(4) DEFAULT NULL,
  `firstverse` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bookid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote`
--

DROP TABLE IF EXISTS `mse_bible_footnote`;
CREATE TABLE IF NOT EXISTS `mse_bible_footnote` (
  `footnoteid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verid` int(10) unsigned NOT NULL,
  `bookid` int(10) unsigned NOT NULL,
  `chapter` int(10) unsigned NOT NULL,
  `verse` int(10) unsigned NOT NULL,
  `symbol` char(1) NOT NULL,
  `text` varchar(2000) NOT NULL,
  PRIMARY KEY (`footnoteid`),
  UNIQUE KEY `FOOTNOTE` (`verid`,`bookid`,`chapter`,`verse`,`symbol`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Bible Footnotes' AUTO_INCREMENT=8818 ;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote_ref`
--

DROP TABLE IF EXISTS `mse_bible_footnote_ref`;
CREATE TABLE IF NOT EXISTS `mse_bible_footnote_ref` (
  `footnoteid` int(10) unsigned NOT NULL,
  `verid` int(10) unsigned NOT NULL,
  `bookid` int(10) unsigned NOT NULL,
  `chapter` int(10) unsigned NOT NULL,
  `verse` int(10) unsigned NOT NULL,
  `refid` int(10) unsigned NOT NULL DEFAULT '0',
  `phrase` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`footnoteid`,`verid`,`bookid`,`chapter`,`verse`,`refid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Bible Footnote References';

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote_xref`
--

DROP TABLE IF EXISTS `mse_bible_footnote_xref`;
CREATE TABLE IF NOT EXISTS `mse_bible_footnote_xref` (
  `footnoteid` int(10) unsigned NOT NULL,
  `verid` int(10) unsigned NOT NULL,
  `bookid` int(10) unsigned NOT NULL,
  `chapter` int(10) unsigned NOT NULL,
  `verse` int(10) unsigned NOT NULL,
  `xrefid` int(10) unsigned NOT NULL,
  `from_footnoteid` int(10) unsigned DEFAULT NULL,
  `phrase` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`footnoteid`,`verid`,`bookid`,`chapter`,`verse`,`xrefid`),
  KEY `tofootnote` (`from_footnoteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Bible Footnote Cross-references';

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_ref`
--

DROP TABLE IF EXISTS `mse_bible_ref`;
CREATE TABLE IF NOT EXISTS `mse_bible_ref` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT '0',
  `page` int(4) NOT NULL DEFAULT '0',
  `para` int(2) NOT NULL DEFAULT '0',
  `ref` int(11) NOT NULL DEFAULT '0',
  `article_page` int(11) NOT NULL DEFAULT '0',
  `article_primary` int(1) NOT NULL DEFAULT '0',
  `bookid` int(11) NOT NULL DEFAULT '0',
  `chapter` int(11) NOT NULL DEFAULT '0',
  `vstart` int(11) NOT NULL DEFAULT '0',
  `vend` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`author`,`vol`,`page`,`para`,`ref`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_ref_error`
--

DROP TABLE IF EXISTS `mse_bible_ref_error`;
CREATE TABLE IF NOT EXISTS `mse_bible_ref_error` (
  `author` varchar(10) NOT NULL,
  `vol` int(3) NOT NULL DEFAULT '0',
  `page` int(4) NOT NULL DEFAULT '0',
  `para` int(2) NOT NULL DEFAULT '0',
  `ref` int(11) NOT NULL DEFAULT '0',
  `error_code` char(1) DEFAULT NULL,
  `text` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`author`,`vol`,`page`,`para`,`ref`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_version`
--

DROP TABLE IF EXISTS `mse_bible_version`;
CREATE TABLE IF NOT EXISTS `mse_bible_version` (
  `verid` int(10) unsigned NOT NULL,
  `vercode` varchar(3) NOT NULL,
  `versionname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`verid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Bible Versions';

-- --------------------------------------------------------

--
-- Table structure for table `mse_collection`
--

DROP TABLE IF EXISTS `mse_collection`;
CREATE TABLE IF NOT EXISTS `mse_collection` (
  `collectionid` int(11) NOT NULL AUTO_INCREMENT,
  `collectionname` varchar(500) NOT NULL,
  PRIMARY KEY (`collectionid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Collections' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `mse_collection_article`
--

DROP TABLE IF EXISTS `mse_collection_article`;
CREATE TABLE IF NOT EXISTS `mse_collection_article` (
  `collectionid` int(11) NOT NULL,
  `articleno` smallint(6) NOT NULL,
  `author` varchar(10) NOT NULL,
  `vol` int(3) NOT NULL,
  `page` smallint(6) NOT NULL,
  `article` varchar(255) NOT NULL,
  PRIMARY KEY (`collectionid`,`articleno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Collection Articles';

-- --------------------------------------------------------

--
-- Table structure for table `mse_release_history`
--

DROP TABLE IF EXISTS `mse_release_history`;
CREATE TABLE IF NOT EXISTS `mse_release_history` (
  `release_no` varchar(10) NOT NULL DEFAULT '',
  `task_id` varchar(10) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  PRIMARY KEY (`release_no`,`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Release History';

-- --------------------------------------------------------

--
-- Table structure for table `mse_text`
--

DROP TABLE IF EXISTS `mse_text`;
CREATE TABLE IF NOT EXISTS `mse_text` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT '0',
  `page` int(4) NOT NULL DEFAULT '0',
  `para` int(2) NOT NULL DEFAULT '0',
  `article_page` int(4) NOT NULL DEFAULT '0',
  `inits` varchar(20) DEFAULT NULL,
  `text` longtext NOT NULL,
  `localrow` int(11) NOT NULL,
  `newPages` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`author`,`vol`,`page`,`para`),
  FULLTEXT KEY `text` (`text`),
  FULLTEXT KEY `text_2` (`text`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_volume`
--

DROP TABLE IF EXISTS `mse_volume`;
CREATE TABLE IF NOT EXISTS `mse_volume` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `localfile` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`author`,`vol`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 24, 2018 at 02:21 PM
-- Server version: 5.6.21
-- PHP Version: 7.1.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `goodteaching_org_min`
--

--
-- Dumping data for table `mse_author`
--

INSERT INTO `mse_author` (`author`, `name`, `fullname`, `orgname`) VALUES
('CAC', 'C. A. Coates', 'Charles Andrew Coates', 'Coates, Charles'),
('FER', 'F. E. Raven', 'Frederick Edward Raven', 'Raven, Frederick'),
('GRC', 'G. R. Cowell', 'Gerald Robert Cowell', 'Cowell, Gerald '),
('JBS', 'J. B. Stoney', 'James Butler Stoney', 'Stoney, James'),
('JND', 'J. N. Darby', 'John Nelson Darby', 'Darby, John'),
('JT', 'J. Taylor, Sr', 'James Taylor (Sr)', 'Taylor Sr, James'),
('VAR', 'Various', 'Various', 'Various'),
('AJG', 'A. J. Gardiner', 'Alfred John Gardiner', 'Gardiner, Alfred John'),
('CHM', 'C. H. Mackintosh', 'Charles Henry Mackintosh', 'Mackintosh, Charles Henry'),
('SMC', 'S. McCallum', 'Stanley McCallum', 'McCallum, Stanley'),
('JGB', 'J. G. Bellatt', 'John Gifford Bellett', 'Bellett, John Gifford');

--
-- Dumping data for table `mse_bible_book`
--

INSERT INTO `mse_bible_book` (`bookid`, `bookname`, `testament`, `testbook`, `no_of_chapters`, `singlechap`, `firstverse`) VALUES
(1, 'Genesis', 'OT', 1, 50, NULL, 'In the beginning God created the heavens and the earth.'),
(2, 'Exodus', 'OT', 2, 40, NULL, 'And these are the names of the sons of Israel who had come into Egypt; with Jacob had they come, each with his household:'),
(3, 'Leviticus', 'OT', 3, 27, NULL, 'And Jehovah called to Moses and spoke to him out of the tent of meeting, saying,'),
(4, 'Numbers', 'OT', 4, 36, NULL, 'And Jehovah spoke to Moses in the wilderness of Sinai in the tent of meeting, on the first of the second month, in the second year after their departure from the land of Egypt, saying,'),
(5, 'Deuteronomy', 'OT', 5, 34, NULL, 'These are the words which Moses spoke to all Israel on this side the Jordan, in the wilderness, in the plain, opposite to Suph, between Paran and Tophel, Laban, Hazeroth, and Dizahab.'),
(6, 'Joshua', 'OT', 6, 24, NULL, 'And it came to pass after the death of Moses the servant of Jehovah, that Jehovah spoke to Joshua the son of Nun, Moses'' attendant, saying,'),
(7, 'Judges', 'OT', 7, 21, NULL, 'After the death of Joshua the people of Israel inquired of the LORD, "Who shall go up first for us against the Canaanites, to fight against them?"'),
(8, 'Ruth', 'OT', 8, 4, NULL, 'And it came to pass in the days when the judges ruled, that there was a famine in the land. And a certain man went from Bethlehem-Judah, to sojourn in the country of Moab, he, and his wife, and his two sons.'),
(9, '1 Samuel', 'OT', 9, 31, NULL, 'And there was a certain man of Ramathaim-zophim, of mount Ephraim, and his name was Elkanah, the son of Jeroham, the son of Elihu, the son of Tohu, the son of Zuph, an Ephrathite.'),
(10, '2 Samuel', 'OT', 10, 24, NULL, 'And it came to pass after the death of Saul, when David had returned from the slaughter of the Amalekites, that David abode two days in Ziklag.'),
(11, '1 Kings', 'OT', 11, 22, NULL, 'And king David was old [and] advanced in age; and they covered him with clothes, but he obtained no warmth.'),
(12, '2 Kings', 'OT', 12, 25, NULL, 'And Moab rebelled against Israel after the death of Ahab.'),
(13, '1 Chronicles', 'OT', 13, 29, NULL, 'Adam, Seth, Enosh,'),
(14, '2 Chronicles', 'OT', 14, 36, NULL, 'And Solomon the son of David was strengthened in his kingdom, and Jehovah his God was with him and magnified him exceedingly.'),
(15, 'Ezra', 'OT', 15, 10, NULL, 'And in the first year of Cyrus king of Persia, that the word of Jehovah by the mouth of Jeremiah might be accomplished, Jehovah stirred up the spirit of Cyrus king of Persia, and he made a proclamation throughout his kingdom, and also in writing, saying,'),
(16, 'Nehemiah', 'OT', 16, 13, NULL, 'The words of Nehemiah the son of Hachaliah. And it came to pass in the month Chislev, in the twentieth year, as I was in Shushan the fortress,'),
(17, 'Esther', 'OT', 17, 10, NULL, 'And it came to pass in the days of Ahasuerus (that is, the Ahasuerus that reigned from India even to Ethiopia, over a hundred and twenty-seven provinces),'),
(18, 'Job', 'OT', 18, 42, NULL, 'There was a man in the land of Uz whose name was Job; and this man was perfect and upright, and one that feared God and abstained from evil.'),
(19, 'Psalm', 'OT', 19, 150, NULL, 'Blessed is the man that walketh not in the counsel of the wicked, and standeth not in the way of sinners, and sitteth not in the seat of scorners;'),
(20, 'Proverbs', 'OT', 20, 31, NULL, 'Proverbs of Solomon, son of David, king of Israel:'),
(21, 'Ecclesiastes', 'OT', 21, 12, NULL, 'The words of the Preacher, the son of David, king in Jerusalem.'),
(22, 'Song of Songs', 'OT', 22, 8, NULL, 'The song of songs, which is Solomon''s.'),
(23, 'Isaiah', 'OT', 23, 66, NULL, 'The vision of Isaiah the son of Amos, which he saw concerning Judah and Jerusalem in the days of Uzziah, Jotham, Ahaz, Hezekiah, kings of Judah.'),
(24, 'Jeremiah', 'OT', 24, 52, NULL, 'The words of Jeremiah the son of Hilkijah, of the priests that were in Anathoth in the land of Benjamin:'),
(25, 'Lamentations', 'OT', 25, 5, NULL, 'How doth the city sit solitary [that] was full of people! She that was great among the nations is become as a widow; the princess among the provinces is become tributary!'),
(26, 'Ezekiel', 'OT', 26, 48, NULL, 'Now it came to pass in the thirtieth year, in the fourth [month], on the fifth of the month, as I was among the captives by the river Chebar, the heavens were opened, and I saw visions of God.'),
(27, 'Daniel', 'OT', 27, 12, NULL, 'In the third year of the reign of Jehoiakim king of Judah came Nebuchadnezzar king of Babylon unto Jerusalem, and besieged it.'),
(28, 'Hosea', 'OT', 28, 14, NULL, 'The word of Jehovah that came unto Hosea, the son of Beeri, in the days of Uzziah, Jotham, Ahaz, Hezekiah, kings of Judah, and in the days of Jeroboam the son of Joash, king of Israel.'),
(29, 'Joel', 'OT', 29, 3, NULL, 'The word of Jehovah that came to Joel the son of Pethuel.'),
(30, 'Amos', 'OT', 30, 9, NULL, 'The words of Amos, who was among the herdmen of Tekoa, which he saw concerning Israel in the days of Uzziah king of Judah, and in the days of Jeroboam the son of Joash, king of Israel, two years before the earthquake.'),
(31, 'Obadiah', 'OT', 31, 1, 1, 'The vision of Obadiah. Thus saith the Lord Jehovah concerning Edom: We have heard a report from Jehovah, and an ambassador is sent among the nations. Arise ye, and let us rise up against her in battle.'),
(32, 'Jonah', 'OT', 32, 4, NULL, 'And the word of Jehovah came unto Jonah the son of Amittai, saying,'),
(33, 'Micah', 'OT', 33, 7, NULL, 'The word of Jehovah that came to Micah the Morasthite in the days of Jotham, Ahaz, [and] Hezekiah, kings of Judah, which he saw concerning Samaria and Jerusalem.'),
(34, 'Nahum', 'OT', 34, 3, NULL, 'The burden of Nineveh. The book of the vision of Nahum the Elkoshite.'),
(35, 'Habakkuk', 'OT', 35, 3, NULL, 'The burden which Habakkuk the prophet did see.'),
(36, 'Zephaniah', 'OT', 36, 3, NULL, 'The word of Jehovah that came unto Zephaniah the son of Cushi, the son of Gedaliah, the son of Amariah, the son of Hezekiah, in the days of Josiah the son of Amon, king of Judah.'),
(37, 'Haggai', 'OT', 37, 2, NULL, 'In the second year of Darius the king, in the sixth month, on the first day of the month, came the word of Jehovah by the prophet Haggai unto Zerubbabel the son of Shealtiel, governor of Judah, and to Joshua the son of Jehozadak, the high priest, saying,'),
(38, 'Zechariah', 'OT', 38, 14, NULL, 'In the eighth month, in the second year of Darius, came the word of Jehovah unto Zechariah the prophet, the son of Berechiah, the son of Iddo, saying,'),
(39, 'Malachi', 'OT', 39, 4, NULL, 'The burden of the word of Jehovah to Israel by Malachi.'),
(40, 'Matthew', 'NT', 1, 28, NULL, 'Book of the generation of Jesus Christ, Son of David, Son of Abraham.'),
(41, 'Mark', 'NT', 2, 16, NULL, 'Beginning of the glad tidings of Jesus Christ, Son of God;'),
(42, 'Luke', 'NT', 3, 24, NULL, 'Forasmuch as many have undertaken to draw up a relation concerning the matters fully believed among us,'),
(43, 'John', 'NT', 3, 21, NULL, 'In [the] beginning was the Word, and the Word was with God, and the Word was God.'),
(44, 'Acts', 'NT', 4, 28, NULL, 'I composed the first discourse, O Theophilus, concerning all things which Jesus began both to do and to teach,'),
(45, 'Romans', 'NT', 5, 16, NULL, 'Paul, bondman of Jesus Christ, [a] called apostle, separated to God''s glad tidings,'),
(46, '1 Corinthians', 'NT', 6, 16, NULL, 'Paul, [a] called apostle of Jesus Christ, by God''s will, and Sosthenes the brother,'),
(47, '2 Corinthians', 'NT', 7, 13, NULL, 'Paul, apostle of Jesus Christ by God''s will, and the brother Timotheus, to the assembly of God which is in Corinth, with all the saints who are in the whole of Achaia.'),
(48, 'Galatians', 'NT', 8, 6, NULL, 'Paul, apostle, not from men nor through man, but through Jesus Christ, and God [the] Father who raised him from among [the] dead,'),
(49, 'Ephesians', 'NT', 9, 6, NULL, 'Paul, apostle of Jesus Christ by God''s will, to the saints and faithful in Christ Jesus who are at Ephesus.'),
(50, 'Philippians', 'NT', 10, 4, NULL, 'Paul and Timotheus, bondmen of Jesus Christ, to all the saints in Christ Jesus who are in Philippi, with [the] overseers and ministers;'),
(51, 'Colossians', 'NT', 11, 4, NULL, 'Paul, apostle of Christ Jesus, by God''s will, and Timotheus the brother,'),
(52, '1 Thessalonians', 'NT', 12, 5, NULL, 'Paul and Silvanus and Timotheus to the assembly of Thessalonians in God [the] Father and [the] Lord Jesus Christ. Grace to you and peace.'),
(53, '2 Thessalonians', 'NT', 13, 3, NULL, 'Paul and Silvanus and Timotheus to the assembly of Thessalonians in God our Father and [the] Lord Jesus Christ.'),
(54, '1 Timothy', 'NT', 14, 6, NULL, 'Paul, apostle of Jesus Christ, according to [the] command of God our Saviour, and of Christ Jesus our hope,'),
(55, '2 Timothy', 'NT', 15, 4, NULL, 'Paul, apostle of Jesus Christ by God''s will, according to promise of life, the [life] which [is] in Christ Jesus,'),
(56, 'Titus', 'NT', 16, 3, NULL, 'Paul, bondman of God, and apostle of Jesus Christ according to [the] faith of God''s elect, and knowledge of [the] truth which [is] according to piety;'),
(57, 'Philemon', 'NT', 17, 1, 1, 'Paul, prisoner of Christ Jesus, and Timotheus the brother, to Philemon the beloved and our fellow-workman,'),
(58, 'Hebrews', 'NT', 18, 13, NULL, 'God having spoken in many parts and in many ways formerly to the fathers in the prophets,'),
(59, 'James', 'NT', 19, 5, NULL, 'James, bondman of God and of [the] Lord Jesus Christ, to the twelve tribes which [are] in the dispersion, greeting.'),
(60, '1 Peter', 'NT', 20, 5, NULL, 'Peter, apostle of Jesus Christ, to [the] sojourners of [the] dispersion of Pontus, Galatia, Cappadocia, Asia, and Bithynia,'),
(61, '2 Peter', 'NT', 21, 3, NULL, 'Simon Peter, bondman and apostle of Jesus Christ, to them that have received like precious faith with us through [the] righteousness of our God and Saviour Jesus Christ:'),
(62, '1 John', 'NT', 22, 5, NULL, 'That which was from [the] beginning, that which we have heard, which we have seen with our eyes; that which we contemplated, and our hands handled, concerning the word of life;'),
(63, '2 John', 'NT', 23, 1, 1, 'The elder to [the] elect lady and her children, whom *I* love in truth, and not *I* only but also all who have known the truth,'),
(64, '3 John', 'NT', 24, 1, 1, 'The elder to the beloved Gaius, whom I love in truth.'),
(65, 'Jude', 'NT', 25, 1, 1, 'Jude, bondman of Jesus Christ, and brother of James, to the called ones beloved in God [the] Father and preserved in Jesus Christ:'),
(66, 'Revelation', 'NT', 26, 22, NULL, 'Revelation of Jesus Christ, which God gave to him, to shew to his bondmen what must shortly take place; and he signified [it], sending by his angel, to his bondman John,');

--
-- Dumping data for table `mse_collection`
--

INSERT INTO `mse_collection` (`collectionid`, `collectionname`) VALUES
(1, 'MWB to GHSP');

--
-- Dumping data for table `mse_collection_article`
--

INSERT INTO `mse_collection_article` (`collectionid`, `articleno`, `author`, `vol`, `page`, `article`) VALUES
(1, 1, 'JND', 7, 139, 'THE SUFFERINGS OF CHRIST'),
(1, 2, 'JND', 7, 238, '"A MAN IN CHRIST"'),
(1, 3, 'JND', 7, 266, 'THE RIGHTEOUSNESS OF GOD'),
(1, 4, 'JND', 10, 147, 'DIVINE RIGHTEOUSNESS'),
(1, 5, 'JND', 23, 127, 'WHAT DO I LEARN FROM SCRIPTURE?'),
(1, 6, 'JND', 23, 134, 'EITHER IN ADAM OR IN CHRIST?'),
(1, 7, 'JND', 23, 347, 'THOUGHTS ON ROMANS, COLOSSIANS, EPHESIANS'),
(1, 8, 'JND', 29, 60, 'HAVE WE A REVELATION FROM GOD?'),
(1, 9, 'JND', 14, 176, 'THE CLAIMS OF THE CHURCH OF ENGLAND CONSIDERED; BEING THE CLOSE OF A CORRESPONDENCE BETWEEN THE REVEREND JAMES KELLY, OF STILLOGAN, IRELAND, AND J. N. DARBY'),
(1, 10, 'JND', 14, 301, 'ON ECCLESIASTICAL INDEPENDENCY'),
(1, 11, 'JND', 14, 1, 'ON GIFTS AND OFFICES IN THE CHURCH'),
(1, 12, 'JND', 5, 256, 'SEVEN LECTURES ON THE PROPHETICAL ADDRESSES TO THE SEVEN CHURCHES'),
(1, 13, 'JND', 10, 257, 'IS THE COMING OF CHRIST FOR HIS SAINTS THE PROPER HOPE OF THE CHURCH?'),
(1, 14, 'JND', 21, 142, '"BEFORE ABRAHAM WAS, I AM"'),
(1, 15, 'JND', 17, 1, 'PRACTICAL REFLECTIONS ON THE PSALMS -- FIRST BOOK -- PSALM 1-41'),
(1, 16, 'JND', 17, 86, 'PRACTICAL REFLECTIONS ON THE PSALMS -- SECOND BOOK -- PSALM 42-72'),
(1, 17, 'JND', 17, 124, 'PRACTICAL REFLECTIONS ON THE PSALMS -- THIRD BOOK -- PSALM 73-89'),
(1, 18, 'JND', 17, 149, 'PRACTICAL REFLECTIONS ON THE PSALMS -- FOURTH BOOK -- PSALM 90-106'),
(1, 19, 'JND', 17, 164, 'PRACTICAL REFLECTIONS ON THE PSALMS -- FIFTH BOOK -- PSALMS 107-150'),
(1, 20, 'JGB', 1, 2, 'THE MORAL GLORY OF THE LORD JESUS CHRIST'),
(1, 21, 'JBS', 1, 325, 'ACQUAINTANCE WITH CHRIST RISEN'),
(1, 22, 'JBS', 1, 338, 'ACQUAINTANCE WITH CHRIST IN GLORY'),
(1, 23, 'JBS', 1, 349, 'ACQUAINTANCE WITH CHRIST -- HIS PATHWAY ON EARTH'),
(1, 24, 'JBS', 1, 361, 'ACQUAINTANCE WITH CHRIST IN THE ASSEMBLY'),
(1, 25, 'JBS', 1, 372, 'ACQUAINTANCE WITH CHRIST AS HEAD'),
(1, 26, 'JBS', 1, 381, 'ACQUAINTANCE WITH CHRIST IN UNION'),
(1, 27, 'JBS', 3, 239, 'THE SCOPE OF TRUTH'),
(1, 28, 'FER', 7, 111, 'LECTURES ON COLOSSIANS');

--
-- Dumping data for table `mse_volume`
--

INSERT INTO `mse_volume` (`author`, `vol`, `title`, `added`, `localfile`) VALUES
('CAC', 1, 'V01 Outline of Genesis', '2018-02-11 19:09:59', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac1.txt'),
('CAC', 2, 'V02 Outline of Exodus', '2018-02-03 16:19:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac2.txt'),
('CAC', 3, 'V03 Outline of Leviticus', '2018-02-03 16:19:04', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac3.txt'),
('CAC', 4, 'V04 Outline of the Book of Numbers', '2018-02-03 16:19:07', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac4.txt'),
('CAC', 5, 'V05 Outline of the Book of Deuteronomy', '2018-02-11 13:46:04', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac5.txt'),
('CAC', 6, 'V06 Outline of Joshua, Judges and Ruth', '2018-02-03 16:19:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac6.txt'),
('CAC', 7, 'V07 Outline of The Song of Songs', '2018-02-03 16:19:18', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac7.txt'),
('CAC', 8, 'V08 Outline of the Minor Prophets', '2018-02-03 16:19:21', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac8.txt'),
('CAC', 9, 'V09 Outline of Mark~s Gospel and Other Ministry', '2018-02-03 16:19:24', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac9.txt'),
('CAC', 10, 'V10 Outline of Luke~s Gospel', '2018-02-03 16:19:28', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac10.txt'),
('CAC', 11, 'V11 Outline of Romans', '2018-02-03 16:19:32', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac11.txt'),
('CAC', 12, 'V12 Outline of the Epistle of James', '2018-02-03 16:19:35', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac12.txt'),
('CAC', 13, 'V13 Outline of "The Revelation"', '2018-02-03 16:19:37', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac13.txt'),
('CAC', 14, 'V14 The True Grace of God', '2018-02-03 16:19:40', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac14.txt'),
('CAC', 15, 'V15 The Believer Established', '2018-02-03 16:19:42', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac15.txt'),
('CAC', 16, 'V16 Favour and Freedom', '2018-02-03 16:19:45', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac16.txt'),
('CAC', 17, 'V17 The Food of Life', '2018-02-11 13:48:21', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac17.txt'),
('CAC', 18, 'V18 The House of God', '2018-02-03 16:19:50', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac18.txt'),
('CAC', 19, 'V19 The Paths of Life', '2018-02-03 16:19:52', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac19.txt'),
('CAC', 20, 'V20 Spiritual Blessings', '2018-02-03 16:19:55', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac20.txt'),
('CAC', 21, 'V21 A Sure Foundation', '2018-02-03 16:19:58', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac21.txt'),
('CAC', 22, 'V22 Letters of C.A. Coates', '2018-02-03 16:20:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac22.txt'),
('CAC', 23, 'V23 Outline of the Epistle to the Hebrews', '2018-02-03 16:20:06', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac23.txt'),
('CAC', 24, 'V24 Notes of Readings on the Lord~s Supper', '2018-02-03 16:20:09', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac24.txt'),
('CAC', 25, 'V25 Outline of Corinthians', '2018-02-03 16:20:12', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac25.txt'),
('CAC', 26, 'V26 Outline of Ephesians', '2018-02-03 16:20:16', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac26.txt'),
('CAC', 27, 'V27 Outlines of Samuel, Kings and the Chronicles', '2018-02-03 16:20:20', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac27.txt'),
('CAC', 28, 'V28 Notes of Readings on Matthew~s Gospel', '2018-02-03 16:20:24', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac28.txt'),
('CAC', 29, 'V29 An Outline of John~s Gospel', '2018-02-03 16:20:27', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac29.txt'),
('CAC', 30, 'V30 Misc Ministry on OT', '2018-02-03 16:20:31', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac30.txt'),
('CAC', 31, 'V31 Misc Ministry on NT Matthew-Romans', '2018-02-11 13:49:37', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac31.txt'),
('CAC', 32, 'V32 Misc Ministry on NT Corinthians-Colossians', '2018-02-03 16:20:42', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac32.txt'),
('CAC', 33, 'V33 Misc Ministry on NT Thessalonians-Revelation', '2018-02-03 16:20:47', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac33.txt'),
('CAC', 34, 'V34 Words in Season', '2018-02-03 16:20:51', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac34.txt'),
('CAC', 35, 'V27a Outlines of the Books of the Chronicles', '2018-02-03 16:20:54', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac35.txt'),
('CAC', 36, 'Remarks on a pamphlet by A. J. Pollock entitled "The Eternal Son"', '2018-02-03 16:20:59', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac36.txt'),
('CAC', 37, 'A Message for You', '2018-02-03 16:21:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac37.txt'),
('FER', 1, 'V01 Volume 1', '2018-02-03 16:21:51', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer1.txt'),
('FER', 2, 'V02 Volume 2', '2018-02-03 16:21:54', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer2.txt'),
('FER', 3, 'V03 Volume 3', '2018-02-03 16:21:57', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer3.txt'),
('FER', 4, 'V04 Volume 4', '2018-02-03 16:22:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer4.txt'),
('FER', 5, 'V05 Volume 5', '2018-02-03 16:22:03', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer5.txt'),
('FER', 6, 'V06 Volume 6', '2018-02-03 16:22:08', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer6.txt'),
('FER', 7, 'V07 Volume 7', '2018-02-19 22:26:47', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer7.txt'),
('FER', 8, 'V08 Volume 8', '2018-02-03 16:22:16', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer8.txt'),
('FER', 9, 'V09 Volume 9', '2018-02-03 16:22:21', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer9.txt'),
('FER', 10, 'V10 Volume 10', '2018-02-03 16:22:26', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer10.txt'),
('FER', 11, 'V11 Volume 11', '2018-02-03 16:22:34', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer11.txt'),
('FER', 12, 'V12 Volume 12', '2018-02-03 16:22:39', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer12.txt'),
('FER', 13, 'V13 Volume 13', '2018-02-03 16:22:44', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer13.txt'),
('FER', 14, 'V14 Volume 14', '2018-02-03 16:22:48', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer14.txt'),
('FER', 15, 'V15 Volume 15', '2018-02-03 16:22:56', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer15.txt'),
('FER', 16, 'V16 Volume 16', '2018-02-03 16:23:03', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer16.txt'),
('FER', 17, 'V17 Volume 17', '2018-02-03 16:23:07', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer17.txt'),
('FER', 18, 'V18 Volume 18', '2018-02-03 16:23:11', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer18.txt'),
('FER', 19, 'V19 Volume 19', '2018-02-03 16:23:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer19.txt'),
('FER', 20, 'V20 Volume 20', '2018-02-03 16:23:20', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer20.txt'),
('FER', 21, 'Letters', '2018-02-03 16:23:23', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer21.txt'),
('GRC', 1, 'V01', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc1.txt'),
('GRC', 2, 'V02 - Greatness', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc2.txt'),
('GRC', 3, 'V03 - The Lord Jesus as seen in the Revelation', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc3.txt'),
('GRC', 4, 'V04 - The Sabbath Of Rest', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc4.txt'),
('GRC', 5, 'V05 - Devotion By Vow', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc5.txt'),
('GRC', 6, 'V06 - God With Us', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc6.txt'),
('GRC', 7, 'V07 - Progress In Recovery', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc7.txt'),
('GRC', 8, 'V08 - Ordering of the Camp', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc8.txt'),
('GRC', 9, 'V09 - Purification And Life', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc9.txt'),
('GRC', 10, 'V10 - The Gospel of the Glory', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc10.txt'),
('GRC', 11, 'V11', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc11.txt'),
('GRC', 12, 'V12 - The Grace and Government of God in Days of Recovery', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc12.txt'),
('GRC', 13, 'V13 - Addresses and Readings', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc13.txt'),
('GRC', 14, 'V14 - Spiritual Vision', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc14.txt'),
('GRC', 15, 'V15 - The Times of the Nations', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc15.txt'),
('GRC', 16, 'V16', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc16.txt'),
('GRC', 17, 'Booklet 1', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc17.txt'),
('GRC', 18, 'Booklet 2', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc18.txt'),
('GRC', 19, 'Booklet 3', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc19.txt'),
('GRC', 20, 'Booklet 4', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc20.txt'),
('GRC', 21, 'Booklet 5', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc21.txt'),
('GRC', 22, 'Booklet 6', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc22.txt'),
('GRC', 23, 'The Headship of Christ and of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc23.txt'),
('GRC', 24, 'Fundamental Truths of Christianity and The Kingdom of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc24.txt'),
('GRC', 25, 'V25', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc25.txt'),
('GRC', 26, 'V26', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc26.txt'),
('GRC', 27, 'Greatness And Other Ministry', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc27.txt'),
('GRC', 28, 'Departing from Iniquity or Inconsistency', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc28.txt'),
('GRC', 29, 'The Call of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc29.txt'),
('GRC', 30, 'The Choice of a Career', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc30.txt'),
('GRC', 31, 'The Deity of Christ', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc31.txt'),
('GRC', 32, 'V32', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc32.txt'),
('GRC', 33, 'Houses Hallowed and Redeemed', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc33.txt'),
('GRC', 34, 'God Himself', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc34.txt'),
('GRC', 35, 'The Work of the Lord and the Service of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc35.txt'),
('GRC', 36, 'Giving and its Fruits', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc36.txt'),
('GRC', 37, 'The Supremacy of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc37.txt'),
('GRC', 38, 'The Name of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc38.txt'),
('GRC', 39, 'God Going Before His People', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc39.txt'),
('GRC', 40, 'Walking in the Light', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc40.txt'),
('GRC', 41, 'The Servant of the Lord', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc41.txt'),
('GRC', 42, 'V42', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc42.txt'),
('GRC', 43, 'The Family, the Body and the Temple', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc43.txt'),
('GRC', 44, 'Our Access into the Presence of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc44.txt'),
('GRC', 45, 'V45', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc45.txt'),
('GRC', 46, 'FOUNDATIONS', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc46.txt'),
('GRC', 47, 'CHRIST IN US', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc47.txt'),
('GRC', 48, 'V48', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc48.txt'),
('GRC', 49, 'V49', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc49.txt'),
('GRC', 50, 'Habitation of God in the Spirit', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc50.txt'),
('GRC', 51, 'The Priest with Urim and with Thummim', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc51.txt'),
('GRC', 52, 'The Shepherd and Bishop of our Souls', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc52.txt'),
('GRC', 53, 'The Gospel and the Church', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc53.txt'),
('GRC', 54, '"God is One"', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc54.txt'),
('GRC', 55, 'Four Aspects of the Call of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc55.txt'),
('GRC', 56, 'Lay Hold of Eternal Life', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc56.txt'),
('GRC', 57, 'Rest, Life, Food, Drink', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc57.txt'),
('GRC', 58, 'The Divinely Established System', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc58.txt'),
('GRC', 59, 'The Divine System', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc59.txt'),
('GRC', 60, 'Fellowship', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc60.txt'),
('GRC', 61, 'As a Man Thinks in His Heart so is He', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc61.txt'),
('GRC', 62, 'The Wall of The City', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc62.txt'),
('GRC', 63, 'Nazariteship', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc63.txt'),
('GRC', 64, 'Let Him That Boasts, Boast in the Lord', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc64.txt'),
('GRC', 65, 'V65', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc65.txt'),
('GRC', 66, 'Christ as Foundation, Structure and Headstone', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc66.txt'),
('GRC', 67, 'Devotion to God and His Chief Interest on Earth - The House of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc67.txt'),
('GRC', 68, 'Our Standing on Divine Ground', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc68.txt'),
('GRC', 69, 'Loving Righteousness', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc69.txt'),
('GRC', 70, 'The Knowledge of the Son of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc70.txt'),
('GRC', 71, 'The System, Position and Path', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc71.txt'),
('GRC', 72, 'Activities In Which We Are To Engage', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc72.txt'),
('GRC', 73, 'The Unveiling of the Glories of Jesus Christ', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc73.txt'),
('GRC', 74, 'Issues Involved in Present Exercises', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc74.txt'),
('GRC', 75, 'V75', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc75.txt'),
('GRC', 76, 'V76', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc76.txt'),
('GRC', 77, 'Levitical Service', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc77.txt'),
('GRC', 78, 'The Testimony of our Lord', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc78.txt'),
('GRC', 79, 'Living Water', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc79.txt'),
('GRC', 80, 'Living Bread', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc80.txt'),
('GRC', 81, 'Sound Teaching, Sound Words, Sound Mind', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc81.txt'),
('GRC', 82, 'The Body, the Kingdom, The House', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc82.txt'),
('GRC', 83, 'Communion With God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc83.txt'),
('GRC', 84, 'Running, Walking And Standing', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc84.txt'),
('GRC', 85, 'Anchor of The Soul', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc85.txt'),
('GRC', 86, 'Help for those young in the Faith', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc86.txt'),
('GRC', 87, 'The Upward Way', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc87.txt'),
('GRC', 88, 'The Closing Ministry of the Dispensation', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc88.txt'),
('JBS', 1, 'V01 Volume 1', '2018-02-22 21:24:34', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs1.txt'),
('JBS', 2, 'V02 Volume 2', '2018-02-03 16:23:31', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs2.txt'),
('JBS', 3, 'V03 Volume 3', '2018-02-19 22:23:24', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs3.txt'),
('JBS', 4, 'V04 Volume 4', '2018-02-03 16:23:38', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs4.txt'),
('JBS', 5, 'V05 Volume 5', '2018-02-03 16:23:42', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs5.txt'),
('JBS', 6, 'V06 Volume 6', '2018-02-03 16:23:46', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs6.txt'),
('JBS', 7, 'V07 Volume 7', '2018-02-03 16:23:50', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs7.txt'),
('JBS', 8, 'V08 Volume 8', '2018-02-03 16:23:54', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs8.txt'),
('JBS', 9, 'V09 Volume 9', '2018-02-03 16:23:58', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs9.txt'),
('JBS', 10, 'V10 Volume 10', '2018-02-03 16:24:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs10.txt'),
('JBS', 11, 'V11 Volume 11', '2018-02-03 16:24:05', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs11.txt'),
('JBS', 12, 'V12 Volume 12', '2018-02-03 16:24:09', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs12.txt'),
('JBS', 13, 'V13 Volume 13', '2018-02-19 22:24:40', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs13.txt'),
('JBS', 14, 'Letters 1', '2018-02-03 16:24:19', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs14.txt'),
('JBS', 15, 'Letters 2', '2018-02-03 16:24:22', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs15.txt'),
('JBS', 16, 'Letters 3', '2018-02-03 16:24:27', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs16.txt'),
('JBS', 17, 'From Glory to Glory', '2018-02-03 16:24:30', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs17.txt'),
('JT', 102, 'Letters - Vol 1', '2018-02-03 16:36:05', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt102.txt'),
('JT', 101, 'V100a', '2018-02-03 16:36:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt101.txt'),
('JT', 100, 'V100 Volume 100', '2018-02-03 16:35:55', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt100.txt'),
('JT', 99, 'V099 Volume 99', '2018-02-03 16:35:51', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt99.txt'),
('JT', 98, 'V098 Volume 98', '2018-02-03 16:35:47', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt98.txt'),
('JT', 97, 'V097 Volume 97', '2018-02-03 16:35:43', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt97.txt'),
('JT', 96, 'V096 Volume 96', '2018-02-03 16:35:38', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt96.txt'),
('JT', 95, 'V095 Volume 95', '2018-02-03 16:35:33', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt95.txt'),
('JT', 94, 'V094 Volume 94', '2018-02-03 16:35:28', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt94.txt'),
('JT', 93, 'V093 Volume 93', '2018-02-03 16:35:24', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt93.txt'),
('JT', 92, 'V092 Volume 92', '2018-02-03 16:35:19', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt92.txt'),
('JT', 91, 'V091 Volume 91', '2018-02-03 16:35:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt91.txt'),
('JT', 90, 'V090 Volume 90', '2018-02-03 16:35:11', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt90.txt'),
('JT', 89, 'V089 Volume 89', '2018-02-03 16:35:07', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt89.txt'),
('JT', 88, 'V088 Volume 88', '2018-02-03 16:35:03', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt88.txt'),
('JT', 87, 'V087 Volume 87', '2018-02-03 16:34:58', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt87.txt'),
('JT', 86, 'V086 Volume 86', '2018-02-03 16:34:50', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt86.txt'),
('JT', 85, 'V085 Volume 85', '2018-02-03 16:34:39', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt85.txt'),
('JT', 84, 'V084 Volume 84', '2018-02-03 16:34:35', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt84.txt'),
('JT', 83, 'V083 Volume 83', '2018-02-03 16:34:31', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt83.txt'),
('JT', 82, 'V082 Volume 82', '2018-02-03 16:34:27', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt82.txt'),
('JT', 81, 'V081 Volume 81', '2018-02-03 16:34:23', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt81.txt'),
('JT', 80, 'V080 Volume 80', '2018-02-03 16:34:19', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt80.txt'),
('JT', 79, 'V079 Volume 79', '2018-02-03 16:34:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt79.txt'),
('JT', 78, 'V078 Volume 78', '2018-02-03 16:34:10', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt78.txt'),
('JT', 77, 'V077 Volume 77', '2018-02-03 16:34:06', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt77.txt'),
('JT', 76, 'V076 Volume 76', '2018-02-03 16:34:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt76.txt'),
('JT', 75, 'V075 Volume 75', '2018-02-03 16:33:56', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt75.txt'),
('JT', 74, 'V074 Volume 74', '2018-02-03 16:33:52', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt74.txt'),
('JT', 73, 'V073 Volume 73', '2018-02-03 16:33:48', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt73.txt'),
('JT', 72, 'V072 Volume 72', '2018-02-03 16:33:44', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt72.txt'),
('JT', 71, 'V071 Volume 71', '2018-02-03 16:33:38', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt71.txt'),
('JT', 70, 'V070 Volume 70', '2018-02-03 16:33:34', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt70.txt'),
('JT', 69, 'V069 Volume 69', '2018-02-03 16:33:30', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt69.txt'),
('JT', 68, 'V068 Volume 68', '2018-02-03 16:33:25', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt68.txt'),
('JT', 67, 'V067 Volume 67', '2018-02-03 16:33:19', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt67.txt'),
('JT', 66, 'V066 Volume 66', '2018-02-03 16:33:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt66.txt'),
('JT', 65, 'V065 Volume 65', '2018-02-03 16:33:10', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt65.txt'),
('JT', 64, 'V064 Volume 64', '2018-02-03 16:33:05', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt64.txt'),
('JT', 63, 'V063 Volume 63', '2018-02-03 16:32:59', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt63.txt'),
('JT', 62, 'V062 Volume 62', '2018-02-11 14:12:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt62.txt'),
('JT', 61, 'V061 Volume 61', '2018-02-03 16:32:49', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt61.txt'),
('JT', 60, 'V060 Paul''s Ministry and the Service of God', '2018-02-03 16:32:43', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt60.txt'),
('JT', 59, 'V059 Volume 59', '2018-02-03 16:32:38', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt59.txt'),
('JT', 58, 'V058 The Lord''s Supper', '2018-02-03 16:32:34', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt58.txt'),
('JT', 57, 'V057 Volume 57', '2018-02-03 16:32:29', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt57.txt'),
('JT', 56, 'V056 Volume 56', '2018-02-03 16:32:25', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt56.txt'),
('JT', 55, 'V055 Volume 55', '2018-02-03 16:32:20', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt55.txt'),
('JT', 54, 'V054 Volume 54', '2018-02-03 16:32:16', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt54.txt'),
('JT', 53, 'V053 Volume 53', '2018-02-03 16:32:11', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt53.txt'),
('JT', 52, 'V052 Wells and Springs', '2018-02-03 16:32:06', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt52.txt'),
('JT', 51, 'V051 Christ Assembling with His Own', '2018-02-03 16:32:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt51.txt'),
('JT', 50, 'V050 Divine Names', '2018-02-03 16:31:57', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt50.txt'),
('JT', 49, 'V049 Volume 49', '2018-02-03 16:31:52', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt49.txt'),
('JT', 48, 'V048 Volume 48', '2018-02-03 16:31:47', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt48.txt'),
('JT', 47, 'V047 Volume 47', '2018-02-03 16:31:42', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt47.txt'),
('JT', 46, 'V046 Volume 46', '2018-02-03 16:31:37', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt46.txt'),
('JT', 45, 'V045 Spoil', '2018-02-03 16:31:32', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt45.txt'),
('JT', 44, 'V044 Volume 44', '2018-02-03 16:31:27', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt44.txt'),
('JT', 43, 'V043 The Authority of Christ in the Assembly', '2018-02-03 16:31:22', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt43.txt'),
('JT', 42, 'V042 Volume 42', '2018-02-03 16:31:18', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt42.txt'),
('JT', 41, 'V041 Volume 41', '2018-02-03 16:31:13', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt41.txt'),
('JT', 40, 'V040 Volume 40', '2018-02-03 16:31:08', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt40.txt'),
('JT', 39, 'V039 Service', '2018-02-03 16:31:03', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt39.txt'),
('JT', 38, 'V038 Volume 38', '2018-02-03 16:30:59', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt38.txt'),
('JT', 37, 'V037 The Assembly', '2018-02-03 16:30:54', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt37.txt'),
('JT', 36, 'V036 Volume 36', '2018-02-03 16:30:49', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt36.txt'),
('JT', 35, 'V035 Volume 35', '2018-02-03 16:30:44', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt35.txt'),
('JT', 34, 'V034 Volume 34', '2018-02-03 16:30:40', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt34.txt'),
('JT', 33, 'V033 Volume 33', '2018-02-03 16:30:35', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt33.txt'),
('JT', 32, 'V032 Volume 32', '2018-02-03 16:30:30', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt32.txt'),
('JT', 31, 'V031 Volume 31', '2018-02-03 16:30:26', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt31.txt'),
('JT', 30, 'V030 Volume 30', '2018-02-03 16:30:22', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt30.txt'),
('JT', 29, 'V029 Volume 29', '2018-02-03 16:30:17', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt29.txt'),
('JT', 28, 'V028 Divine Wisdom operating against Apostasy', '2018-02-03 16:30:13', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt28.txt'),
('JT', 27, 'V027 Volume 27', '2018-02-03 16:30:08', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt27.txt'),
('JT', 26, 'V026 The Witness of God', '2018-02-03 16:30:04', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt26.txt'),
('JT', 25, 'V025 Volume 25', '2018-02-03 16:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt25.txt'),
('JT', 24, 'V024 Volume 24', '2018-02-03 16:29:57', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt24.txt'),
('JT', 23, 'V023 Education for Effective Testimony', '2018-02-03 16:29:53', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt23.txt'),
('JT', 22, 'V022 Prayer: Characteristic of the Perfect Man', '2018-02-03 16:29:49', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt22.txt'),
('JT', 21, 'V021 Volume 21', '2018-02-03 16:29:45', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt21.txt'),
('JT', 20, 'V020 Volume 20', '2018-02-03 16:29:41', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt20.txt'),
('JT', 19, 'V019 Volume 19', '2018-02-03 16:29:36', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt19.txt'),
('JT', 18, 'V018 Volume 18', '2018-02-03 16:29:32', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt18.txt'),
('JT', 17, 'V017 Volume 17', '2018-02-03 16:29:27', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt17.txt'),
('JT', 16, 'V016 Volume 16', '2018-02-03 16:29:22', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt16.txt'),
('JT', 15, 'V015 Volume 15', '2018-02-03 16:29:18', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt15.txt'),
('JT', 14, 'V014 Volume 14', '2018-02-03 16:29:13', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt14.txt'),
('JT', 13, 'V013 Volume 13', '2018-02-04 18:14:20', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt13.txt'),
('JT', 12, 'V012 Volume 12', '2018-02-03 16:29:04', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt12.txt'),
('JT', 11, 'V011 Volume 11', '2018-02-03 16:28:59', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt11.txt'),
('JT', 10, 'V010 Volume 10', '2018-02-03 16:28:55', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt10.txt'),
('JT', 9, 'V009 Volume 9', '2018-02-03 16:28:50', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt9.txt'),
('JT', 8, 'V008 Volume 8', '2018-02-03 16:28:44', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt8.txt'),
('JT', 7, 'V007 Volume 7', '2018-02-03 16:28:37', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt7.txt'),
('JT', 6, 'V006 Volume 6', '2018-02-03 16:28:32', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt6.txt'),
('JT', 5, 'V005 Volume 5', '2018-02-03 16:28:27', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt5.txt'),
('JT', 4, 'V004 Volume 4', '2018-02-03 16:28:22', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt4.txt'),
('JT', 3, 'V003 Volume 3', '2018-02-03 16:28:16', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt3.txt'),
('JT', 2, 'V002 Volume 2', '2018-02-03 16:28:10', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt2.txt'),
('JT', 1, 'V001 Volume 1', '2018-02-03 16:28:05', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt1.txt'),
('JND', 1, 'CW V01 Ecclesiastical 1', '2018-02-03 16:24:32', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd1.txt'),
('JND', 2, 'CW V02 Prophetic 1', '2018-02-03 16:24:36', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd2.txt'),
('JND', 3, 'CW V03 Doctrinal 1', '2018-02-03 16:24:40', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd3.txt'),
('JND', 4, 'CW V04 Ecclesiastical 2', '2018-02-04 18:40:08', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd4.txt'),
('JND', 5, 'CW V05 Prophetic 2', '2018-02-19 21:23:38', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd5.txt'),
('JND', 6, 'CW V06 Apologetic 1', '2018-02-03 16:24:52', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd6.txt'),
('JND', 7, 'CW V07 Doctrinal 2', '2018-02-19 19:40:37', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd7.txt'),
('JND', 8, 'CW V08 Prophetic 3', '2018-02-03 16:24:59', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd8.txt'),
('JND', 9, 'CW V09 Apologetic 2', '2018-02-03 16:25:03', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd9.txt'),
('JND', 10, 'CW V10 Doctrinal 3', '2018-02-19 21:34:08', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd10.txt'),
('JND', 11, 'CW V11 Prophetic 4', '2018-02-03 16:25:10', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd11.txt'),
('JND', 12, 'CW V12 Evangelical 1', '2018-02-03 16:25:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd12.txt'),
('JND', 13, 'CW V13 Critical 1', '2018-02-03 16:25:19', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd13.txt'),
('JND', 14, 'CW V14 Ecclesiastical 3', '2018-02-19 20:59:39', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd14.txt'),
('JND', 15, 'CW V15 Doctrinal 4', '2018-02-03 16:25:26', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd15.txt'),
('JND', 16, 'CW V16 Practical 1', '2018-02-19 20:48:44', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd16.txt'),
('JND', 17, 'CW V17 Practical 2', '2018-02-19 22:08:07', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd17.txt'),
('JND', 18, 'CW V18 Doctrinal 5', '2018-02-03 16:25:37', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd18.txt'),
('JND', 19, 'CW V19 Expository 1', '2018-02-03 16:25:41', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd19.txt'),
('JND', 20, 'CW V20 Ecclesiastical 4', '2018-02-03 16:25:46', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd20.txt'),
('JND', 21, 'CW V21 Evangelical 2', '2018-02-19 21:55:19', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd21.txt'),
('JND', 22, 'CW V22 Doctrinal 6', '2018-02-03 16:25:53', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd22.txt'),
('JND', 23, 'CW V23 Doctrinal 7', '2018-02-19 20:18:55', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd23.txt'),
('JND', 24, 'CW V24 Expository 3', '2018-02-03 16:26:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd24.txt'),
('JND', 25, 'CW V25 Expository 4', '2018-02-03 16:26:05', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd25.txt'),
('JND', 26, 'CW V26 Expository 5', '2018-02-03 16:26:08', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd26.txt'),
('JND', 27, 'CW V27 Expository 6', '2018-02-03 16:26:12', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd27.txt'),
('JND', 28, 'CW V28 Expository 7', '2018-02-03 16:26:16', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd28.txt'),
('JND', 29, 'CW V29 Doctrinal 8', '2018-02-19 20:25:31', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd29.txt'),
('JND', 30, 'CW V30 Expository 2', '2018-02-04 18:58:58', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd30.txt'),
('JND', 31, 'CW V31 Doctrinal 9', '2018-02-03 16:26:28', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd31.txt'),
('JND', 32, 'CW V32 Misc 1', '2018-02-03 16:26:33', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd32.txt'),
('JND', 33, 'CW V33 Misc 2', '2018-02-03 16:26:39', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd33.txt'),
('JND', 34, 'CW V34 Misc 3', '2018-02-03 16:26:45', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd34.txt'),
('JND', 35, 'N&C V01', '2018-02-03 16:26:49', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd35.txt'),
('JND', 36, 'N&C V02', '2018-02-03 16:26:54', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd36.txt'),
('JND', 37, 'N&C V03', '2018-02-03 16:26:58', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd37.txt'),
('JND', 38, 'N&C V04', '2018-02-19 22:13:17', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd38.txt'),
('JND', 39, 'N&C V05', '2018-02-03 16:27:06', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd39.txt'),
('JND', 40, 'N&C V06', '2018-02-03 16:27:10', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd40.txt'),
('JND', 41, 'N&C V07', '2018-02-03 16:27:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd41.txt'),
('JND', 42, 'N&C Notes and Jottings', '2018-02-03 16:27:19', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd42.txt'),
('JND', 43, 'Synopsis V01 Genesis to 2 Chronicles', '2018-02-03 16:27:24', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd43.txt'),
('JND', 44, 'Synopsis V02 Ezra to Malachi', '2018-02-03 16:27:30', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd44.txt'),
('JND', 45, 'Synopsis V03 Matthew to John', '2018-02-03 16:27:35', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd45.txt'),
('JND', 46, 'Synopsis V04 Acts to Philippians', '2018-02-03 16:27:39', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd46.txt'),
('JND', 47, 'Synopsis V05 Colossians to Revelation', '2018-02-03 16:27:43', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd47.txt'),
('JND', 48, 'Misc The World or Christ?', '2018-02-03 16:27:47', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd48.txt'),
('JND', 49, 'Misc What the World is and how a Christian can live in it', '2018-02-03 16:27:49', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd49.txt'),
('JND', 50, 'Letters V01', '2018-02-03 16:27:51', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd50.txt'),
('JND', 51, 'Letters V02', '2018-02-03 16:27:56', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd51.txt'),
('JND', 52, 'Letters V03', '2018-02-03 16:28:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd52.txt'),
('JT', 103, 'Letters - Vol 2', '2018-02-03 16:36:14', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt103.txt'),
('SMC', 1, 'V01 Spiritual Quality', '2018-02-03 16:36:19', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\smc\\\\smc1.txt'),
('CHM', 18, 'V18 The Remnant - Past and Present', '2018-02-03 16:21:49', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm18.txt'),
('CHM', 17, 'V17 The Present Condition of Things', '2018-02-03 16:21:46', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm17.txt'),
('CHM', 16, 'V16 Gideon and His Companions', '2018-02-03 16:21:44', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm16.txt'),
('CHM', 15, 'V15 Job and His Friends', '2018-02-03 16:21:42', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm15.txt'),
('CHM', 14, 'V14 The All-sufficiency of Christ', '2018-02-03 16:21:40', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm14.txt'),
('CHM', 13, 'V13 The Christian Priesthood', '2018-02-03 16:21:38', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm13.txt'),
('CHM', 12, 'V12 Discipleship in an Evil Day', '2018-02-03 16:21:35', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm12.txt'),
('CHM', 11, 'V11 The Unequal Yoke', '2018-02-03 16:21:33', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm11.txt'),
('CHM', 10, 'V10 The Christian: His Position and His Work', '2018-02-03 16:21:31', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm10.txt'),
('CHM', 9, 'V09 Final Perseverance: What is it?', '2018-02-03 16:21:29', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm9.txt'),
('CHM', 8, 'V08 Sanctification: What is it?', '2018-02-03 16:21:27', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm8.txt'),
('CHM', 7, 'V07 Regeneration: What is it?', '2018-02-03 16:21:25', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm7.txt'),
('CHM', 6, 'V06 Forgiveness of sins: What is it?', '2018-02-03 16:21:23', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm6.txt'),
('CHM', 5, 'V05 Notes on Deuteronomy', '2018-02-03 16:21:18', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm5.txt'),
('CHM', 4, 'V04 Notes on Numbers', '2018-02-03 16:21:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm4.txt'),
('CHM', 3, 'V03 Notes on Leviticus', '2018-02-03 21:09:01', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm3.txt'),
('CHM', 2, 'V02 Notes on Exodus', '2018-02-18 13:17:40', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm2.txt'),
('CHM', 1, 'V01 Notes on Genesis', '2018-02-21 22:46:44', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\chm\\\\chm1.txt'),
('AJG', 11, 'V11 The Recovery and Maintenance of the Truth', '2018-02-03 17:13:51', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\ajg\\\\ajg11.txt'),
('AJG', 10, 'V10 The Believer''s Body', '2018-02-03 17:15:52', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\ajg\\\\ajg10.txt'),
('AJG', 9, 'V09 The True Grace Of God', '2018-02-03 16:18:50', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\ajg\\\\ajg9.txt'),
('AJG', 6, 'V06 Eternal Life', '2018-02-03 16:18:40', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\ajg\\\\ajg6.txt'),
('AJG', 8, 'V08 The Substantiality of Christianity', '2018-02-03 16:18:46', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\ajg\\\\ajg8.txt'),
('AJG', 5, 'V05 Education in View of the Testimony', '2018-02-03 16:18:26', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\ajg\\\\ajg5.txt'),
('AJG', 3, 'V03 Christianity as Characterised by Mystery', '2018-02-03 16:18:23', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\ajg\\\\ajg3.txt'),
('AJG', 1, 'V01 Piety and other addresses', '2018-02-03 17:16:05', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\ajg\\\\ajg1.txt'),
('SMC', 3, 'V03 The Knowledge of Divine Persons and Things', '2018-02-03 16:36:24', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\smc\\\\smc3.txt'),
('SMC', 4, 'V04 Readings and Addresses in Australia', '2018-02-03 16:36:28', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\smc\\\\smc4.txt'),
('SMC', 5, 'V05 Grace as Presented in David', '2018-02-03 16:36:35', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\smc\\\\smc5.txt'),
('SMC', 7, 'V07 The Knowledge of Christ in Relation to the Gospel and the Assembly', '2018-02-03 16:36:43', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\smc\\\\smc7.txt'),
('SMC', 8, 'V08 Spiritual Unity in the Ministry of John and Other Readings and Addresses', '2018-02-03 16:36:46', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\smc\\\\smc8.txt'),
('SMC', 9, 'V09 Distinctiveness and Finality in Paul''s Ministry', '2018-02-03 16:36:50', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\smc\\\\smc9.txt'),
('SMC', 10, 'V10 Bondmanship in Testimony and in Glory', '2018-02-03 16:36:54', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\smc\\\\smc10.txt'),
('JGB', 1, 'V01 The Moral Glory of the Lord Jesus Christ', '2018-02-22 21:29:33', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jgb\\\\jgb1.txt');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
