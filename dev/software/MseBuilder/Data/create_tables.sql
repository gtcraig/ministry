-- --------------------------------------------------------
-- Ministry Search Engine Data Builder
-- Copyright (c) 2007 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: create_tables.sql 1117 2010-01-15 17:45:27Z craig $
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.8.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 20, 2007 at 04:13 PM
-- Server version: 4.1.20
-- PHP Version: 4.4.2
--
-- Database: southesk_com_-_min
-- --------------------------------------------------------

--
-- Table structure for table mse_article
--

CREATE TABLE mse_article (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page smallint(6) NOT NULL default '0',
  article varchar(255) default NULL,
  scriptures varchar(255) default NULL,
  bypass tinyint(4) default NULL,
  PRIMARY KEY  (author,vol,page)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


ALTER TABLE mse_article ADD localrow INT NOT NULL ;

-- --------------------------------------------------------

--
-- Table structure for table mse_author
--

CREATE TABLE mse_author (
  author char(3) NOT NULL default '',
  name varchar(50) NOT NULL default '',
  PRIMARY KEY  (author)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_book
--

CREATE TABLE mse_bible_book (
  bookid int(11) NOT NULL default '0',
  bookname varchar(255) default NULL,
  testament char(2) default NULL,
  testbook int(11) default NULL,
  singlechap tinyint(4) default NULL,
  firstverse varchar(255) default NULL,
  PRIMARY KEY  (bookid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_ref
--

CREATE TABLE mse_bible_ref (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page int(4) NOT NULL default '0',
  para int(2) NOT NULL default '0',
  ref int(11) NOT NULL default '0',
  bookid int(11) NOT NULL default '0',
  chapter int(11) NOT NULL default '0',
  vstart int(11) NOT NULL default '0',
  vend int(11) NOT NULL default '0',
  PRIMARY KEY  (author,vol,page,para,ref)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table mse_bible_ref_error
--

CREATE TABLE mse_bible_ref_error (
  author varchar(10) NOT NULL,
  vol int(3) NOT NULL default '0',
  page int(4) NOT NULL default '0',
  para int(2) NOT NULL default '0',
  ref int(11) NOT NULL default '0',
  error_code char(1) NULL,
  text varchar(1000) NULL,
  PRIMARY KEY  (author,vol,page,para,ref)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_text
--

CREATE TABLE mse_text (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page int(4) NOT NULL default '0',
  para int(2) NOT NULL default '0',
  article_page int(4) NOT NULL default '0',
  inits varchar(20) default NULL,
  text longtext NOT NULL,
  PRIMARY KEY  (author,vol,page,para),
  FULLTEXT KEY ft (text)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

ALTER TABLE mse_text ADD localrow INT NOT NULL ;

-- --------------------------------------------------------

--
-- Table structure for table mse_volume
--

CREATE TABLE mse_volume (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  title varchar(255) default NULL,
  added datetime default NULL,
  localfile varchar(255) NOT NULL default '',
  PRIMARY KEY  (author,vol)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;





--
-- Dumping data for table mse_author
--

INSERT INTO mse_author (author, name) VALUES ('CAC', 'C. A. Coates'),
('FER', 'F. E. Raven'),
('GRC', 'G. R. Cowell'),
('JBS', 'J. B. Stoney'),
('JND', 'J. N. Darby'),
('JT', 'J. Taylor, Snr'),
('VAR', 'Various');

--
-- Dumping data for table mse_bible_book
--

INSERT INTO mse_bible_book (bookid, bookname, testament, testbook, singlechap, firstverse) VALUES (1, 'Genesis', 'OT', 1, NULL, 'In the beginning God created the heavens and the earth.'),
(2, 'Exodus', 'OT', 2, NULL, 'And these are the names of the sons of Israel who had come into Egypt; with Jacob had they come, each with his household:'),
(3, 'Leviticus', 'OT', 3, NULL, 'And Jehovah called to Moses and spoke to him out of the tent of meeting, saying,'),
(4, 'Numbers', 'OT', 4, NULL, 'And Jehovah spoke to Moses in the wilderness of Sinai in the tent of meeting, on the first of the second month, in the second year after their departure from the land of Egypt, saying,'),
(5, 'Deuteronomy', 'OT', 5, NULL, 'These are the words which Moses spoke to all Israel on this side the Jordan, in the wilderness, in the plain, opposite to Suph, between Paran and Tophel, Laban, Hazeroth, and Dizahab.'),
(6, 'Joshua', 'OT', 6, NULL, 'And it came to pass after the death of Moses the servant of Jehovah, that Jehovah spoke to Joshua the son of Nun, Moses'' attendant, saying,'),
(7, 'Judges', 'OT', 7, NULL, 'After the death of Joshua the people of Israel inquired of the LORD, "Who shall go up first for us against the Canaanites, to fight against them?"'),
(8, 'Ruth', 'OT', 8, NULL, 'And it came to pass in the days when the judges ruled, that there was a famine in the land. And a certain man went from Bethlehem-Judah, to sojourn in the country of Moab, he, and his wife, and his two sons.'),
(9, '1 Samuel', 'OT', 9, NULL, 'And there was a certain man of Ramathaim-zophim, of mount Ephraim, and his name was Elkanah, the son of Jeroham, the son of Elihu, the son of Tohu, the son of Zuph, an Ephrathite.'),
(10, '2 Samuel', 'OT', 10, NULL, 'And it came to pass after the death of Saul, when David had returned from the slaughter of the Amalekites, that David abode two days in Ziklag.'),
(11, '1 Kings', 'OT', 11, NULL, 'And king David was old [and] advanced in age; and they covered him with clothes, but he obtained no warmth.'),
(12, '2 Kings', 'OT', 12, NULL, 'And Moab rebelled against Israel after the death of Ahab.'),
(13, '1 Chronicles', 'OT', 13, NULL, 'Adam, Seth, Enosh,'),
(14, '2 Chronicles', 'OT', 14, NULL, 'And Solomon the son of David was strengthened in his kingdom, and Jehovah his God was with him and magnified him exceedingly.'),
(15, 'Ezra', 'OT', 15, NULL, 'And in the first year of Cyrus king of Persia, that the word of Jehovah by the mouth of Jeremiah might be accomplished, Jehovah stirred up the spirit of Cyrus king of Persia, and he made a proclamation throughout his kingdom, and also in writing, saying,'),
(16, 'Nehemiah', 'OT', 16, NULL, 'The words of Nehemiah the son of Hachaliah. And it came to pass in the month Chislev, in the twentieth year, as I was in Shushan the fortress,'),
(17, 'Esther', 'OT', 17, NULL, 'And it came to pass in the days of Ahasuerus (that is, the Ahasuerus that reigned from India even to Ethiopia, over a hundred and twenty-seven provinces),'),
(18, 'Job', 'OT', 18, NULL, 'There was a man in the land of Uz whose name was Job; and this man was perfect and upright, and one that feared God and abstained from evil.'),
(19, 'Psalm', 'OT', 19, NULL, 'Blessed is the man that walketh not in the counsel of the wicked, and standeth not in the way of sinners, and sitteth not in the seat of scorners;'),
(20, 'Proverbs', 'OT', 20, NULL, 'Proverbs of Solomon, son of David, king of Israel:'),
(21, 'Ecclesiastes', 'OT', 21, NULL, 'The words of the Preacher, the son of David, king in Jerusalem.'),
(22, 'Song of Songs', 'OT', 22, NULL, 'The song of songs, which is Solomon''s.'),
(23, 'Isaiah', 'OT', 23, NULL, 'The vision of Isaiah the son of Amos, which he saw concerning Judah and Jerusalem in the days of Uzziah, Jotham, Ahaz, Hezekiah, kings of Judah.'),
(24, 'Jeremiah', 'OT', 24, NULL, 'The words of Jeremiah the son of Hilkijah, of the priests that were in Anathoth in the land of Benjamin:'),
(25, 'Lamentations', 'OT', 25, NULL, 'How doth the city sit solitary [that] was full of people! She that was great among the nations is become as a widow; the princess among the provinces is become tributary!'),
(26, 'Ezekiel', 'OT', 26, NULL, 'Now it came to pass in the thirtieth year, in the fourth [month], on the fifth of the month, as I was among the captives by the river Chebar, the heavens were opened, and I saw visions of God.'),
(27, 'Daniel', 'OT', 27, NULL, 'In the third year of the reign of Jehoiakim king of Judah came Nebuchadnezzar king of Babylon unto Jerusalem, and besieged it.'),
(28, 'Hosea', 'OT', 28, NULL, 'The word of Jehovah that came unto Hosea, the son of Beeri, in the days of Uzziah, Jotham, Ahaz, Hezekiah, kings of Judah, and in the days of Jeroboam the son of Joash, king of Israel.'),
(29, 'Joel', 'OT', 29, NULL, 'The word of Jehovah that came to Joel the son of Pethuel.'),
(30, 'Amos', 'OT', 30, NULL, 'The words of Amos, who was among the herdmen of Tekoa, which he saw concerning Israel in the days of Uzziah king of Judah, and in the days of Jeroboam the son of Joash, king of Israel, two years before the earthquake.'),
(31, 'Obadiah', 'OT', 31, 1, 'The vision of Obadiah. Thus saith the Lord Jehovah concerning Edom: We have heard a report from Jehovah, and an ambassador is sent among the nations. Arise ye, and let us rise up against her in battle.'),
(32, 'Jonah', 'OT', 32, NULL, 'And the word of Jehovah came unto Jonah the son of Amittai, saying,'),
(33, 'Micah', 'OT', 33, NULL, 'The word of Jehovah that came to Micah the Morasthite in the days of Jotham, Ahaz, [and] Hezekiah, kings of Judah, which he saw concerning Samaria and Jerusalem.'),
(34, 'Nahum', 'OT', 34, NULL, 'The burden of Nineveh. The book of the vision of Nahum the Elkoshite.'),
(35, 'Habakkuk', 'OT', 35, NULL, 'The burden which Habakkuk the prophet did see.'),
(36, 'Zephaniah', 'OT', 36, NULL, 'The word of Jehovah that came unto Zephaniah the son of Cushi, the son of Gedaliah, the son of Amariah, the son of Hezekiah, in the days of Josiah the son of Amon, king of Judah.'),
(37, 'Haggai', 'OT', 37, NULL, 'In the second year of Darius the king, in the sixth month, on the first day of the month, came the word of Jehovah by the prophet Haggai unto Zerubbabel the son of Shealtiel, governor of Judah, and to Joshua the son of Jehozadak, the high priest, saying,'),
(38, 'Zechariah', 'OT', 38, NULL, 'In the eighth month, in the second year of Darius, came the word of Jehovah unto Zechariah the prophet, the son of Berechiah, the son of Iddo, saying,'),
(39, 'Malachi', 'OT', 39, NULL, 'The burden of the word of Jehovah to Israel by Malachi.'),
(40, 'Matthew', 'NT', 1, NULL, 'Book of the generation of Jesus Christ, Son of David, Son of Abraham.'),
(41, 'Mark', 'NT', 2, NULL, 'Beginning of the glad tidings of Jesus Christ, Son of God;'),
(42, 'Luke', 'NT', 3, NULL, 'Forasmuch as many have undertaken to draw up a relation concerning the matters fully believed among us,'),
(43, 'John', 'NT', 3, NULL, 'In [the] beginning was the Word, and the Word was with God, and the Word was God.'),
(44, 'Acts', 'NT', 4, NULL, 'I composed the first discourse, O Theophilus, concerning all things which Jesus began both to do and to teach,'),
(45, 'Romans', 'NT', 5, NULL, 'Paul, bondman of Jesus Christ, [a] called apostle, separated to God''s glad tidings,'),
(46, '1 Corinthians', 'NT', 6, NULL, 'Paul, [a] called apostle of Jesus Christ, by God''s will, and Sosthenes the brother,'),
(47, '2 Corinthians', 'NT', 7, NULL, 'Paul, apostle of Jesus Christ by God''s will, and the brother Timotheus, to the assembly of God which is in Corinth, with all the saints who are in the whole of Achaia.'),
(48, 'Galatians', 'NT', 8, NULL, 'Paul, apostle, not from men nor through man, but through Jesus Christ, and God [the] Father who raised him from among [the] dead,'),
(49, 'Ephesians', 'NT', 9, NULL, 'Paul, apostle of Jesus Christ by God''s will, to the saints and faithful in Christ Jesus who are at Ephesus.'),
(50, 'Philippians', 'NT', 10, NULL, 'Paul and Timotheus, bondmen of Jesus Christ, to all the saints in Christ Jesus who are in Philippi, with [the] overseers and ministers;'),
(51, 'Colossians', 'NT', 11, NULL, 'Paul, apostle of Christ Jesus, by God''s will, and Timotheus the brother,'),
(52, '1 Thessalonians', 'NT', 12, NULL, 'Paul and Silvanus and Timotheus to the assembly of Thessalonians in God [the] Father and [the] Lord Jesus Christ. Grace to you and peace.'),
(53, '2 Thessalonians', 'NT', 13, NULL, 'Paul and Silvanus and Timotheus to the assembly of Thessalonians in God our Father and [the] Lord Jesus Christ.'),
(54, '1 Timothy', 'NT', 14, NULL, 'Paul, apostle of Jesus Christ, according to [the] command of God our Saviour, and of Christ Jesus our hope,'),
(55, '2 Timothy', 'NT', 15, NULL, 'Paul, apostle of Jesus Christ by God''s will, according to promise of life, the [life] which [is] in Christ Jesus,'),
(56, 'Titus', 'NT', 16, NULL, 'Paul, bondman of God, and apostle of Jesus Christ according to [the] faith of God''s elect, and knowledge of [the] truth which [is] according to piety;'),
(57, 'Philemon', 'NT', 17, 1, 'Paul, prisoner of Christ Jesus, and Timotheus the brother, to Philemon the beloved and our fellow-workman,'),
(58, 'Hebrews', 'NT', 18, NULL, 'God having spoken in many parts and in many ways formerly to the fathers in the prophets,'),
(59, 'James', 'NT', 19, NULL, 'James, bondman of God and of [the] Lord Jesus Christ, to the twelve tribes which [are] in the dispersion, greeting.'),
(60, '1 Peter', 'NT', 20, NULL, 'Peter, apostle of Jesus Christ, to [the] sojourners of [the] dispersion of Pontus, Galatia, Cappadocia, Asia, and Bithynia,'),
(61, '2 Peter', 'NT', 21, NULL, 'Simon Peter, bondman and apostle of Jesus Christ, to them that have received like precious faith with us through [the] righteousness of our God and Saviour Jesus Christ:'),
(62, '1 John', 'NT', 22, NULL, 'That which was from [the] beginning, that which we have heard, which we have seen with our eyes; that which we contemplated, and our hands handled, concerning the word of life;'),
(63, '2 John', 'NT', 23, 1, 'The elder to [the] elect lady and her children, whom *I* love in truth, and not *I* only but also all who have known the truth,'),
(64, '3 John', 'NT', 24, 1, 'The elder to the beloved Gaius, whom I love in truth.'),
(65, 'Jude', 'NT', 25, 1, 'Jude, bondman of Jesus Christ, and brother of James, to the called ones beloved in God [the] Father and preserved in Jesus Christ:'),
(66, 'Revelation', 'NT', 26, NULL, 'Revelation of Jesus Christ, which God gave to him, to shew to his bondmen what must shortly take place; and he signified [it], sending by his angel, to his bondman John,');

INSERT INTO mse_volume (author, vol, title, added, localfile) VALUES ('CAC', 1, 'Volume 1 - An Outline of Genesis', '2006-12-16 08:18:51', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac1.doc'),
('CAC', 2, 'Volume 2 - An Outline of Exodus\r\n', '2006-12-16 08:19:37', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac2.doc'),
('CAC', 3, 'Volume 3 - An Outline of Leviticus\r\n', '2006-12-16 08:20:16', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac3.doc'),
('CAC', 4, 'Volume 4 - An Outline of the Book of Numbers\r\n', '2006-12-16 08:22:50', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac4.doc'),
('CAC', 5, 'Volume 5 - An Outline of the Book of Deuteronomy\r\n', '2006-12-16 08:23:38', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac5.doc'),
('CAC', 6, 'Volume 6 - An Outline of Joshua, Judges and Ruth\r\n', '2006-12-16 08:32:45', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac6.doc'),
('CAC', 7, 'Volume 7 - An Outline of The Song of Songs\r\n', '2006-12-16 08:34:49', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac7.doc'),
('CAC', 8, 'Volume 8 - Outline of the Minor Prophets\r\n', '2006-12-16 08:44:41', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac8.doc'),
('CAC', 9, '', '2006-12-16 09:11:21', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac9.doc'),
('CAC', 10, '', '2006-12-16 09:14:38', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac10.doc'),
('CAC', 11, 'Volume 11 - An Outline of Romans\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac11.doc'),
('CAC', 12, 'Volume 12 - An Outline of the Epistle of James\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac12.doc'),
('CAC', 13, 'Volume 13 - An Outline of "The Revelation"\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac13.doc'),
('CAC', 14, 'Volume 14 - The True Grace of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac14.doc'),
('CAC', 15, 'Volume 15 - The Believer Established\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac15.doc'),
('CAC', 16, 'Volume 16 - Favour and Freedom\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac16.doc'),
('CAC', 17, 'Volume 17 - The Food of Life\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac17.doc'),
('CAC', 18, 'Volume 18 - The House of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac18.doc'),
('CAC', 19, 'Volume 19 - The Paths of Life\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac19.doc'),
('CAC', 20, 'Volume 20 - Spiritual Blessings\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac20.doc'),
('CAC', 21, 'Volume 21 - A Sure Foundation\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac21.doc'),
('CAC', 22, 'Volume 22 - Letters of C.A. Coates\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac22.doc'),
('CAC', 23, 'Volume 23 - An Outline of the Epistle to the Hebrews\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac23.doc'),
('CAC', 24, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac24.doc'),
('CAC', 25, 'Volume 25 - Outlines of the Epistles of Paul to the Corinthians\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac25.doc'),
('CAC', 26, 'Volume 26 - Outline of Ephesians\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac26.doc'),
('CAC', 27, 'Volume 27 - Outlines of Samuel, Kings and the Chronicles\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac27.doc'),
('CAC', 28, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac28.doc'),
('CAC', 29, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac29.doc'),
('CAC', 30, 'Volume 30 - Miscellaneous Ministry on the Old Testament\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac30.doc'),
('CAC', 31, 'Volume 31 - Miscellaneous Ministry on the New Testament Matthew-Romans\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac31.doc'),
('CAC', 32, 'Volume 32 - Miscellaneous Ministry on the New Testament Corinthians-Colossians\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac32.doc'),
('CAC', 33, 'Volume 33 - Miscellaneous Ministry on the New Testament Thessalonians-Revelation\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac33.doc'),
('CAC', 34, 'Volume 34 - Words in Season\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac34.doc'),
('CAC', 35, 'Volume 27a - Outlines of the Books of the Chronicles\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac35.doc'),
('CAC', 36, 'Remarks on a pamphlet by A. J. Pollock entitled "The Eternal Son"\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac36.doc'),
('CAC', 37, 'A Message for You\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac37.doc'),
('FER', 1, '', '2006-09-17 13:57:39', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer1.doc'),
('FER', 2, '', '2006-09-17 14:06:44', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer2.doc'),
('FER', 3, '', '2006-09-17 14:07:33', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer3.doc'),
('FER', 4, '', '2006-04-04 22:04:55', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer4.doc'),
('FER', 5, '', '2006-04-04 22:07:33', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer5.doc'),
('FER', 6, '', '2006-04-04 22:09:56', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer6.doc'),
('FER', 7, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer7.doc'),
('FER', 8, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer8.doc'),
('FER', 9, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer9.doc'),
('FER', 10, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer10.doc'),
('FER', 11, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer11.doc'),
('FER', 12, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer12.doc'),
('FER', 13, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer13.doc'),
('FER', 14, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer14.doc'),
('FER', 15, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer15.doc'),
('FER', 16, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer16.doc'),
('FER', 17, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer17.doc'),
('FER', 18, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer18.doc'),
('FER', 19, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer19.doc'),
('FER', 20, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer20.doc'),
('FER', 21, 'Letters\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer21.doc'),
('GRC', 1, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc1.doc'),
('GRC', 2, 'Volume 2 - Greatness\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc2.doc'),
('GRC', 3, 'Volume 3 - The Lord Jesus as seen in the Revelation\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc3.doc'),
('GRC', 4, 'Volume 4 - The Sabbath Of Rest\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc4.doc'),
('GRC', 5, 'Volume 5 - Devotion By Vow\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc5.doc'),
('GRC', 6, 'Volume 6 - God With Us\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc6.doc'),
('GRC', 7, 'Volume 7 - Progress In Recovery\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc7.doc'),
('GRC', 8, 'Volume 8 - Ordering of the Camp\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc8.doc'),
('GRC', 9, 'Volume 9 - Purification And Life\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc9.doc'),
('GRC', 10, 'Volume 10 - The Gospel of the Glory\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc10.doc'),
('GRC', 11, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc11.doc'),
('GRC', 12, 'Volume 12 - The Grace and Government of God in Days of Recovery\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc12.doc'),
('GRC', 13, 'Volume 13 - Addresses and Readings\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc13.doc'),
('GRC', 14, 'Volume 14 - Spiritual Vision\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc14.doc'),
('GRC', 15, 'Volume 15 - The Times of the Nations\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc15.doc'),
('GRC', 16, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc16.doc'),
('GRC', 17, 'Booklet 1\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc17.doc'),
('GRC', 18, 'Booklet 2\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc18.doc'),
('GRC', 19, 'Booklet 3\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc19.doc'),
('GRC', 20, 'Booklet 4\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc20.doc'),
('GRC', 21, 'Booklet 5\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc21.doc'),
('GRC', 22, 'Booklet 6\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc22.doc'),
('GRC', 23, 'The Headship of Christ and of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc23.doc'),
('GRC', 24, 'Fundamental Truths of Christianity and The Kingdom of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc24.doc'),
('GRC', 25, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc25.doc'),
('GRC', 26, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc26.doc'),
('GRC', 27, 'Greatness And Other Ministry\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc27.doc'),
('GRC', 28, 'Departing from Iniquity or Inconsistency\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc28.doc'),
('GRC', 29, 'The Call of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc29.doc'),
('GRC', 30, 'The Choice of a Career\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc30.doc'),
('GRC', 31, 'The Deity of Christ\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc31.doc'),
('GRC', 32, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc32.doc'),
('GRC', 33, 'Houses Hallowed and Redeemed\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc33.doc'),
('GRC', 34, 'God Himself\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc34.doc'),
('GRC', 35, 'The Work of the Lord and the Service of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc35.doc'),
('GRC', 36, 'Giving and its Fruits\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc36.doc'),
('GRC', 37, 'The Supremacy of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc37.doc'),
('GRC', 38, 'The Name of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc38.doc'),
('GRC', 39, 'God Going Before His People\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc39.doc'),
('GRC', 40, 'Walking in the Light\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc40.doc'),
('GRC', 41, 'The Servant of the Lord\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc41.doc'),
('GRC', 42, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc42.doc'),
('GRC', 43, 'The Family, the Body and the Temple\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc43.doc'),
('GRC', 44, 'Our Access into the Presence of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc44.doc'),
('GRC', 45, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc45.doc'),
('GRC', 46, 'FOUNDATIONS\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc46.doc'),
('GRC', 47, 'CHRIST IN US\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc47.doc'),
('GRC', 48, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc48.doc'),
('GRC', 49, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc49.doc'),
('GRC', 50, 'Habitation of God in the Spirit\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc50.doc'),
('GRC', 51, 'The Priest with Urim and with Thummim\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc51.doc'),
('GRC', 52, 'The Shepherd and Bishop of our Souls\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc52.doc'),
('GRC', 53, 'The Gospel and the Church\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc53.doc'),
('GRC', 54, '"God is One"\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc54.doc'),
('GRC', 55, 'Four Aspects of the Call of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc55.doc'),
('GRC', 56, 'Lay Hold of Eternal Life\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc56.doc'),
('GRC', 57, 'Rest, Life, Food, Drink\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc57.doc'),
('GRC', 58, 'The Divinely Established System\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc58.doc'),
('GRC', 59, 'The Divine System\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc59.doc'),
('GRC', 60, 'Fellowship\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc60.doc'),
('GRC', 61, 'As a Man Thinks in His Heart so is He\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc61.doc'),
('GRC', 62, 'The Wall of The City\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc62.doc'),
('GRC', 63, 'Nazariteship\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc63.doc'),
('GRC', 64, 'Let Him That Boasts, Boast in the Lord\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc64.doc'),
('GRC', 65, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc65.doc'),
('GRC', 66, 'Christ as Foundation, Structure and Headstone\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc66.doc'),
('GRC', 67, 'Devotion to God and His Chief Interest on Earth - The House of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc67.doc'),
('GRC', 68, 'Our Standing on Divine Ground\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc68.doc'),
('GRC', 69, 'Loving Righteousness\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc69.doc'),
('GRC', 70, 'The Knowledge of the Son of God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc70.doc'),
('GRC', 71, 'The System, Position and Path\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc71.doc'),
('GRC', 72, 'Activities In Which We Are To Engage\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc72.doc'),
('GRC', 73, 'The Unveiling of the Glories of Jesus Christ\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc73.doc'),
('GRC', 74, 'Issues Involved in Present Exercises\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc74.doc'),
('GRC', 75, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc75.doc'),
('GRC', 76, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc76.doc'),
('GRC', 77, 'Levitical Service\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc77.doc'),
('GRC', 78, 'The Testimony of our Lord\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc78.doc'),
('GRC', 79, 'Living Water\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc79.doc'),
('GRC', 80, 'Living Bread\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc80.doc'),
('GRC', 81, 'Sound Teaching, Sound Words, Sound Mind\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc81.doc'),
('GRC', 82, 'The Body, the Kingdom, The House\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc82.doc'),
('GRC', 83, 'Communion With God\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc83.doc'),
('GRC', 84, 'Running, Walking And Standing\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc84.doc'),
('GRC', 85, 'Anchor of The Soul\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc85.doc'),
('GRC', 86, 'Help for those young in the Faith\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc86.doc'),
('GRC', 87, 'The Upward Way\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc87.doc'),
('GRC', 88, 'The Closing Ministry of the Dispensation\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\grc\\\\grc88.doc'),
('JBS', 1, '', '2006-12-16 09:17:08', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs1.doc'),
('JBS', 2, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs2.doc'),
('JBS', 3, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs3.doc'),
('JBS', 4, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs4.doc'),
('JBS', 5, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs5.doc'),
('JBS', 6, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs6.doc'),
('JBS', 7, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs7.doc'),
('JBS', 8, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs8.doc'),
('JBS', 9, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs9.doc'),
('JBS', 10, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs10.doc'),
('JBS', 11, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs11.doc'),
('JBS', 12, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs12.doc'),
('JBS', 13, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs13.doc'),
('JBS', 14, 'Letters 1\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs14.doc'),
('JBS', 15, 'Letters 2\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs15.doc'),
('JBS', 16, 'Letters 3\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs16.doc'),
('JBS', 17, 'From Glory to Glory\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs17.doc'),
('JT', 1, '', '2006-11-05 13:31:09', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt1.doc'),
('JT', 2, '', '2006-11-05 13:33:24', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt2.doc'),
('JT', 3, '', '2006-11-05 13:34:49', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt3.doc'),
('JT', 4, '', '2006-11-05 13:35:56', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt4.doc'),
('JT', 5, '', '2006-11-05 13:37:15', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt5.doc'),
('JT', 6, '', '2006-11-05 13:38:26', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt6.doc'),
('JT', 7, '', '2006-11-05 13:39:34', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt7.doc'),
('JT', 8, '', '2006-11-05 13:40:42', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt8.doc'),
('JT', 9, '', '2006-11-05 13:41:36', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt9.doc'),
('JT', 10, '', '2006-11-05 13:42:22', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt10.doc'),
('JT', 11, '', '2006-11-05 13:43:53', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt11.doc'),
('JT', 12, '', '2006-11-05 13:45:28', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt12.doc'),
('JT', 13, '', '2006-11-05 14:02:57', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt13.doc'),
('JT', 14, '', '2006-11-05 14:05:59', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt14.doc'),
('JT', 15, '', '2006-11-05 14:07:56', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt15.doc'),
('JT', 16, '', '2006-11-05 14:08:55', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt16.doc'),
('JT', 17, '', '2006-11-05 14:09:47', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt17.doc'),
('JT', 18, '', '2006-11-05 14:13:05', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt18.doc'),
('JT', 19, '', '2006-11-05 14:13:48', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt19.doc'),
('JT', 20, '', '2006-11-05 14:14:23', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt20.doc'),
('JT', 21, '', '2006-11-05 14:15:17', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt21.doc'),
('JT', 22, '', '2006-11-05 14:15:55', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt22.doc'),
('JT', 23, '', '2006-11-05 14:16:40', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt23.doc'),
('JT', 24, '', '2006-11-05 14:22:21', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt24.doc'),
('JT', 25, '', '2006-11-05 14:23:08', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt25.doc'),
('JT', 26, '', '2006-12-14 11:38:52', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt26.doc'),
('JT', 27, '', '2006-12-14 15:40:11', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt27.doc'),
('JT', 28, '', '2006-12-14 16:21:17', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt28.doc'),
('JT', 29, '', '2006-12-14 16:22:46', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt29.doc'),
('JT', 30, '', '2006-12-14 16:25:04', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt30.doc'),
('JT', 31, '', '2006-12-16 08:14:18', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt31.doc'),
('JT', 32, '', '2006-12-16 08:16:23', 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt32.doc'),
('JT', 33, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt33.doc'),
('JT', 34, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt34.doc'),
('JT', 35, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt35.doc'),
('JT', 36, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt36.doc'),
('JT', 37, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt37.doc'),
('JT', 38, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt38.doc'),
('JT', 39, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt39.doc'),
('JT', 40, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt40.doc'),
('JT', 41, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt41.doc'),
('JT', 42, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt42.doc'),
('JT', 43, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt43.doc'),
('JT', 44, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt44.doc'),
('JT', 45, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt45.doc'),
('JT', 46, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt46.doc'),
('JT', 47, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt47.doc'),
('JT', 48, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt48.doc'),
('JT', 49, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt49.doc'),
('JT', 50, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt50.doc'),
('JT', 51, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt51.doc'),
('JT', 52, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt52.doc'),
('JT', 53, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt53.doc'),
('JT', 54, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt54.doc'),
('JT', 55, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt55.doc'),
('JT', 56, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt56.doc'),
('JT', 57, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt57.doc'),
('JT', 58, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt58.doc'),
('JT', 59, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt59.doc'),
('JT', 60, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt60.doc'),
('JT', 61, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt61.doc'),
('JT', 62, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt62.doc'),
('JT', 63, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt63.doc'),
('JT', 64, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt64.doc'),
('JT', 65, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt65.doc'),
('JT', 66, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt66.doc'),
('JT', 67, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt67.doc'),
('JT', 68, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt68.doc'),
('JT', 69, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt69.doc'),
('JT', 70, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt70.doc'),
('JT', 71, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt71.doc'),
('JT', 72, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt72.doc'),
('JT', 73, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt73.doc'),
('JT', 74, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt74.doc'),
('JT', 75, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt75.doc'),
('JT', 76, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt76.doc'),
('JT', 77, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt77.doc'),
('JT', 78, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt78.doc'),
('JT', 79, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt79.doc'),
('JT', 80, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt80.doc'),
('JT', 81, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt81.doc'),
('JT', 82, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt82.doc'),
('JT', 83, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt83.doc'),
('JT', 84, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt84.doc'),
('JT', 85, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt85.doc'),
('JT', 86, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt86.doc'),
('JT', 87, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt87.doc'),
('JT', 88, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt88.doc'),
('JT', 89, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt89.doc'),
('JT', 90, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt90.doc'),
('JT', 91, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt91.doc'),
('JT', 92, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt92.doc'),
('JT', 93, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt93.doc'),
('JT', 94, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt94.doc'),
('JT', 95, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt95.doc'),
('JT', 96, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt96.doc'),
('JT', 97, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt97.doc'),
('JT', 98, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt98.doc'),
('JT', 99, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt99.doc'),
('JT', 100, '', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt100.doc'),
('JT', 101, 'Volume 100a\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt101.doc'),
('JT', 102, 'Letters - Volume 1\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt102.doc'),
('JT', 103, 'Letters - Volume 2\r\n', NULL, 'C:\\\\FB\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\best\\\\jt103.doc');
