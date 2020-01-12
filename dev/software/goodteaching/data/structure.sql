-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2009,2019 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- Who  When         Why
-- CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
-- CAM  11-May-2008  10263 : Added missing tables/columns for development.
-- CAM  18-May-2008  10267 : Added mse_release_history.
-- CAM  28-Mar-2009  10407 : Added member and member_type.
-- CAM  29-Dec-2009  10514 : Structure only.
-- CAM  29-Dec-2009  10515 : UTF16 charsets where required.
-- CAM  23-Jan-2010  10551 : Added mse_volume_jndhtml.
-- CAM  28-Dec-2011  gc005 : Added fullname and orgname to Author and removed mse_volume_jndhtml.
-- CAM  15-Dec-2019  410113 : Added hymn_tune.
-- --------------------------------------------------------

USE goodteaching_org_min;

--
-- To recreate this file, dump data for ALL tables with structure, no data:
--

-- --------------------------------------------------------
-- DELETE ALL FROM THIS SECTION DOWNWARDS, THEN PASTE NEW
-- --------------------------------------------------------

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
CREATE TABLE IF NOT EXISTS `authors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `firstnames` varchar(50) DEFAULT NULL,
  `author_life` varchar(50) DEFAULT NULL,
  `bio_url` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10000 ;

-- --------------------------------------------------------

--
-- Table structure for table `hymn`
--

DROP TABLE IF EXISTS `hymn`;
CREATE TABLE IF NOT EXISTS `hymn` (
  `hymn_no` int(10) NOT NULL DEFAULT '0',
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int(11) DEFAULT NULL,
  `author_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_categories`
--

DROP TABLE IF EXISTS `hymn_categories`;
CREATE TABLE IF NOT EXISTS `hymn_categories` (
  `hymn_no` int(10) unsigned NOT NULL DEFAULT '0',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Hymn Categories';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_de`
--

DROP TABLE IF EXISTS `hymn_de`;
CREATE TABLE IF NOT EXISTS `hymn_de` (
  `hymn_no` int(10) NOT NULL DEFAULT '0',
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int(11) DEFAULT NULL,
  `author_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line`
--

DROP TABLE IF EXISTS `hymn_line`;
CREATE TABLE IF NOT EXISTS `hymn_line` (
  `hymn_no` int(10) NOT NULL DEFAULT '0',
  `vers_no` int(10) NOT NULL DEFAULT '0',
  `line_no` int(10) NOT NULL DEFAULT '0',
  `line_text` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`),
  FULLTEXT KEY `LINE_SEARCH` (`line_text`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line_de`
--

DROP TABLE IF EXISTS `hymn_line_de`;
CREATE TABLE IF NOT EXISTS `hymn_line_de` (
  `hymn_no` int(10) NOT NULL DEFAULT '0',
  `vers_no` int(10) NOT NULL DEFAULT '0',
  `line_no` int(10) NOT NULL DEFAULT '0',
  `line_text` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`),
  FULLTEXT KEY `LINE_SEARCH` (`line_text`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line_nl`
--

DROP TABLE IF EXISTS `hymn_line_nl`;
CREATE TABLE IF NOT EXISTS `hymn_line_nl` (
  `hymn_no` int(10) NOT NULL DEFAULT '0',
  `vers_no` int(10) NOT NULL DEFAULT '0',
  `line_no` int(10) NOT NULL DEFAULT '0',
  `line_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`),
  FULLTEXT KEY `LINE_SEARCH` (`line_text`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_meter`
--

DROP TABLE IF EXISTS `hymn_meter`;
CREATE TABLE IF NOT EXISTS `hymn_meter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meter` varchar(50) NOT NULL DEFAULT '',
  `rhythm` varchar(50) DEFAULT NULL,
  `chorus` varchar(50) DEFAULT NULL,
  `disp_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Hymn Meters' AUTO_INCREMENT=138 ;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_nl`
--

DROP TABLE IF EXISTS `hymn_nl`;
CREATE TABLE IF NOT EXISTS `hymn_nl` (
  `hymn_no` int(10) NOT NULL DEFAULT '0',
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int(11) DEFAULT NULL,
  `author_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_schemes`
--

DROP TABLE IF EXISTS `hymn_schemes`;
CREATE TABLE IF NOT EXISTS `hymn_schemes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(3) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Hymn Schemes' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_scheme_categories`
--

DROP TABLE IF EXISTS `hymn_scheme_categories`;
CREATE TABLE IF NOT EXISTS `hymn_scheme_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(3) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `scheme_id` int(10) unsigned NOT NULL DEFAULT '0',
  `disp_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Hymn Scheme Categories' AUTO_INCREMENT=15 ;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_tune`
--

DROP TABLE IF EXISTS `hymn_tune`;
CREATE TABLE IF NOT EXISTS `hymn_tune` (
  `tune_id` int(11) NOT NULL AUTO_INCREMENT,
  `tune_no` int(3) DEFAULT NULL,
  `tune_name` varchar(32) DEFAULT NULL,
  `meter_id` int(2) DEFAULT NULL,
  `alt_meter` varchar(16) DEFAULT NULL,
  `tune_book` varchar(5) DEFAULT NULL,
  `tune_book_name` varchar(10) DEFAULT NULL,
  `tune_author` varchar(36) DEFAULT NULL,
  `note` varchar(76) DEFAULT NULL,
  `tune_url` varchar(87) DEFAULT NULL,
  PRIMARY KEY (`tune_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Hymn Tunes' AUTO_INCREMENT=757 ;

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `memberid` varchar(20) NOT NULL DEFAULT '',
  `first_name` varchar(25) NOT NULL DEFAULT '',
  `last_name` varchar(25) NOT NULL DEFAULT '',
  `email_address` varchar(255) DEFAULT NULL,
  `password` varchar(50) NOT NULL DEFAULT '',
  `admin` int(1) DEFAULT '0',
  `member_type` char(2) NOT NULL DEFAULT 'N',
  `verify_code` varchar(100) NOT NULL DEFAULT '',
  `active` int(1) NOT NULL DEFAULT '0',
  `dob` date NOT NULL DEFAULT '0000-00-00',
  `signup_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`memberid`),
  KEY `i_email_address` (`email_address`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Information';

-- --------------------------------------------------------

--
-- Table structure for table `member_type`
--

DROP TABLE IF EXISTS `member_type`;
CREATE TABLE IF NOT EXISTS `member_type` (
  `member_type` char(2) NOT NULL DEFAULT '',
  `type_name` varchar(50) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `disp_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`member_type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Types';

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
  `newpages` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`author`,`vol`,`page`,`para`),
  KEY `inits` (`inits`),
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
