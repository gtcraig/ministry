-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 06, 2026 at 12:15 AM
-- Server version: 8.4.7
-- PHP Version: 8.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `goodteaching_org_min`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
CREATE TABLE IF NOT EXISTS `authors` (
  `id` int UNSIGNED NOT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `firstnames` varchar(50) DEFAULT NULL,
  `author_life` varchar(50) DEFAULT NULL,
  `bio_url` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn`
--

DROP TABLE IF EXISTS `hymn`;
CREATE TABLE IF NOT EXISTS `hymn` (
  `hymn_no` int NOT NULL DEFAULT '0',
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int DEFAULT NULL,
  `author_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_categories`
--

DROP TABLE IF EXISTS `hymn_categories`;
CREATE TABLE IF NOT EXISTS `hymn_categories` (
  `hymn_no` int UNSIGNED NOT NULL DEFAULT '0',
  `category_id` int UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Hymn Categories';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_de`
--

DROP TABLE IF EXISTS `hymn_de`;
CREATE TABLE IF NOT EXISTS `hymn_de` (
  `hymn_no` int NOT NULL DEFAULT '0',
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int DEFAULT NULL,
  `author_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_it`
--

DROP TABLE IF EXISTS `hymn_it`;
CREATE TABLE IF NOT EXISTS `hymn_it` (
  `hymn_no` int NOT NULL DEFAULT '0',
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int DEFAULT NULL,
  `author_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line`
--

DROP TABLE IF EXISTS `hymn_line`;
CREATE TABLE IF NOT EXISTS `hymn_line` (
  `hymn_no` int NOT NULL DEFAULT '0',
  `vers_no` int NOT NULL DEFAULT '0',
  `line_no` int NOT NULL DEFAULT '0',
  `line_text` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line_de`
--

DROP TABLE IF EXISTS `hymn_line_de`;
CREATE TABLE IF NOT EXISTS `hymn_line_de` (
  `hymn_no` int NOT NULL DEFAULT '0',
  `vers_no` int NOT NULL DEFAULT '0',
  `line_no` int NOT NULL DEFAULT '0',
  `line_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line_it`
--

DROP TABLE IF EXISTS `hymn_line_it`;
CREATE TABLE IF NOT EXISTS `hymn_line_it` (
  `hymn_no` int NOT NULL DEFAULT '0',
  `vers_no` int NOT NULL DEFAULT '0',
  `line_no` int NOT NULL DEFAULT '0',
  `line_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line_nl`
--

DROP TABLE IF EXISTS `hymn_line_nl`;
CREATE TABLE IF NOT EXISTS `hymn_line_nl` (
  `hymn_no` int NOT NULL DEFAULT '0',
  `vers_no` int NOT NULL DEFAULT '0',
  `line_no` int NOT NULL DEFAULT '0',
  `line_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_meter`
--

DROP TABLE IF EXISTS `hymn_meter`;
CREATE TABLE IF NOT EXISTS `hymn_meter` (
  `id` int NOT NULL,
  `meter` varchar(50) NOT NULL DEFAULT '',
  `rhythm` varchar(50) DEFAULT NULL,
  `chorus` varchar(50) DEFAULT NULL,
  `disp_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Hymn Meters';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_nl`
--

DROP TABLE IF EXISTS `hymn_nl`;
CREATE TABLE IF NOT EXISTS `hymn_nl` (
  `hymn_no` int NOT NULL DEFAULT '0',
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int DEFAULT NULL,
  `author_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`hymn_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_schemes`
--

DROP TABLE IF EXISTS `hymn_schemes`;
CREATE TABLE IF NOT EXISTS `hymn_schemes` (
  `id` int UNSIGNED NOT NULL,
  `code` char(3) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Hymn Schemes';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_scheme_categories`
--

DROP TABLE IF EXISTS `hymn_scheme_categories`;
CREATE TABLE IF NOT EXISTS `hymn_scheme_categories` (
  `id` int UNSIGNED NOT NULL,
  `code` char(3) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `scheme_id` int UNSIGNED NOT NULL DEFAULT '0',
  `disp_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Hymn Scheme Categories';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_sing`
--

DROP TABLE IF EXISTS `hymn_sing`;
CREATE TABLE IF NOT EXISTS `hymn_sing` (
  `hymn_no` int NOT NULL,
  `tune_id` int NOT NULL,
  `title` varchar(250) NOT NULL,
  `recorded_by` varchar(60) DEFAULT NULL,
  `sing_url` varchar(250) NOT NULL,
  PRIMARY KEY (`hymn_no`,`tune_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Hymn Singing';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_tune`
--

DROP TABLE IF EXISTS `hymn_tune`;
CREATE TABLE IF NOT EXISTS `hymn_tune` (
  `tune_id` int NOT NULL,
  `tune_no` int DEFAULT NULL,
  `tune_name` varchar(32) DEFAULT NULL,
  `meter_id` int DEFAULT NULL,
  `alt_meter` varchar(16) DEFAULT NULL,
  `tune_book` varchar(5) DEFAULT NULL,
  `tune_book_name` varchar(10) DEFAULT NULL,
  `tune_author` varchar(36) DEFAULT NULL,
  `note` varchar(76) DEFAULT NULL,
  `tune_url` varchar(87) DEFAULT NULL,
  PRIMARY KEY (`tune_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

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
  `admin` int DEFAULT '0',
  `member_type` char(2) NOT NULL DEFAULT 'N',
  `verify_code` varchar(100) NOT NULL DEFAULT '',
  `active` int NOT NULL DEFAULT '0',
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
  `disp_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`member_type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Types';

-- --------------------------------------------------------

--
-- Table structure for table `mse_article`
--

DROP TABLE IF EXISTS `mse_article`;
CREATE TABLE IF NOT EXISTS `mse_article` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int NOT NULL DEFAULT '0',
  `page` smallint NOT NULL DEFAULT '0',
  `localrow` int NOT NULL DEFAULT '0',
  `articlegroup` varchar(500) DEFAULT NULL,
  `article` varchar(1000) DEFAULT NULL,
  `scriptures` varchar(1000) DEFAULT NULL,
  `bypass` tinyint DEFAULT NULL,
  PRIMARY KEY (`author`,`vol`,`page`,`localrow`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_articlegroup`
--

DROP TABLE IF EXISTS `mse_articlegroup`;
CREATE TABLE IF NOT EXISTS `mse_articlegroup` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int NOT NULL DEFAULT '0',
  `articlegroup` varchar(500) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `groupdate` varchar(255) DEFAULT NULL,
  `summary` varchar(1000) DEFAULT NULL,
  `localrow` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`author`,`vol`,`localrow`)
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
  `bookid` int NOT NULL DEFAULT '0',
  `bookname` varchar(255) DEFAULT NULL,
  `testament` char(2) DEFAULT NULL,
  `testbook` int DEFAULT NULL,
  `singlechap` tinyint DEFAULT NULL,
  `firstverse` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bookid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote`
--

DROP TABLE IF EXISTS `mse_bible_footnote`;
CREATE TABLE IF NOT EXISTS `mse_bible_footnote` (
  `footnoteid` int UNSIGNED NOT NULL,
  `verid` int UNSIGNED NOT NULL,
  `bookid` int UNSIGNED NOT NULL,
  `chapter` int UNSIGNED NOT NULL,
  `verse` int UNSIGNED NOT NULL,
  `symbol` char(1) NOT NULL,
  `text` varchar(2000) NOT NULL,
  PRIMARY KEY (`footnoteid`),
  UNIQUE KEY `FOOTNOTE` (`verid`,`bookid`,`chapter`,`verse`,`symbol`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Bible Footnotes';

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote_ref`
--

DROP TABLE IF EXISTS `mse_bible_footnote_ref`;
CREATE TABLE IF NOT EXISTS `mse_bible_footnote_ref` (
  `footnoteid` int UNSIGNED NOT NULL,
  `verid` int UNSIGNED NOT NULL,
  `bookid` int UNSIGNED NOT NULL,
  `chapter` int UNSIGNED NOT NULL,
  `verse` int UNSIGNED NOT NULL,
  `refid` int UNSIGNED NOT NULL DEFAULT '0',
  `phrase` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`footnoteid`,`verid`,`bookid`,`chapter`,`verse`,`refid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Bible Footnote References';

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote_xref`
--

DROP TABLE IF EXISTS `mse_bible_footnote_xref`;
CREATE TABLE IF NOT EXISTS `mse_bible_footnote_xref` (
  `footnoteid` int UNSIGNED NOT NULL,
  `verid` int UNSIGNED NOT NULL,
  `bookid` int UNSIGNED NOT NULL,
  `chapter` int UNSIGNED NOT NULL,
  `verse` int UNSIGNED NOT NULL,
  `xrefid` int UNSIGNED NOT NULL,
  `from_footnoteid` int UNSIGNED DEFAULT NULL,
  `phrase` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`footnoteid`,`verid`,`bookid`,`chapter`,`verse`,`xrefid`),
  KEY `tofootnote` (`from_footnoteid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Bible Footnote Cross-references';

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_ref`
--

DROP TABLE IF EXISTS `mse_bible_ref`;
CREATE TABLE IF NOT EXISTS `mse_bible_ref` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int NOT NULL DEFAULT '0',
  `page` int NOT NULL DEFAULT '0',
  `para` int NOT NULL DEFAULT '0',
  `ref` int NOT NULL DEFAULT '0',
  `article_page` int NOT NULL DEFAULT '0',
  `article_localrow` int NOT NULL DEFAULT '0',
  `article_primary` int NOT NULL DEFAULT '0',
  `bookid` int NOT NULL DEFAULT '0',
  `chapter` int NOT NULL DEFAULT '0',
  `vstart` int NOT NULL DEFAULT '0',
  `vend` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`author`,`vol`,`page`,`para`,`ref`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_ref_error`
--

DROP TABLE IF EXISTS `mse_bible_ref_error`;
CREATE TABLE IF NOT EXISTS `mse_bible_ref_error` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int NOT NULL DEFAULT '0',
  `page` int NOT NULL DEFAULT '0',
  `para` int NOT NULL DEFAULT '0',
  `ref` int NOT NULL DEFAULT '0',
  `error_code` char(1) NOT NULL DEFAULT '',
  `text` varchar(1000) DEFAULT NULL,
  KEY `author_vol` (`author`,`vol`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_text`
--

DROP TABLE IF EXISTS `mse_bible_text`;
CREATE TABLE IF NOT EXISTS `mse_bible_text` (
  `verid` int UNSIGNED NOT NULL,
  `bookid` int UNSIGNED NOT NULL,
  `chapter` int UNSIGNED NOT NULL,
  `verse` int UNSIGNED NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`verid`,`bookid`,`chapter`,`verse`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_version`
--

DROP TABLE IF EXISTS `mse_bible_version`;
CREATE TABLE IF NOT EXISTS `mse_bible_version` (
  `verid` int UNSIGNED NOT NULL,
  `vercode` varchar(3) NOT NULL,
  `versionname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`verid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Bible Versions' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `mse_collection`
--

DROP TABLE IF EXISTS `mse_collection`;
CREATE TABLE IF NOT EXISTS `mse_collection` (
  `collectionid` int NOT NULL,
  `collectionname` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`collectionid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_collection_article`
--

DROP TABLE IF EXISTS `mse_collection_article`;
CREATE TABLE IF NOT EXISTS `mse_collection_article` (
  `collectionid` int NOT NULL,
  `articleno` int NOT NULL,
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int NOT NULL DEFAULT '0',
  `page` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`collectionid`,`articleno`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COMMENT='Release History';

-- --------------------------------------------------------

--
-- Table structure for table `mse_text`
--

DROP TABLE IF EXISTS `mse_text`;
CREATE TABLE IF NOT EXISTS `mse_text` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int NOT NULL DEFAULT '0',
  `page` int NOT NULL DEFAULT '0',
  `para` int NOT NULL DEFAULT '0',
  `article_page` int NOT NULL DEFAULT '0',
  `article_localrow` int DEFAULT '0',
  `inits` varchar(20) DEFAULT NULL,
  `text` longtext NOT NULL,
  `newpages` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`author`,`vol`,`page`,`para`),
  KEY `inits` (`inits`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mse_volume`
--

DROP TABLE IF EXISTS `mse_volume`;
CREATE TABLE IF NOT EXISTS `mse_volume` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `localfile` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hymn_line`
--
ALTER TABLE `hymn_line` ADD FULLTEXT KEY `LINE_SEARCH` (`line_text`);

--
-- Indexes for table `hymn_line_de`
--
ALTER TABLE `hymn_line_de` ADD FULLTEXT KEY `LINE_SEARCH` (`line_text`);

--
-- Indexes for table `hymn_line_it`
--
ALTER TABLE `hymn_line_it` ADD FULLTEXT KEY `LINE_SEARCH` (`line_text`);

--
-- Indexes for table `hymn_line_nl`
--
ALTER TABLE `hymn_line_nl` ADD FULLTEXT KEY `LINE_SEARCH` (`line_text`);

--
-- Indexes for table `mse_text`
--
ALTER TABLE `mse_text` ADD FULLTEXT KEY `text` (`text`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
