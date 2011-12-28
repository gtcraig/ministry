-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2009 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: structure.sql 1145 2010-01-23 12:12:03Z craig $
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
-- --------------------------------------------------------

--
-- To recreate this file, dump data for ALL tables with structure, no data:
--

-- --------------------------------------------------------
-- DELETE ALL FROM THIS SECTION DOWNWARDS, THEN PASTE NEW
-- --------------------------------------------------------

--
-- Table structure for table authors
--

CREATE TABLE authors (
  id int(10) unsigned NOT NULL auto_increment,
  fullname varchar(50) default NULL,
  surname varchar(50) default NULL,
  firstnames varchar(50) default NULL,
  author_life varchar(50) default NULL,
  bio_url varchar(255) default NULL,
  created datetime default NULL,
  modified datetime default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10000 ;

-- --------------------------------------------------------

--
-- Table structure for table hymn
--

CREATE TABLE hymn (
  hymn_no int(10) NOT NULL default '0',
  meter varchar(255) NOT NULL default '',
  meter_id int(11) default NULL,
  author_id int(10) NOT NULL default '0',
  PRIMARY KEY  (hymn_no)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table hymn_categories
--

CREATE TABLE hymn_categories (
  hymn_no int(10) unsigned NOT NULL default '0',
  category_id int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (hymn_no,category_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Hymn Categories';

-- --------------------------------------------------------

--
-- Table structure for table hymn_de
--

CREATE TABLE hymn_de (
  hymn_no int(10) NOT NULL default '0',
  meter varchar(255) NOT NULL default '',
  meter_id int(11) default NULL,
  author_id int(10) NOT NULL default '0',
  PRIMARY KEY  (hymn_no)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table hymn_line
--

CREATE TABLE hymn_line (
  hymn_no int(10) NOT NULL default '0',
  vers_no int(10) NOT NULL default '0',
  line_no int(10) NOT NULL default '0',
  line_text varchar(255) NOT NULL default '',
  PRIMARY KEY  (hymn_no,vers_no,line_no),
  FULLTEXT KEY LINE_SEARCH (line_text)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table hymn_line_de
--

CREATE TABLE hymn_line_de (
  hymn_no int(10) NOT NULL default '0',
  vers_no int(10) NOT NULL default '0',
  line_no int(10) NOT NULL default '0',
  line_text varchar(255) NOT NULL default '',
  PRIMARY KEY  (hymn_no,vers_no,line_no),
  FULLTEXT KEY LINE_SEARCH (line_text)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table hymn_line_nl
--

CREATE TABLE hymn_line_nl (
  hymn_no int(10) NOT NULL default '0',
  vers_no int(10) NOT NULL default '0',
  line_no int(10) NOT NULL default '0',
  line_text varchar(255) character set latin1 collate latin1_german1_ci NOT NULL default '',
  PRIMARY KEY  (hymn_no,vers_no,line_no),
  FULLTEXT KEY LINE_SEARCH (line_text)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table hymn_meter
--

CREATE TABLE hymn_meter (
  id int(11) NOT NULL auto_increment,
  meter varchar(50) NOT NULL default '',
  rhythm varchar(50) default NULL,
  chorus varchar(50) default NULL,
  disp_order int(11) NOT NULL default '0',
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Hymn Meters' AUTO_INCREMENT=138 ;

-- --------------------------------------------------------

--
-- Table structure for table hymn_nl
--

CREATE TABLE hymn_nl (
  hymn_no int(10) NOT NULL default '0',
  meter varchar(255) NOT NULL default '',
  meter_id int(11) default NULL,
  author_id int(10) NOT NULL default '0',
  PRIMARY KEY  (hymn_no)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table hymn_scheme_categories
--

CREATE TABLE hymn_scheme_categories (
  id int(10) unsigned NOT NULL auto_increment,
  code char(3) NOT NULL default '',
  name varchar(100) NOT NULL default '',
  scheme_id int(10) unsigned NOT NULL default '0',
  disp_order int(11) NOT NULL default '0',
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Hymn Scheme Categories' AUTO_INCREMENT=15 ;

-- --------------------------------------------------------

--
-- Table structure for table hymn_schemes
--

CREATE TABLE hymn_schemes (
  id int(10) unsigned NOT NULL auto_increment,
  code char(3) NOT NULL default '',
  name varchar(100) NOT NULL default '',
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Hymn Schemes' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table member
--

CREATE TABLE member (
  memberid varchar(20) NOT NULL default '',
  first_name varchar(25) NOT NULL default '',
  last_name varchar(25) NOT NULL default '',
  email_address varchar(255) default NULL,
  password varchar(50) NOT NULL default '',
  admin int(1) default '0',
  member_type char(2) NOT NULL default 'N',
  verify_code varchar(100) NOT NULL default '',
  active int(1) NOT NULL default '0',
  dob date NOT NULL default '0000-00-00',
  signup_date datetime NOT NULL default '0000-00-00 00:00:00',
  last_login datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (memberid),
  KEY i_email_address (email_address)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Information';

-- --------------------------------------------------------

--
-- Table structure for table member_type
--

CREATE TABLE member_type (
  member_type char(2) NOT NULL default '',
  type_name varchar(50) default NULL,
  comments varchar(255) default NULL,
  disp_order int(11) NOT NULL default '0',
  PRIMARY KEY  (member_type)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Types';

-- --------------------------------------------------------

--
-- Table structure for table mse_article
--

CREATE TABLE mse_article (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page smallint(6) NOT NULL default '0',
  localrow int(4) NOT NULL default '0',
  article varchar(255) default NULL,
  scriptures varchar(255) default NULL,
  bypass tinyint(4) default NULL,
  PRIMARY KEY  (author,vol,page)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
-- Table structure for table mse_bible_footnote
--

CREATE TABLE mse_bible_footnote (
  footnoteid int(10) unsigned NOT NULL auto_increment,
  verid int(10) unsigned NOT NULL,
  bookid int(10) unsigned NOT NULL,
  chapter int(10) unsigned NOT NULL,
  verse int(10) unsigned NOT NULL,
  symbol char(1) NOT NULL,
  text varchar(2000) NOT NULL,
  PRIMARY KEY  (footnoteid),
  UNIQUE KEY FOOTNOTE (verid,bookid,chapter,verse,symbol)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Bible Footnotes' AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_footnote_ref
--

CREATE TABLE mse_bible_footnote_ref (
  footnoteid int(10) unsigned NOT NULL,
  verid int(10) unsigned NOT NULL,
  bookid int(10) unsigned NOT NULL,
  chapter int(10) unsigned NOT NULL,
  verse int(10) unsigned NOT NULL,
  refid int(10) unsigned NOT NULL default '0',
  phrase varchar(200) default NULL,
  PRIMARY KEY  (footnoteid,verid,bookid,chapter,verse,refid)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Bible Footnote References';

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_footnote_xref
--

CREATE TABLE mse_bible_footnote_xref (
  footnoteid int(10) unsigned NOT NULL,
  verid int(10) unsigned NOT NULL,
  bookid int(10) unsigned NOT NULL,
  chapter int(10) unsigned NOT NULL,
  verse int(10) unsigned NOT NULL,
  xrefid int(10) unsigned NOT NULL,
  from_footnoteid int(10) unsigned default NULL,
  phrase varchar(200) default NULL,
  PRIMARY KEY  (footnoteid,verid,bookid,chapter,verse,xrefid),
  KEY tofootnote (from_footnoteid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Bible Footnote Cross-references';

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

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_ref_error
--

CREATE TABLE mse_bible_ref_error (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page int(4) NOT NULL default '0',
  para int(2) NOT NULL default '0',
  ref int(11) NOT NULL default '0',
  error_code varchar(200) default NULL,
  text varchar(2000) default NULL,
  PRIMARY KEY  (author,vol,page,para,ref)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_text
--

CREATE TABLE mse_bible_text (
  verid int(10) unsigned NOT NULL,
  bookid int(10) unsigned NOT NULL,
  chapter int(10) unsigned NOT NULL,
  verse int(10) unsigned NOT NULL,
  text varchar(2000) NOT NULL,
  PRIMARY KEY  (verid,bookid,chapter,verse),
  FULLTEXT KEY fulltext (text)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Bible Text';

-- --------------------------------------------------------

--
-- Table structure for table mse_bible_version
--

CREATE TABLE mse_bible_version (
  verid int(10) unsigned NOT NULL,
  vercode varchar(3) NOT NULL,
  versionname varchar(45) default NULL,
  PRIMARY KEY  (verid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Bible Versions';

-- --------------------------------------------------------

--
-- Table structure for table mse_release_history
--

CREATE TABLE mse_release_history (
  release_no varchar(10) NOT NULL,
  task_id varchar(10) NOT NULL,
  description varchar(255) default NULL,
  completion_date datetime default NULL,
  PRIMARY KEY  (release_no,task_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Release History';

-- --------------------------------------------------------

--
-- Table structure for table mse_text
--

CREATE TABLE mse_text (
  author varchar(10) NOT NULL default '',
  vol int(3) NOT NULL default '0',
  page int(4) NOT NULL default '0',
  para int(2) NOT NULL default '0',
  localrow int(4) NOT NULL default '0',
  article_page int(4) NOT NULL default '0',
  inits varchar(20) default NULL,
  text longtext NOT NULL,
  newpages varchar(100) default NULL,
  PRIMARY KEY  (author,vol,page,para),
  KEY inits (inits),
  FULLTEXT KEY ft (text)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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

