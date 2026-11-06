-- goodteaching_org_min: tables that MseBuilder uses but that are not in structure.sql
--
-- The column names, and their order, are taken from the SQL in MseBuilder
-- (Data/DatabaseLayer.cs, Bible/MseBibleEngine.cs). The types follow the matching
-- columns in mse_article, mse_text, mse_bible_ref and mse_bible_footnote.
-- The keys are inferred from how the code reads and writes each table.
-- CREATE TABLE IF NOT EXISTS: running this leaves any table that already exists unchanged.


-- 0. CHECK FIRST: lists every table and column MseBuilder needs that the live
--    database does not have. Run it before and after the statements below.
SELECT e.tbl, e.col,
       CASE WHEN t.TABLE_NAME IS NULL THEN 'table missing' ELSE 'column missing' END AS problem
FROM (
  SELECT 'mse_article' AS tbl, 'author' AS col
  UNION ALL SELECT 'mse_article' AS tbl, 'vol' AS col
  UNION ALL SELECT 'mse_article' AS tbl, 'page' AS col
  UNION ALL SELECT 'mse_article' AS tbl, 'localrow' AS col
  UNION ALL SELECT 'mse_article' AS tbl, 'articlegroup' AS col
  UNION ALL SELECT 'mse_article' AS tbl, 'article' AS col
  UNION ALL SELECT 'mse_article' AS tbl, 'scriptures' AS col
  UNION ALL SELECT 'mse_article' AS tbl, 'bypass' AS col
  UNION ALL SELECT 'mse_author' AS tbl, 'author' AS col
  UNION ALL SELECT 'mse_author' AS tbl, 'name' AS col
  UNION ALL SELECT 'mse_author' AS tbl, 'fullname' AS col
  UNION ALL SELECT 'mse_author' AS tbl, 'orgname' AS col
  UNION ALL SELECT 'mse_bible_book' AS tbl, 'bookid' AS col
  UNION ALL SELECT 'mse_bible_book' AS tbl, 'bookname' AS col
  UNION ALL SELECT 'mse_bible_book' AS tbl, 'testament' AS col
  UNION ALL SELECT 'mse_bible_book' AS tbl, 'testbook' AS col
  UNION ALL SELECT 'mse_bible_book' AS tbl, 'singlechap' AS col
  UNION ALL SELECT 'mse_bible_book' AS tbl, 'firstverse' AS col
  UNION ALL SELECT 'mse_bible_footnote' AS tbl, 'footnoteid' AS col
  UNION ALL SELECT 'mse_bible_footnote' AS tbl, 'verid' AS col
  UNION ALL SELECT 'mse_bible_footnote' AS tbl, 'bookid' AS col
  UNION ALL SELECT 'mse_bible_footnote' AS tbl, 'chapter' AS col
  UNION ALL SELECT 'mse_bible_footnote' AS tbl, 'verse' AS col
  UNION ALL SELECT 'mse_bible_footnote' AS tbl, 'symbol' AS col
  UNION ALL SELECT 'mse_bible_footnote' AS tbl, 'text' AS col
  UNION ALL SELECT 'mse_bible_footnote_ref' AS tbl, 'footnoteid' AS col
  UNION ALL SELECT 'mse_bible_footnote_ref' AS tbl, 'verid' AS col
  UNION ALL SELECT 'mse_bible_footnote_ref' AS tbl, 'bookid' AS col
  UNION ALL SELECT 'mse_bible_footnote_ref' AS tbl, 'chapter' AS col
  UNION ALL SELECT 'mse_bible_footnote_ref' AS tbl, 'verse' AS col
  UNION ALL SELECT 'mse_bible_footnote_ref' AS tbl, 'refid' AS col
  UNION ALL SELECT 'mse_bible_footnote_ref' AS tbl, 'phrase' AS col
  UNION ALL SELECT 'mse_bible_footnote_xref' AS tbl, 'footnoteid' AS col
  UNION ALL SELECT 'mse_bible_footnote_xref' AS tbl, 'verid' AS col
  UNION ALL SELECT 'mse_bible_footnote_xref' AS tbl, 'bookid' AS col
  UNION ALL SELECT 'mse_bible_footnote_xref' AS tbl, 'chapter' AS col
  UNION ALL SELECT 'mse_bible_footnote_xref' AS tbl, 'verse' AS col
  UNION ALL SELECT 'mse_bible_footnote_xref' AS tbl, 'xrefid' AS col
  UNION ALL SELECT 'mse_bible_footnote_xref' AS tbl, 'from_footnoteid' AS col
  UNION ALL SELECT 'mse_bible_footnote_xref' AS tbl, 'phrase' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'author' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'vol' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'page' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'para' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'ref' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'article_page' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'article_localrow' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'article_primary' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'bookid' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'chapter' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'vstart' AS col
  UNION ALL SELECT 'mse_bible_ref' AS tbl, 'vend' AS col
  UNION ALL SELECT 'mse_bible_version' AS tbl, 'verid' AS col
  UNION ALL SELECT 'mse_bible_version' AS tbl, 'vercode' AS col
  UNION ALL SELECT 'mse_bible_version' AS tbl, 'versionname' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'author' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'vol' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'page' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'para' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'article_page' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'article_localrow' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'localrow' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'inits' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'text' AS col
  UNION ALL SELECT 'mse_text' AS tbl, 'newpages' AS col
  UNION ALL SELECT 'mse_volume' AS tbl, 'author' AS col
  UNION ALL SELECT 'mse_volume' AS tbl, 'vol' AS col
  UNION ALL SELECT 'mse_volume' AS tbl, 'title' AS col
  UNION ALL SELECT 'mse_volume' AS tbl, 'added' AS col
  UNION ALL SELECT 'mse_volume' AS tbl, 'localfile' AS col
  UNION ALL SELECT 'mse_articlegroup' AS tbl, 'author' AS col
  UNION ALL SELECT 'mse_articlegroup' AS tbl, 'vol' AS col
  UNION ALL SELECT 'mse_articlegroup' AS tbl, 'articlegroup' AS col
  UNION ALL SELECT 'mse_articlegroup' AS tbl, 'city' AS col
  UNION ALL SELECT 'mse_articlegroup' AS tbl, 'groupdate' AS col
  UNION ALL SELECT 'mse_articlegroup' AS tbl, 'summary' AS col
  UNION ALL SELECT 'mse_articlegroup' AS tbl, 'localrow' AS col
  UNION ALL SELECT 'mse_bible_ref_error' AS tbl, 'author' AS col
  UNION ALL SELECT 'mse_bible_ref_error' AS tbl, 'vol' AS col
  UNION ALL SELECT 'mse_bible_ref_error' AS tbl, 'page' AS col
  UNION ALL SELECT 'mse_bible_ref_error' AS tbl, 'para' AS col
  UNION ALL SELECT 'mse_bible_ref_error' AS tbl, 'ref' AS col
  UNION ALL SELECT 'mse_bible_ref_error' AS tbl, 'error_code' AS col
  UNION ALL SELECT 'mse_bible_ref_error' AS tbl, 'text' AS col
  UNION ALL SELECT 'mse_bible_text' AS tbl, 'verid' AS col
  UNION ALL SELECT 'mse_bible_text' AS tbl, 'bookid' AS col
  UNION ALL SELECT 'mse_bible_text' AS tbl, 'chapter' AS col
  UNION ALL SELECT 'mse_bible_text' AS tbl, 'verse' AS col
  UNION ALL SELECT 'mse_bible_text' AS tbl, 'text' AS col
  UNION ALL SELECT 'mse_collection' AS tbl, 'collectionid' AS col
  UNION ALL SELECT 'mse_collection' AS tbl, 'collectionname' AS col
  UNION ALL SELECT 'mse_collection_article' AS tbl, 'collectionid' AS col
  UNION ALL SELECT 'mse_collection_article' AS tbl, 'articleno' AS col
  UNION ALL SELECT 'mse_collection_article' AS tbl, 'author' AS col
  UNION ALL SELECT 'mse_collection_article' AS tbl, 'vol' AS col
  UNION ALL SELECT 'mse_collection_article' AS tbl, 'page' AS col
) e
LEFT JOIN information_schema.TABLES t
  ON t.TABLE_SCHEMA = DATABASE() AND t.TABLE_NAME = e.tbl
LEFT JOIN information_schema.COLUMNS c
  ON c.TABLE_SCHEMA = DATABASE() AND c.TABLE_NAME = e.tbl AND c.COLUMN_NAME = e.col
WHERE c.COLUMN_NAME IS NULL
ORDER BY e.tbl, e.col;

-- Article groups ($GROUP lines). Written by MseParser via CreateArticleGroup (REPLACE INTO),
-- read by GetArticleGroups, cleared per volume before a rebuild.
CREATE TABLE IF NOT EXISTS `mse_articlegroup` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT 0,
  `articlegroup` varchar(500) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `groupdate` varchar(255) DEFAULT NULL,
  `summary` varchar(1000) DEFAULT NULL,
  `localrow` int(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`author`, `vol`, `localrow`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Bible references that fail to parse. Written by Paragraph via InsertBadBibleRef,
-- shown in the builder's error grid (GetBuildErrorDataset), cleared per volume.
CREATE TABLE IF NOT EXISTS `mse_bible_ref_error` (
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT 0,
  `page` int(4) NOT NULL DEFAULT 0,
  `para` int(2) NOT NULL DEFAULT 0,
  `ref` int(11) NOT NULL DEFAULT 0,
  `error_code` char(1) NOT NULL DEFAULT '',
  `text` varchar(1000) DEFAULT NULL,
  KEY `author_vol` (`author`, `vol`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Bible verse text. Used only when the builder loads a Bible version (MseBibleEngine).
CREATE TABLE IF NOT EXISTS `mse_bible_text` (
  `verid` int(10) UNSIGNED NOT NULL,
  `bookid` int(10) UNSIGNED NOT NULL,
  `chapter` int(10) UNSIGNED NOT NULL,
  `verse` int(10) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`verid`, `bookid`, `chapter`, `verse`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Collections of articles from several volumes, for the ebook build.
-- Read by GetCollectionVolumes (loaded by BusinessLayer) and GetCollectionText.
CREATE TABLE IF NOT EXISTS `mse_collection` (
  `collectionid` int(11) NOT NULL,
  `collectionname` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`collectionid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `mse_collection_article` (
  `collectionid` int(11) NOT NULL,
  `articleno` int(11) NOT NULL,
  `author` varchar(10) NOT NULL DEFAULT '',
  `vol` int(3) NOT NULL DEFAULT 0,
  `page` int(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`collectionid`, `articleno`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- mse_text.localrow: inserted for every paragraph (DatabaseLayer InsertText) and read
-- by the Bible-index query, but missing from structure.sql.
-- ADD COLUMN IF NOT EXISTS works on MariaDB (as bundled with XAMPP/WAMP). On MySQL,
-- drop "IF NOT EXISTS" and run this only if step 0 lists the column as missing.
ALTER TABLE `mse_text` ADD COLUMN IF NOT EXISTS `localrow` int(4) DEFAULT 0 AFTER `article_localrow`;
