-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2009 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: data.common.sql 1102 2009-12-29 16:51:54Z craig $
--
-- Who  When         Why
-- CAM  29-Dec-2009  10514 : File created.
-- --------------------------------------------------------

--
-- To recreate this file, dump data for the following tables WITHOUT structure:
--
--    member
--    member_type
--    mse_release_history
--

-- --------------------------------------------------------
-- DELETE ALL FROM THIS SECTION DOWNWARDS, THEN PASTE NEW
-- --------------------------------------------------------

--
-- Dumping data for table member
--

INSERT INTO `member` VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '0954bfb4e59e3d85ff989944a65f6955', 1, 'A', '0', 1, '1975-09-13', '2006-01-01 00:00:00', '2007-08-11 16:23:56');

--
-- Dumping data for table member_type
--

INSERT INTO member_type VALUES ('U', 'User', 'Ability to View all details on the site', 1);
INSERT INTO member_type VALUES ('N', 'New User', 'No permissions yet - waiting verification', 3);
INSERT INTO member_type VALUES ('A', 'Administrator', 'Full Administrative capabilities', 2);

--
-- Dumping data for table mse_release_history
--

INSERT INTO mse_release_history VALUES ('0.0.1', '10186', 'Create Export Scripts', '2007-11-24 08:03:14');
INSERT INTO mse_release_history VALUES ('0.0.2', '10189', 'Catch all Initials like *Ques* and S.McC.', '2007-11-24 08:03:56');
INSERT INTO mse_release_history VALUES ('0.0.3', '10187', 'Add Scripture Search', '2007-11-24 08:05:07');
INSERT INTO mse_release_history VALUES ('0.0.3', '10200', 'Add Search Results Pagination', '2007-11-24 08:05:41');
INSERT INTO mse_release_history VALUES ('0.0.4', '10201', 'Bug - Pagination does not work if you start immediately with Scriptures', '2007-11-24 08:06:20');
INSERT INTO mse_release_history VALUES ('0.0.4', '10214', 'Consider Greater-Than char to be an acceptable end paragraph character', '2007-11-24 08:06:55');
INSERT INTO mse_release_history VALUES ('0.0.4', '10202', 'Migrate to goodteaching.org', '2007-11-24 08:06:55');
INSERT INTO mse_release_history VALUES ('0.0.5', '10203', 'Correct ''onclick'' bug in IE6 - remember to "return false;"', '2007-11-24 08:07:35');
INSERT INTO mse_release_history VALUES ('0.0.5', '10204', 'Add intelligence to Servant checkboxes', '2007-11-24 08:08:09');
INSERT INTO mse_release_history VALUES ('0.0.5', '10205', 'Bug - Limiting a search on a different tab should reset the Current Page to 1', '2007-11-24 08:08:39');
INSERT INTO mse_release_history VALUES ('0.0.6', '10213', 'Change colour of Scripture links', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('0.0.6', '10210', 'Show New Page indicator in text Results', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('0.0.6', '10208', 'Add New Page Indicators to Mse_Text', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('0.0.6', '10188', 'Calculate the Article Page for MseText', '2007-11-24 12:54:23');
INSERT INTO mse_release_history VALUES ('0.0.7', '10206', 'Add Pagination to Volume Preview pane', '2008-05-18 17:26:18');
INSERT INTO mse_release_history VALUES ('0.0.8', '10211', 'Highlight Search Terms in Results and Preview', '2008-05-18 17:26:18');
INSERT INTO mse_release_history VALUES ('0.0.9', '10267', 'Add Release History', '2008-05-18 19:39:50');
INSERT INTO mse_release_history VALUES ('0.0.11', '10272', 'Highlight Footnotes: grey, smaller text', '2008-06-15 21:52:55');
INSERT INTO mse_release_history VALUES ('0.0.10', '10271', 'Where a paragraph EndsAbruptly, associate any footnotes on the following page with the original', '2008-06-15 21:22:41');
INSERT INTO mse_release_history VALUES ('0.0.10', '10268', 'Add ''News'' to front page - Top 6 most recently added volumes', '2008-06-04 07:48:10');
INSERT INTO mse_release_history VALUES ('0.0.12', '10274', 'Correct problem with HIGHLIGHT class being changed if the word LIGHT appears in the text', '2008-06-18 23:42:30');
INSERT INTO mse_release_history VALUES ('0.0.12', '10406', 'Test', '2009-03-28 08:58:18');
INSERT INTO mse_release_history VALUES ('0.0.13', '10408', 'Ensure Article Scriptures are included in Scripture search', '2009-03-28 15:55:17');
INSERT INTO mse_release_history VALUES ('0.0.13', '10407', 'Add ''Exact Phrase'' and ''Any of these words'' options', '2009-03-28 14:05:00');

