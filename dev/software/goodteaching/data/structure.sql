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
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 03, 2026 at 09:52 PM
-- Server version: 10.6.20-MariaDB-cll-lve
-- PHP Version: 8.1.34

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
CREATE TABLE `authors` (
  `id` int(10) UNSIGNED NOT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `firstnames` varchar(50) DEFAULT NULL,
  `author_life` varchar(50) DEFAULT NULL,
  `bio_url` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn`
--

DROP TABLE IF EXISTS `hymn`;
CREATE TABLE `hymn` (
  `hymn_no` int(10) NOT NULL DEFAULT 0,
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int(11) DEFAULT NULL,
  `author_id` int(10) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_categories`
--

DROP TABLE IF EXISTS `hymn_categories`;
CREATE TABLE `hymn_categories` (
  `hymn_no` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Hymn Categories';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_de`
--

DROP TABLE IF EXISTS `hymn_de`;
CREATE TABLE `hymn_de` (
  `hymn_no` int(10) NOT NULL DEFAULT 0,
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int(11) DEFAULT NULL,
  `author_id` int(10) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_it`
--

DROP TABLE IF EXISTS `hymn_it`;
CREATE TABLE `hymn_it` (
  `hymn_no` int(10) NOT NULL DEFAULT 0,
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int(11) DEFAULT NULL,
  `author_id` int(10) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line`
--

DROP TABLE IF EXISTS `hymn_line`;
CREATE TABLE `hymn_line` (
  `hymn_no` int(10) NOT NULL DEFAULT 0,
  `vers_no` int(10) NOT NULL DEFAULT 0,
  `line_no` int(10) NOT NULL DEFAULT 0,
  `line_text` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line_de`
--

DROP TABLE IF EXISTS `hymn_line_de`;
CREATE TABLE `hymn_line_de` (
  `hymn_no` int(10) NOT NULL DEFAULT 0,
  `vers_no` int(10) NOT NULL DEFAULT 0,
  `line_no` int(10) NOT NULL DEFAULT 0,
  `line_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line_it`
--

DROP TABLE IF EXISTS `hymn_line_it`;
CREATE TABLE `hymn_line_it` (
  `hymn_no` int(10) NOT NULL DEFAULT 0,
  `vers_no` int(10) NOT NULL DEFAULT 0,
  `line_no` int(10) NOT NULL DEFAULT 0,
  `line_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_line_nl`
--

DROP TABLE IF EXISTS `hymn_line_nl`;
CREATE TABLE `hymn_line_nl` (
  `hymn_no` int(10) NOT NULL DEFAULT 0,
  `vers_no` int(10) NOT NULL DEFAULT 0,
  `line_no` int(10) NOT NULL DEFAULT 0,
  `line_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_meter`
--

DROP TABLE IF EXISTS `hymn_meter`;
CREATE TABLE `hymn_meter` (
  `id` int(11) NOT NULL,
  `meter` varchar(50) NOT NULL DEFAULT '',
  `rhythm` varchar(50) DEFAULT NULL,
  `chorus` varchar(50) DEFAULT NULL,
  `disp_order` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Hymn Meters';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_nl`
--

DROP TABLE IF EXISTS `hymn_nl`;
CREATE TABLE `hymn_nl` (
  `hymn_no` int(10) NOT NULL DEFAULT 0,
  `meter` varchar(255) NOT NULL DEFAULT '',
  `meter_id` int(11) DEFAULT NULL,
  `author_id` int(10) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hymn_schemes`
--

DROP TABLE IF EXISTS `hymn_schemes`;
CREATE TABLE `hymn_schemes` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` char(3) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Hymn Schemes';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_scheme_categories`
--

DROP TABLE IF EXISTS `hymn_scheme_categories`;
CREATE TABLE `hymn_scheme_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` char(3) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `scheme_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `disp_order` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Hymn Scheme Categories';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_sing`
--

DROP TABLE IF EXISTS `hymn_sing`;
CREATE TABLE `hymn_sing` (
  `hymn_no` int(10) NOT NULL,
  `tune_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `recorded_by` varchar(60) DEFAULT NULL,
  `sing_url` varchar(250) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Hymn Singing';

-- --------------------------------------------------------

--
-- Table structure for table `hymn_tune`
--

DROP TABLE IF EXISTS `hymn_tune`;
CREATE TABLE `hymn_tune` (
  `tune_id` int(11) NOT NULL,
  `tune_no` int(3) DEFAULT NULL,
  `tune_name` varchar(32) DEFAULT NULL,
  `meter_id` int(2) DEFAULT NULL,
  `alt_meter` varchar(16) DEFAULT NULL,
  `tune_book` varchar(5) DEFAULT NULL,
  `tune_book_name` varchar(10) DEFAULT NULL,
  `tune_author` varchar(36) DEFAULT NULL,
  `note` varchar(76) DEFAULT NULL,
  `tune_url` varchar(87) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `memberid` varchar(20) NOT NULL DEFAULT '',
  `first_name` varchar(25) NOT NULL DEFAULT '',
  `last_name` varchar(25) NOT NULL DEFAULT '',
  `email_address` varchar(255) DEFAULT NULL,
  `password` varchar(50) NOT NULL DEFAULT '',
  `admin` int(1) DEFAULT 0,
  `member_type` char(2) NOT NULL DEFAULT 'N',
  `verify_code` varchar(100) NOT NULL DEFAULT '',
  `active` int(1) NOT NULL DEFAULT 0,
  `dob` date NOT NULL DEFAULT '0000-00-00',
  `signup_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='User Information';

-- --------------------------------------------------------

--
-- Table structure for table `member_type`
--

DROP TABLE IF EXISTS `member_type`;
CREATE TABLE `member_type` (
  `member_type` char(2) NOT NULL DEFAULT '',
  `type_name` varchar(50) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `disp_order` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='User Types';

-- --------------------------------------------------------

--
-- Table structure for table `mse_article`
--

DROP TABLE IF EXISTS `mse_article`;
CREATE TABLE `mse_article` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT 0,
  `page` smallint(6) NOT NULL DEFAULT 0,
  `localrow` int(4) NOT NULL DEFAULT 0,
  `articlegroup` varchar(500) DEFAULT NULL,
  `article` varchar(1000) DEFAULT NULL,
  `scriptures` varchar(1000) DEFAULT NULL,
  `bypass` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mse_author`
--

DROP TABLE IF EXISTS `mse_author`;
CREATE TABLE `mse_author` (
  `author` char(3) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `fullname` varchar(50) DEFAULT NULL,
  `orgname` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_book`
--

DROP TABLE IF EXISTS `mse_bible_book`;
CREATE TABLE `mse_bible_book` (
  `bookid` int(11) NOT NULL DEFAULT 0,
  `bookname` varchar(255) DEFAULT NULL,
  `testament` char(2) DEFAULT NULL,
  `testbook` int(11) DEFAULT NULL,
  `singlechap` tinyint(4) DEFAULT NULL,
  `firstverse` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote`
--

DROP TABLE IF EXISTS `mse_bible_footnote`;
CREATE TABLE `mse_bible_footnote` (
  `footnoteid` int(10) UNSIGNED NOT NULL,
  `verid` int(10) UNSIGNED NOT NULL,
  `bookid` int(10) UNSIGNED NOT NULL,
  `chapter` int(10) UNSIGNED NOT NULL,
  `verse` int(10) UNSIGNED NOT NULL,
  `symbol` char(1) NOT NULL,
  `text` varchar(2000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Bible Footnotes';

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote_ref`
--

DROP TABLE IF EXISTS `mse_bible_footnote_ref`;
CREATE TABLE `mse_bible_footnote_ref` (
  `footnoteid` int(10) UNSIGNED NOT NULL,
  `verid` int(10) UNSIGNED NOT NULL,
  `bookid` int(10) UNSIGNED NOT NULL,
  `chapter` int(10) UNSIGNED NOT NULL,
  `verse` int(10) UNSIGNED NOT NULL,
  `refid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `phrase` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Bible Footnote References';

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_footnote_xref`
--

DROP TABLE IF EXISTS `mse_bible_footnote_xref`;
CREATE TABLE `mse_bible_footnote_xref` (
  `footnoteid` int(10) UNSIGNED NOT NULL,
  `verid` int(10) UNSIGNED NOT NULL,
  `bookid` int(10) UNSIGNED NOT NULL,
  `chapter` int(10) UNSIGNED NOT NULL,
  `verse` int(10) UNSIGNED NOT NULL,
  `xrefid` int(10) UNSIGNED NOT NULL,
  `from_footnoteid` int(10) UNSIGNED DEFAULT NULL,
  `phrase` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Bible Footnote Cross-references';

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_ref`
--

DROP TABLE IF EXISTS `mse_bible_ref`;
CREATE TABLE `mse_bible_ref` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT 0,
  `page` int(4) NOT NULL DEFAULT 0,
  `para` int(2) NOT NULL DEFAULT 0,
  `ref` int(11) NOT NULL DEFAULT 0,
  `article_page` int(11) NOT NULL DEFAULT 0,
  `article_localrow` int(4) NOT NULL DEFAULT 0,
  `article_primary` int(1) NOT NULL DEFAULT 0,
  `bookid` int(11) NOT NULL DEFAULT 0,
  `chapter` int(11) NOT NULL DEFAULT 0,
  `vstart` int(11) NOT NULL DEFAULT 0,
  `vend` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mse_bible_version`
--

DROP TABLE IF EXISTS `mse_bible_version`;
CREATE TABLE `mse_bible_version` (
  `verid` int(10) UNSIGNED NOT NULL,
  `vercode` varchar(3) NOT NULL,
  `versionname` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Bible Versions' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `mse_release_history`
--

DROP TABLE IF EXISTS `mse_release_history`;
CREATE TABLE `mse_release_history` (
  `release_no` varchar(10) NOT NULL DEFAULT '',
  `task_id` varchar(10) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Release History';

-- --------------------------------------------------------

--
-- Table structure for table `mse_text`
--

DROP TABLE IF EXISTS `mse_text`;
CREATE TABLE `mse_text` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT 0,
  `page` int(4) NOT NULL DEFAULT 0,
  `para` int(2) NOT NULL DEFAULT 0,
  `article_page` int(4) NOT NULL DEFAULT 0,
  `article_localrow` int(4) DEFAULT 0,
  `inits` varchar(20) DEFAULT NULL,
  `text` longtext NOT NULL,
  `newpages` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mse_volume`
--

DROP TABLE IF EXISTS `mse_volume`;
CREATE TABLE `mse_volume` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT 0,
  `title` varchar(255) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `localfile` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hymn`
--
ALTER TABLE `hymn`
  ADD PRIMARY KEY (`hymn_no`);

--
-- Indexes for table `hymn_categories`
--
ALTER TABLE `hymn_categories`
  ADD PRIMARY KEY (`hymn_no`,`category_id`);

--
-- Indexes for table `hymn_de`
--
ALTER TABLE `hymn_de`
  ADD PRIMARY KEY (`hymn_no`);

--
-- Indexes for table `hymn_it`
--
ALTER TABLE `hymn_it`
  ADD PRIMARY KEY (`hymn_no`);

--
-- Indexes for table `hymn_line`
--
ALTER TABLE `hymn_line`
  ADD PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`);
ALTER TABLE `hymn_line` ADD FULLTEXT KEY `LINE_SEARCH` (`line_text`);

--
-- Indexes for table `hymn_line_de`
--
ALTER TABLE `hymn_line_de`
  ADD PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`);
ALTER TABLE `hymn_line_de` ADD FULLTEXT KEY `LINE_SEARCH` (`line_text`);

--
-- Indexes for table `hymn_line_it`
--
ALTER TABLE `hymn_line_it`
  ADD PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`);
ALTER TABLE `hymn_line_it` ADD FULLTEXT KEY `LINE_SEARCH` (`line_text`);

--
-- Indexes for table `hymn_line_nl`
--
ALTER TABLE `hymn_line_nl`
  ADD PRIMARY KEY (`hymn_no`,`vers_no`,`line_no`);
ALTER TABLE `hymn_line_nl` ADD FULLTEXT KEY `LINE_SEARCH` (`line_text`);

--
-- Indexes for table `hymn_meter`
--
ALTER TABLE `hymn_meter`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hymn_nl`
--
ALTER TABLE `hymn_nl`
  ADD PRIMARY KEY (`hymn_no`);

--
-- Indexes for table `hymn_schemes`
--
ALTER TABLE `hymn_schemes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hymn_scheme_categories`
--
ALTER TABLE `hymn_scheme_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hymn_sing`
--
ALTER TABLE `hymn_sing`
  ADD PRIMARY KEY (`hymn_no`,`tune_id`);

--
-- Indexes for table `hymn_tune`
--
ALTER TABLE `hymn_tune`
  ADD PRIMARY KEY (`tune_id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`memberid`),
  ADD KEY `i_email_address` (`email_address`);

--
-- Indexes for table `member_type`
--
ALTER TABLE `member_type`
  ADD PRIMARY KEY (`member_type`);

--
-- Indexes for table `mse_article`
--
ALTER TABLE `mse_article`
  ADD PRIMARY KEY (`author`,`vol`,`page`,`localrow`);

--
-- Indexes for table `mse_author`
--
ALTER TABLE `mse_author`
  ADD PRIMARY KEY (`author`);

--
-- Indexes for table `mse_bible_book`
--
ALTER TABLE `mse_bible_book`
  ADD PRIMARY KEY (`bookid`);

--
-- Indexes for table `mse_bible_footnote`
--
ALTER TABLE `mse_bible_footnote`
  ADD PRIMARY KEY (`footnoteid`),
  ADD UNIQUE KEY `FOOTNOTE` (`verid`,`bookid`,`chapter`,`verse`,`symbol`);

--
-- Indexes for table `mse_bible_footnote_ref`
--
ALTER TABLE `mse_bible_footnote_ref`
  ADD PRIMARY KEY (`footnoteid`,`verid`,`bookid`,`chapter`,`verse`,`refid`);

--
-- Indexes for table `mse_bible_footnote_xref`
--
ALTER TABLE `mse_bible_footnote_xref`
  ADD PRIMARY KEY (`footnoteid`,`verid`,`bookid`,`chapter`,`verse`,`xrefid`),
  ADD KEY `tofootnote` (`from_footnoteid`);

--
-- Indexes for table `mse_bible_ref`
--
ALTER TABLE `mse_bible_ref`
  ADD PRIMARY KEY (`author`,`vol`,`page`,`para`,`ref`);

--
-- Indexes for table `mse_bible_version`
--
ALTER TABLE `mse_bible_version`
  ADD PRIMARY KEY (`verid`);

--
-- Indexes for table `mse_release_history`
--
ALTER TABLE `mse_release_history`
  ADD PRIMARY KEY (`release_no`,`task_id`);

--
-- Indexes for table `mse_text`
--
ALTER TABLE `mse_text`
  ADD PRIMARY KEY (`author`,`vol`,`page`,`para`),
  ADD KEY `inits` (`inits`);
ALTER TABLE `mse_text` ADD FULLTEXT KEY `text` (`text`);
ALTER TABLE `mse_text` ADD FULLTEXT KEY `text_2` (`text`);

--
-- Indexes for table `mse_volume`
--
ALTER TABLE `mse_volume`
  ADD PRIMARY KEY (`author`,`vol`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hymn_meter`
--
ALTER TABLE `hymn_meter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hymn_schemes`
--
ALTER TABLE `hymn_schemes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hymn_scheme_categories`
--
ALTER TABLE `hymn_scheme_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hymn_tune`
--
ALTER TABLE `hymn_tune`
  MODIFY `tune_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mse_bible_footnote`
--
ALTER TABLE `mse_bible_footnote`
  MODIFY `footnoteid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
