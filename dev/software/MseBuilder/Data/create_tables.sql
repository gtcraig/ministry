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
-- Database: goodteaching_org_min
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
  fullname varchar(50) default NULL,
  orgname varchar(50) default NULL,
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

INSERT INTO mse_author VALUES ('CAC', 'C. A. Coates', 'Charles Andrew Coates', 'Coates, Charles');
INSERT INTO mse_author VALUES ('FER', 'F. E. Raven', 'Frederick Edward Raven', 'Raven, Frederick');
INSERT INTO mse_author VALUES ('GRC', 'G. R. Cowell', 'Gerald Robert Cowell', 'Cowell, Gerald ');
INSERT INTO mse_author VALUES ('JBS', 'J. B. Stoney', 'James Butler Stoney', 'Stoney, James');
INSERT INTO mse_author VALUES ('JND', 'J. N. Darby', 'John Nelson Darby', 'Darby, John');
INSERT INTO mse_author VALUES ('JT', 'J. Taylor, Snr', 'James Taylor, Snr', 'Taylor, James, Snr');
INSERT INTO mse_author VALUES ('VAR', 'Various', 'Various', 'Various');

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

--
-- Dumping data for table mse_volume
--

INSERT INTO mse_volume VALUES ('CAC', 1, 'V01 Outline of Genesis', '2006-12-16 08:18:51', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac1.txt');
INSERT INTO mse_volume VALUES ('CAC', 2, 'V02 Outline of Exodus', '2006-12-16 08:19:37', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac2.txt');
INSERT INTO mse_volume VALUES ('CAC', 3, 'V03 Outline of Leviticus', '2006-12-16 08:20:16', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac3.txt');
INSERT INTO mse_volume VALUES ('CAC', 4, 'V04 Outline of the Book of Numbers', '2006-12-16 08:22:50', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac4.txt');
INSERT INTO mse_volume VALUES ('CAC', 5, 'V05 Outline of the Book of Deuteronomy', '2006-12-16 08:23:38', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac5.txt');
INSERT INTO mse_volume VALUES ('CAC', 6, 'V06 Outline of Joshua, Judges and Ruth', '2006-12-16 08:32:45', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac6.txt');
INSERT INTO mse_volume VALUES ('CAC', 7, 'V07 Outline of The Song of Songs', '2006-12-16 08:34:49', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac7.txt');
INSERT INTO mse_volume VALUES ('CAC', 8, 'V08 Outline of the Minor Prophets', '2006-12-16 08:44:41', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac8.txt');
INSERT INTO mse_volume VALUES ('CAC', 9, 'V09 Outline of Mark Gospel and Other Ministry', '2006-12-16 09:11:21', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac9.txt');
INSERT INTO mse_volume VALUES ('CAC', 10, 'V10 Outline of Luke Gospel', '2006-12-16 09:14:38', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac10.txt');
INSERT INTO mse_volume VALUES ('CAC', 11, 'V11 Outline of Romans', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac11.txt');
INSERT INTO mse_volume VALUES ('CAC', 12, 'V12 Outline of the Epistle of James', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac12.txt');
INSERT INTO mse_volume VALUES ('CAC', 13, 'V13 Outline of "The Revelation"', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac13.txt');
INSERT INTO mse_volume VALUES ('CAC', 14, 'V14 The True Grace of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac14.txt');
INSERT INTO mse_volume VALUES ('CAC', 15, 'V15 The Believer Established', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac15.txt');
INSERT INTO mse_volume VALUES ('CAC', 16, 'V16 Favour and Freedom', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac16.txt');
INSERT INTO mse_volume VALUES ('CAC', 17, 'V17 The Food of Life', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac17.txt');
INSERT INTO mse_volume VALUES ('CAC', 18, 'V18 The House of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac18.txt');
INSERT INTO mse_volume VALUES ('CAC', 19, 'V19 The Paths of Life', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac19.txt');
INSERT INTO mse_volume VALUES ('CAC', 20, 'V20 Spiritual Blessings', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac20.txt');
INSERT INTO mse_volume VALUES ('CAC', 21, 'V21 A Sure Foundation', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac21.txt');
INSERT INTO mse_volume VALUES ('CAC', 22, 'V22 Letters of C.A. Coates', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac22.txt');
INSERT INTO mse_volume VALUES ('CAC', 23, 'V23 Outline of the Epistle to the Hebrews', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac23.txt');
INSERT INTO mse_volume VALUES ('CAC', 24, 'V24 Notes of Readings on the Lords Supper', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac24.txt');
INSERT INTO mse_volume VALUES ('CAC', 25, 'V25 Outlines of Corinthians', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac25.txt');
INSERT INTO mse_volume VALUES ('CAC', 26, 'V26 Outline of Ephesians', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac26.txt');
INSERT INTO mse_volume VALUES ('CAC', 27, 'V27 Outlines of Samuel, Kings and the Chronicles', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac27.txt');
INSERT INTO mse_volume VALUES ('CAC', 28, 'V28 Notes of Readings on Matthew Gospel', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac28.txt');
INSERT INTO mse_volume VALUES ('CAC', 29, 'V29 An Outline of John Gospel', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac29.txt');
INSERT INTO mse_volume VALUES ('CAC', 30, 'V30 Misc Ministry on OT', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac30.txt');
INSERT INTO mse_volume VALUES ('CAC', 31, 'V31 Misc Ministry on NT Matthew-Romans', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac31.txt');
INSERT INTO mse_volume VALUES ('CAC', 32, 'V32 Misc Ministry on NT Corinthians-Colossians', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac32.txt');
INSERT INTO mse_volume VALUES ('CAC', 33, 'V33 Misc Ministry on NT Thessalonians-Revelation', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac33.txt');
INSERT INTO mse_volume VALUES ('CAC', 34, 'V34 Words in Season', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac34.txt');
INSERT INTO mse_volume VALUES ('CAC', 35, 'V27a Outlines of the Books of the Chronicles', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac35.txt');
INSERT INTO mse_volume VALUES ('CAC', 36, 'Remarks on a pamphlet by A. J. Pollock entitled "The Eternal Son"', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac36.txt');
INSERT INTO mse_volume VALUES ('CAC', 37, 'A Message for You', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\cac\\\\cac37.txt');
INSERT INTO mse_volume VALUES ('FER', 1, 'V01 Volume 1', '2006-09-17 13:57:39', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer1.txt');
INSERT INTO mse_volume VALUES ('FER', 2, 'V02 Volume 2', '2006-09-17 14:06:44', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer2.txt');
INSERT INTO mse_volume VALUES ('FER', 3, 'V03 Volume 3', '2006-09-17 14:07:33', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer3.txt');
INSERT INTO mse_volume VALUES ('FER', 4, 'V04 Volume 4', '2006-04-04 22:04:55', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer4.txt');
INSERT INTO mse_volume VALUES ('FER', 5, 'V05 Volume 5', '2006-04-04 22:07:33', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer5.txt');
INSERT INTO mse_volume VALUES ('FER', 6, 'V06 Volume 6', '2006-04-04 22:09:56', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer6.txt');
INSERT INTO mse_volume VALUES ('FER', 7, 'V07 Volume 7', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer7.txt');
INSERT INTO mse_volume VALUES ('FER', 8, 'V08 Volume 8', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer8.txt');
INSERT INTO mse_volume VALUES ('FER', 9, 'V09 Volume 9', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer9.txt');
INSERT INTO mse_volume VALUES ('FER', 10, 'V10 Volume 10', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer10.txt');
INSERT INTO mse_volume VALUES ('FER', 11, 'V11 Volume 11', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer11.txt');
INSERT INTO mse_volume VALUES ('FER', 12, 'V12 Volume 12', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer12.txt');
INSERT INTO mse_volume VALUES ('FER', 13, 'V13 Volume 13', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer13.txt');
INSERT INTO mse_volume VALUES ('FER', 14, 'V14 Volume 14', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer14.txt');
INSERT INTO mse_volume VALUES ('FER', 15, 'V15 Volume 15', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer15.txt');
INSERT INTO mse_volume VALUES ('FER', 16, 'V16 Volume 16', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer16.txt');
INSERT INTO mse_volume VALUES ('FER', 17, 'V17 Volume 17', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer17.txt');
INSERT INTO mse_volume VALUES ('FER', 18, 'V18 Volume 18', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer18.txt');
INSERT INTO mse_volume VALUES ('FER', 19, 'V19 Volume 19', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer19.txt');
INSERT INTO mse_volume VALUES ('FER', 20, 'V20 Volume 20', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer20.txt');
INSERT INTO mse_volume VALUES ('FER', 21, 'Letters', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\fer\\\\fer21.txt');
INSERT INTO mse_volume VALUES ('GRC', 1, 'V01', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc1.txt');
INSERT INTO mse_volume VALUES ('GRC', 2, 'V02 - Greatness', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc2.txt');
INSERT INTO mse_volume VALUES ('GRC', 3, 'V03 - The Lord Jesus as seen in the Revelation', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc3.txt');
INSERT INTO mse_volume VALUES ('GRC', 4, 'V04 - The Sabbath Of Rest', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc4.txt');
INSERT INTO mse_volume VALUES ('GRC', 5, 'V05 - Devotion By Vow', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc5.txt');
INSERT INTO mse_volume VALUES ('GRC', 6, 'V06 - God With Us', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc6.txt');
INSERT INTO mse_volume VALUES ('GRC', 7, 'V07 - Progress In Recovery', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc7.txt');
INSERT INTO mse_volume VALUES ('GRC', 8, 'V08 - Ordering of the Camp', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc8.txt');
INSERT INTO mse_volume VALUES ('GRC', 9, 'V09 - Purification And Life', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc9.txt');
INSERT INTO mse_volume VALUES ('GRC', 10, 'V10 - The Gospel of the Glory', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc10.txt');
INSERT INTO mse_volume VALUES ('GRC', 11, 'V11', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc11.txt');
INSERT INTO mse_volume VALUES ('GRC', 12, 'V12 - The Grace and Government of God in Days of Recovery', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc12.txt');
INSERT INTO mse_volume VALUES ('GRC', 13, 'V13 - Addresses and Readings', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc13.txt');
INSERT INTO mse_volume VALUES ('GRC', 14, 'V14 - Spiritual Vision', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc14.txt');
INSERT INTO mse_volume VALUES ('GRC', 15, 'V15 - The Times of the Nations', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc15.txt');
INSERT INTO mse_volume VALUES ('GRC', 16, 'V16', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc16.txt');
INSERT INTO mse_volume VALUES ('GRC', 17, 'Booklet 1', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc17.txt');
INSERT INTO mse_volume VALUES ('GRC', 18, 'Booklet 2', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc18.txt');
INSERT INTO mse_volume VALUES ('GRC', 19, 'Booklet 3', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc19.txt');
INSERT INTO mse_volume VALUES ('GRC', 20, 'Booklet 4', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc20.txt');
INSERT INTO mse_volume VALUES ('GRC', 21, 'Booklet 5', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc21.txt');
INSERT INTO mse_volume VALUES ('GRC', 22, 'Booklet 6', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc22.txt');
INSERT INTO mse_volume VALUES ('GRC', 23, 'The Headship of Christ and of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc23.txt');
INSERT INTO mse_volume VALUES ('GRC', 24, 'Fundamental Truths of Christianity and The Kingdom of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc24.txt');
INSERT INTO mse_volume VALUES ('GRC', 25, 'V25', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc25.txt');
INSERT INTO mse_volume VALUES ('GRC', 26, 'V26', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc26.txt');
INSERT INTO mse_volume VALUES ('GRC', 27, 'Greatness And Other Ministry', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc27.txt');
INSERT INTO mse_volume VALUES ('GRC', 28, 'Departing from Iniquity or Inconsistency', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc28.txt');
INSERT INTO mse_volume VALUES ('GRC', 29, 'The Call of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc29.txt');
INSERT INTO mse_volume VALUES ('GRC', 30, 'The Choice of a Career', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc30.txt');
INSERT INTO mse_volume VALUES ('GRC', 31, 'The Deity of Christ', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc31.txt');
INSERT INTO mse_volume VALUES ('GRC', 32, 'V32', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc32.txt');
INSERT INTO mse_volume VALUES ('GRC', 33, 'Houses Hallowed and Redeemed', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc33.txt');
INSERT INTO mse_volume VALUES ('GRC', 34, 'God Himself', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc34.txt');
INSERT INTO mse_volume VALUES ('GRC', 35, 'The Work of the Lord and the Service of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc35.txt');
INSERT INTO mse_volume VALUES ('GRC', 36, 'Giving and its Fruits', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc36.txt');
INSERT INTO mse_volume VALUES ('GRC', 37, 'The Supremacy of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc37.txt');
INSERT INTO mse_volume VALUES ('GRC', 38, 'The Name of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc38.txt');
INSERT INTO mse_volume VALUES ('GRC', 39, 'God Going Before His People', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc39.txt');
INSERT INTO mse_volume VALUES ('GRC', 40, 'Walking in the Light', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc40.txt');
INSERT INTO mse_volume VALUES ('GRC', 41, 'The Servant of the Lord', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc41.txt');
INSERT INTO mse_volume VALUES ('GRC', 42, 'V42', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc42.txt');
INSERT INTO mse_volume VALUES ('GRC', 43, 'The Family, the Body and the Temple', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc43.txt');
INSERT INTO mse_volume VALUES ('GRC', 44, 'Our Access into the Presence of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc44.txt');
INSERT INTO mse_volume VALUES ('GRC', 45, 'V45', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc45.txt');
INSERT INTO mse_volume VALUES ('GRC', 46, 'FOUNDATIONS', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc46.txt');
INSERT INTO mse_volume VALUES ('GRC', 47, 'CHRIST IN US', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc47.txt');
INSERT INTO mse_volume VALUES ('GRC', 48, 'V48', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc48.txt');
INSERT INTO mse_volume VALUES ('GRC', 49, 'V49', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc49.txt');
INSERT INTO mse_volume VALUES ('GRC', 50, 'Habitation of God in the Spirit', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc50.txt');
INSERT INTO mse_volume VALUES ('GRC', 51, 'The Priest with Urim and with Thummim', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc51.txt');
INSERT INTO mse_volume VALUES ('GRC', 52, 'The Shepherd and Bishop of our Souls', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc52.txt');
INSERT INTO mse_volume VALUES ('GRC', 53, 'The Gospel and the Church', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc53.txt');
INSERT INTO mse_volume VALUES ('GRC', 54, '"God is One"', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc54.txt');
INSERT INTO mse_volume VALUES ('GRC', 55, 'Four Aspects of the Call of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc55.txt');
INSERT INTO mse_volume VALUES ('GRC', 56, 'Lay Hold of Eternal Life', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc56.txt');
INSERT INTO mse_volume VALUES ('GRC', 57, 'Rest, Life, Food, Drink', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc57.txt');
INSERT INTO mse_volume VALUES ('GRC', 58, 'The Divinely Established System', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc58.txt');
INSERT INTO mse_volume VALUES ('GRC', 59, 'The Divine System', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc59.txt');
INSERT INTO mse_volume VALUES ('GRC', 60, 'Fellowship', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc60.txt');
INSERT INTO mse_volume VALUES ('GRC', 61, 'As a Man Thinks in His Heart so is He', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc61.txt');
INSERT INTO mse_volume VALUES ('GRC', 62, 'The Wall of The City', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc62.txt');
INSERT INTO mse_volume VALUES ('GRC', 63, 'Nazariteship', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc63.txt');
INSERT INTO mse_volume VALUES ('GRC', 64, 'Let Him That Boasts, Boast in the Lord', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc64.txt');
INSERT INTO mse_volume VALUES ('GRC', 65, 'V65', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc65.txt');
INSERT INTO mse_volume VALUES ('GRC', 66, 'Christ as Foundation, Structure and Headstone', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc66.txt');
INSERT INTO mse_volume VALUES ('GRC', 67, 'Devotion to God and His Chief Interest on Earth - The House of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc67.txt');
INSERT INTO mse_volume VALUES ('GRC', 68, 'Our Standing on Divine Ground', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc68.txt');
INSERT INTO mse_volume VALUES ('GRC', 69, 'Loving Righteousness', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc69.txt');
INSERT INTO mse_volume VALUES ('GRC', 70, 'The Knowledge of the Son of God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc70.txt');
INSERT INTO mse_volume VALUES ('GRC', 71, 'The System, Position and Path', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc71.txt');
INSERT INTO mse_volume VALUES ('GRC', 72, 'Activities In Which We Are To Engage', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc72.txt');
INSERT INTO mse_volume VALUES ('GRC', 73, 'The Unveiling of the Glories of Jesus Christ', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc73.txt');
INSERT INTO mse_volume VALUES ('GRC', 74, 'Issues Involved in Present Exercises', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc74.txt');
INSERT INTO mse_volume VALUES ('GRC', 75, 'V75', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc75.txt');
INSERT INTO mse_volume VALUES ('GRC', 76, 'V76', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc76.txt');
INSERT INTO mse_volume VALUES ('GRC', 77, 'Levitical Service', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc77.txt');
INSERT INTO mse_volume VALUES ('GRC', 78, 'The Testimony of our Lord', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc78.txt');
INSERT INTO mse_volume VALUES ('GRC', 79, 'Living Water', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc79.txt');
INSERT INTO mse_volume VALUES ('GRC', 80, 'Living Bread', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc80.txt');
INSERT INTO mse_volume VALUES ('GRC', 81, 'Sound Teaching, Sound Words, Sound Mind', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc81.txt');
INSERT INTO mse_volume VALUES ('GRC', 82, 'The Body, the Kingdom, The House', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc82.txt');
INSERT INTO mse_volume VALUES ('GRC', 83, 'Communion With God', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc83.txt');
INSERT INTO mse_volume VALUES ('GRC', 84, 'Running, Walking And Standing', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc84.txt');
INSERT INTO mse_volume VALUES ('GRC', 85, 'Anchor of The Soul', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc85.txt');
INSERT INTO mse_volume VALUES ('GRC', 86, 'Help for those young in the Faith', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc86.txt');
INSERT INTO mse_volume VALUES ('GRC', 87, 'The Upward Way', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc87.txt');
INSERT INTO mse_volume VALUES ('GRC', 88, 'The Closing Ministry of the Dispensation', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\grc\\\\grc88.txt');
INSERT INTO mse_volume VALUES ('JBS', 1, 'V01 Volume 1', '2006-12-16 09:17:08', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs1.txt');
INSERT INTO mse_volume VALUES ('JBS', 2, 'V02 Volume 2', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs2.txt');
INSERT INTO mse_volume VALUES ('JBS', 3, 'V03 Volume 3', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs3.txt');
INSERT INTO mse_volume VALUES ('JBS', 4, 'V04 Volume 4', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs4.txt');
INSERT INTO mse_volume VALUES ('JBS', 5, 'V05 Volume 5', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs5.txt');
INSERT INTO mse_volume VALUES ('JBS', 6, 'V06 Volume 6', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs6.txt');
INSERT INTO mse_volume VALUES ('JBS', 7, 'V07 Volume 7', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs7.txt');
INSERT INTO mse_volume VALUES ('JBS', 8, 'V08 Volume 8', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs8.txt');
INSERT INTO mse_volume VALUES ('JBS', 9, 'V09 Volume 9', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs9.txt');
INSERT INTO mse_volume VALUES ('JBS', 10, 'V10 Volume 10', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs10.txt');
INSERT INTO mse_volume VALUES ('JBS', 11, 'V11 Volume 11', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs11.txt');
INSERT INTO mse_volume VALUES ('JBS', 12, 'V12 Volume 12', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs12.txt');
INSERT INTO mse_volume VALUES ('JBS', 13, 'V13 Volume 13', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs13.txt');
INSERT INTO mse_volume VALUES ('JBS', 14, 'Letters 1', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs14.txt');
INSERT INTO mse_volume VALUES ('JBS', 15, 'Letters 2', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs15.txt');
INSERT INTO mse_volume VALUES ('JBS', 16, 'Letters 3', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs16.txt');
INSERT INTO mse_volume VALUES ('JBS', 17, 'From Glory to Glory', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jbs\\\\jbs17.txt');
INSERT INTO mse_volume VALUES ('JT', 1, 'V001 Volume 1', '2006-11-05 13:31:09', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt1.txt');
INSERT INTO mse_volume VALUES ('JT', 2, 'V002 Volume 2', '2006-11-05 13:33:24', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt2.txt');
INSERT INTO mse_volume VALUES ('JT', 3, 'V003 Volume 3', '2006-11-05 13:34:49', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt3.txt');
INSERT INTO mse_volume VALUES ('JT', 4, 'V004 Volume 4', '2006-11-05 13:35:56', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt4.txt');
INSERT INTO mse_volume VALUES ('JT', 5, 'V005 Volume 5', '2006-11-05 13:37:15', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt5.txt');
INSERT INTO mse_volume VALUES ('JT', 6, 'V006 Volume 6', '2006-11-05 13:38:26', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt6.txt');
INSERT INTO mse_volume VALUES ('JT', 7, 'V007 Volume 7', '2006-11-05 13:39:34', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt7.txt');
INSERT INTO mse_volume VALUES ('JT', 8, 'V008 Volume 8', '2006-11-05 13:40:42', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt8.txt');
INSERT INTO mse_volume VALUES ('JT', 9, 'V009 Volume 9', '2006-11-05 13:41:36', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt9.txt');
INSERT INTO mse_volume VALUES ('JT', 10, 'V010 Volume 10', '2006-11-05 13:42:22', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt10.txt');
INSERT INTO mse_volume VALUES ('JT', 11, 'V011 Volume 11', '2006-11-05 13:43:53', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt11.txt');
INSERT INTO mse_volume VALUES ('JT', 12, 'V012 Volume 12', '2006-11-05 13:45:28', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt12.txt');
INSERT INTO mse_volume VALUES ('JT', 13, 'V013 Volume 13', '2006-11-05 14:02:57', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt13.txt');
INSERT INTO mse_volume VALUES ('JT', 14, 'V014 Volume 14', '2006-11-05 14:05:59', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt14.txt');
INSERT INTO mse_volume VALUES ('JT', 15, 'V015 Volume 15', '2006-11-05 14:07:56', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt15.txt');
INSERT INTO mse_volume VALUES ('JT', 16, 'V016 Volume 16', '2006-11-05 14:08:55', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt16.txt');
INSERT INTO mse_volume VALUES ('JT', 17, 'V017 Volume 17', '2006-11-05 14:09:47', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt17.txt');
INSERT INTO mse_volume VALUES ('JT', 18, 'V018 Volume 18', '2006-11-05 14:13:05', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt18.txt');
INSERT INTO mse_volume VALUES ('JT', 19, 'V019 Volume 19', '2006-11-05 14:13:48', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt19.txt');
INSERT INTO mse_volume VALUES ('JT', 20, 'V020 Volume 20', '2006-11-05 14:14:23', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt20.txt');
INSERT INTO mse_volume VALUES ('JT', 21, 'V021 Volume 21', '2006-11-05 14:15:17', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt21.txt');
INSERT INTO mse_volume VALUES ('JT', 22, 'V022 Volume 22', '2006-11-05 14:15:55', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt22.txt');
INSERT INTO mse_volume VALUES ('JT', 23, 'V023 Volume 23', '2006-11-05 14:16:40', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt23.txt');
INSERT INTO mse_volume VALUES ('JT', 24, 'V024 Volume 24', '2006-11-05 14:22:21', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt24.txt');
INSERT INTO mse_volume VALUES ('JT', 25, 'V025 Volume 25', '2006-11-05 14:23:08', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt25.txt');
INSERT INTO mse_volume VALUES ('JT', 26, 'V026 Volume 26', '2006-12-14 11:38:52', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt26.txt');
INSERT INTO mse_volume VALUES ('JT', 27, 'V027 Volume 27', '2006-12-14 15:40:11', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt27.txt');
INSERT INTO mse_volume VALUES ('JT', 28, 'V028 Volume 28', '2006-12-14 16:21:17', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt28.txt');
INSERT INTO mse_volume VALUES ('JT', 29, 'V029 Volume 29', '2006-12-14 16:22:46', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt29.txt');
INSERT INTO mse_volume VALUES ('JT', 30, 'V030 Volume 30', '2006-12-14 16:25:04', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt30.txt');
INSERT INTO mse_volume VALUES ('JT', 31, 'V031 Volume 31', '2006-12-16 08:14:18', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt31.txt');
INSERT INTO mse_volume VALUES ('JT', 32, 'V032 Volume 32', '2006-12-16 08:16:23', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt32.txt');
INSERT INTO mse_volume VALUES ('JT', 33, 'V033 Volume 33', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt33.txt');
INSERT INTO mse_volume VALUES ('JT', 34, 'V034 Volume 34', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt34.txt');
INSERT INTO mse_volume VALUES ('JT', 35, 'V035 Volume 35', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt35.txt');
INSERT INTO mse_volume VALUES ('JT', 36, 'V036 Volume 36', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt36.txt');
INSERT INTO mse_volume VALUES ('JT', 37, 'V037 Volume 37', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt37.txt');
INSERT INTO mse_volume VALUES ('JT', 38, 'V038 Volume 38', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt38.txt');
INSERT INTO mse_volume VALUES ('JT', 39, 'V039 Volume 39', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt39.txt');
INSERT INTO mse_volume VALUES ('JT', 40, 'V040 Volume 40', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt40.txt');
INSERT INTO mse_volume VALUES ('JT', 41, 'V041 Volume 41', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt41.txt');
INSERT INTO mse_volume VALUES ('JT', 42, 'V042 Volume 42', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt42.txt');
INSERT INTO mse_volume VALUES ('JT', 43, 'V043 Volume 43', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt43.txt');
INSERT INTO mse_volume VALUES ('JT', 44, 'V044 Volume 44', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt44.txt');
INSERT INTO mse_volume VALUES ('JT', 45, 'V045 Volume 45', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt45.txt');
INSERT INTO mse_volume VALUES ('JT', 46, 'V046 Volume 46', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt46.txt');
INSERT INTO mse_volume VALUES ('JT', 47, 'V047 Volume 47', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt47.txt');
INSERT INTO mse_volume VALUES ('JT', 48, 'V048 Volume 48', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt48.txt');
INSERT INTO mse_volume VALUES ('JT', 49, 'V049 Volume 49', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt49.txt');
INSERT INTO mse_volume VALUES ('JT', 50, 'V050 Divine Names', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt50.txt');
INSERT INTO mse_volume VALUES ('JT', 51, 'V051 Volume 51', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt51.txt');
INSERT INTO mse_volume VALUES ('JT', 52, 'V052 Volume 52', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt52.txt');
INSERT INTO mse_volume VALUES ('JT', 53, 'V053 Volume 53', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt53.txt');
INSERT INTO mse_volume VALUES ('JT', 54, 'V054 Volume 54', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt54.txt');
INSERT INTO mse_volume VALUES ('JT', 55, 'V055 Volume 55', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt55.txt');
INSERT INTO mse_volume VALUES ('JT', 56, 'V056 Volume 56', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt56.txt');
INSERT INTO mse_volume VALUES ('JT', 57, 'V057 Volume 57', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt57.txt');
INSERT INTO mse_volume VALUES ('JT', 58, 'V058 Volume 58', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt58.txt');
INSERT INTO mse_volume VALUES ('JT', 59, 'V059 Volume 59', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt59.txt');
INSERT INTO mse_volume VALUES ('JT', 60, 'V060 Volume 60', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt60.txt');
INSERT INTO mse_volume VALUES ('JT', 61, 'V061 Volume 61', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt61.txt');
INSERT INTO mse_volume VALUES ('JT', 62, 'V062 Volume 62', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt62.txt');
INSERT INTO mse_volume VALUES ('JT', 63, 'V063 Volume 63', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt63.txt');
INSERT INTO mse_volume VALUES ('JT', 64, 'V064 Volume 64', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt64.txt');
INSERT INTO mse_volume VALUES ('JT', 65, 'V065 Volume 65', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt65.txt');
INSERT INTO mse_volume VALUES ('JT', 66, 'V066 Volume 66', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt66.txt');
INSERT INTO mse_volume VALUES ('JT', 67, 'V067 Volume 67', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt67.txt');
INSERT INTO mse_volume VALUES ('JT', 68, 'V068 Volume 68', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt68.txt');
INSERT INTO mse_volume VALUES ('JT', 69, 'V069 Volume 69', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt69.txt');
INSERT INTO mse_volume VALUES ('JT', 70, 'V070 Volume 70', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt70.txt');
INSERT INTO mse_volume VALUES ('JT', 71, 'V071 Volume 71', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt71.txt');
INSERT INTO mse_volume VALUES ('JT', 72, 'V072 Volume 72', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt72.txt');
INSERT INTO mse_volume VALUES ('JT', 73, 'V073 Volume 73', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt73.txt');
INSERT INTO mse_volume VALUES ('JT', 74, 'V074 Volume 74', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt74.txt');
INSERT INTO mse_volume VALUES ('JT', 75, 'V075 Volume 75', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt75.txt');
INSERT INTO mse_volume VALUES ('JT', 76, 'V076 Volume 76', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt76.txt');
INSERT INTO mse_volume VALUES ('JT', 77, 'V077 Volume 77', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt77.txt');
INSERT INTO mse_volume VALUES ('JT', 78, 'V078 Volume 78', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt78.txt');
INSERT INTO mse_volume VALUES ('JT', 79, 'V079 Volume 79', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt79.txt');
INSERT INTO mse_volume VALUES ('JT', 80, 'V080 Volume 80', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt80.txt');
INSERT INTO mse_volume VALUES ('JT', 81, 'V081 Volume 81', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt81.txt');
INSERT INTO mse_volume VALUES ('JT', 82, 'V082 Volume 82', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt82.txt');
INSERT INTO mse_volume VALUES ('JT', 83, 'V083 Volume 83', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt83.txt');
INSERT INTO mse_volume VALUES ('JT', 84, 'V084 Volume 84', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt84.txt');
INSERT INTO mse_volume VALUES ('JT', 85, 'V085 Volume 85', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt85.txt');
INSERT INTO mse_volume VALUES ('JT', 86, 'V086 Volume 86', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt86.txt');
INSERT INTO mse_volume VALUES ('JT', 87, 'V087 Volume 87', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt87.txt');
INSERT INTO mse_volume VALUES ('JT', 88, 'V088 Volume 88', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt88.txt');
INSERT INTO mse_volume VALUES ('JT', 89, 'V089 Volume 89', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt89.txt');
INSERT INTO mse_volume VALUES ('JT', 90, 'V090 Volume 90', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt90.txt');
INSERT INTO mse_volume VALUES ('JT', 91, 'V091 Volume 91', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt91.txt');
INSERT INTO mse_volume VALUES ('JT', 92, 'V092 Volume 92', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt92.txt');
INSERT INTO mse_volume VALUES ('JT', 93, 'V093 Volume 93', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt93.txt');
INSERT INTO mse_volume VALUES ('JT', 94, 'V094 Volume 94', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt94.txt');
INSERT INTO mse_volume VALUES ('JT', 95, 'V095 Volume 95', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt95.txt');
INSERT INTO mse_volume VALUES ('JT', 96, 'V096 Volume 96', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt96.txt');
INSERT INTO mse_volume VALUES ('JT', 97, 'V097 Volume 97', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt97.txt');
INSERT INTO mse_volume VALUES ('JT', 98, 'V098 Volume 98', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt98.txt');
INSERT INTO mse_volume VALUES ('JT', 99, 'V099 Volume 99', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt99.txt');
INSERT INTO mse_volume VALUES ('JT', 100, 'V100 Volume 100', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt100.txt');
INSERT INTO mse_volume VALUES ('JT', 101, 'V100a', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt101.txt');
INSERT INTO mse_volume VALUES ('JT', 102, 'Letters - Vol 1', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt102.txt');
INSERT INTO mse_volume VALUES ('JT', 103, 'Letters - Vol 2', NULL, 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jt\\\\jt103.txt');
INSERT INTO mse_volume VALUES ('JND', 1, 'CW V01 Ecclesiastical 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd1.txt');
INSERT INTO mse_volume VALUES ('JND', 2, 'CW V02 Prophetic 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd2.txt');
INSERT INTO mse_volume VALUES ('JND', 3, 'CW V03 Doctrinal 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd3.txt');
INSERT INTO mse_volume VALUES ('JND', 4, 'CW V04 Ecclesiastical 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd4.txt');
INSERT INTO mse_volume VALUES ('JND', 5, 'CW V05 Prophetic 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd5.txt');
INSERT INTO mse_volume VALUES ('JND', 6, 'CW V06 Apologetic 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd6.txt');
INSERT INTO mse_volume VALUES ('JND', 7, 'CW V07 Doctrinal 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd7.txt');
INSERT INTO mse_volume VALUES ('JND', 8, 'CW V08 Prophetic 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd8.txt');
INSERT INTO mse_volume VALUES ('JND', 9, 'CW V09 Apologetic 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd9.txt');
INSERT INTO mse_volume VALUES ('JND', 10, 'CW V10 Doctrinal 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd10.txt');
INSERT INTO mse_volume VALUES ('JND', 11, 'CW V11 Prophetic 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd11.txt');
INSERT INTO mse_volume VALUES ('JND', 12, 'CW V12 Evangelical 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd12.txt');
INSERT INTO mse_volume VALUES ('JND', 13, 'CW V13 Critical 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd13.txt');
INSERT INTO mse_volume VALUES ('JND', 14, 'CW V14 Ecclesiastical 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd14.txt');
INSERT INTO mse_volume VALUES ('JND', 15, 'CW V15 Doctrinal 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd15.txt');
INSERT INTO mse_volume VALUES ('JND', 16, 'CW V16 Practical 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd16.txt');
INSERT INTO mse_volume VALUES ('JND', 17, 'CW V17 Practical 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd17.txt');
INSERT INTO mse_volume VALUES ('JND', 18, 'CW V18 Doctrinal 5', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd18.txt');
INSERT INTO mse_volume VALUES ('JND', 19, 'CW V19 Expository 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd19.txt');
INSERT INTO mse_volume VALUES ('JND', 20, 'CW V20 Ecclesiastical 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd20.txt');
INSERT INTO mse_volume VALUES ('JND', 21, 'CW V21 Evangelical 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd21.txt');
INSERT INTO mse_volume VALUES ('JND', 22, 'CW V22 Doctrinal 6', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd22.txt');
INSERT INTO mse_volume VALUES ('JND', 23, 'CW V23 Doctrinal 7', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd23.txt');
INSERT INTO mse_volume VALUES ('JND', 24, 'CW V24 Expository 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd24.txt');
INSERT INTO mse_volume VALUES ('JND', 25, 'CW V25 Expository 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd25.txt');
INSERT INTO mse_volume VALUES ('JND', 26, 'CW V26 Expository 5', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd26.txt');
INSERT INTO mse_volume VALUES ('JND', 27, 'CW V27 Expository 6', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd27.txt');
INSERT INTO mse_volume VALUES ('JND', 28, 'CW V28 Expository 7', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd28.txt');
INSERT INTO mse_volume VALUES ('JND', 29, 'CW V29 Doctrinal 8', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd29.txt');
INSERT INTO mse_volume VALUES ('JND', 30, 'CW V30 Expository 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd30.txt');
INSERT INTO mse_volume VALUES ('JND', 31, 'CW V31 Doctrinal 9', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd31.txt');
INSERT INTO mse_volume VALUES ('JND', 32, 'CW V32 Misc 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd32.txt');
INSERT INTO mse_volume VALUES ('JND', 33, 'CW V33 Misc 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd33.txt');
INSERT INTO mse_volume VALUES ('JND', 34, 'CW V34 Misc 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd34.txt');
INSERT INTO mse_volume VALUES ('JND', 35, 'N&C V01', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd35.txt');
INSERT INTO mse_volume VALUES ('JND', 36, 'N&C V02', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd36.txt');
INSERT INTO mse_volume VALUES ('JND', 37, 'N&C V03', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd37.txt');
INSERT INTO mse_volume VALUES ('JND', 38, 'N&C V04', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd38.txt');
INSERT INTO mse_volume VALUES ('JND', 39, 'N&C V05', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd39.txt');
INSERT INTO mse_volume VALUES ('JND', 40, 'N&C V06', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd40.txt');
INSERT INTO mse_volume VALUES ('JND', 41, 'N&C V07', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd41.txt');
INSERT INTO mse_volume VALUES ('JND', 42, 'N&C Notes and Jottings', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd42.txt');
INSERT INTO mse_volume VALUES ('JND', 43, 'Synopsis V01 Genesis to 2 Chronicles', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd43.txt');
INSERT INTO mse_volume VALUES ('JND', 44, 'Synopsis V02 Ezra to Malachi', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd44.txt');
INSERT INTO mse_volume VALUES ('JND', 45, 'Synopsis V03 Matthew to John', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd45.txt');
INSERT INTO mse_volume VALUES ('JND', 46, 'Synopsis V04 Acts to Philippians', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd46.txt');
INSERT INTO mse_volume VALUES ('JND', 47, 'Synopsis V05 Colossians to Revelation', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd47.txt');
INSERT INTO mse_volume VALUES ('JND', 48, 'Misc The World or Christ?', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd48.txt');
INSERT INTO mse_volume VALUES ('JND', 49, 'Misc What the World is and how a Christian can live in it', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd49.txt');
INSERT INTO mse_volume VALUES ('JND', 50, 'Letters V01', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd50.txt');
INSERT INTO mse_volume VALUES ('JND', 51, 'Letters V02', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd51.txt');
INSERT INTO mse_volume VALUES ('JND', 52, 'Letters V03', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\jnd\\\\jnd52.txt');
