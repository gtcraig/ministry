-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2026 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
-- --------------------------------------------------------

--
-- Database: `goodteaching_org_min`
--

--
-- Dumping data for table `mse_release_history`
--

INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.1', '10186', 'Create Export Scripts', '2007-11-24 08:03:14');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.2', '10189', 'Catch all Initials like *Ques* and S.McC.', '2007-11-24 08:03:56');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.3', '10187', 'Add Scripture Search', '2007-11-24 08:05:07');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.3', '10200', 'Add Search Results Pagination', '2007-11-24 08:05:41');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.4', '10201', 'Bug - Pagination does not work if you start immediately with Scriptures', '2007-11-24 08:06:20');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.4', '10214', 'Consider Greater-Than char to be an acceptable end paragraph character', '2007-11-24 08:06:55');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.4', '10202', 'Migrate to goodteaching.org', '2007-11-24 08:06:55');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.5', '10203', 'Correct \'onclick\' bug in IE6 - remember to \"return false;\"', '2007-11-24 08:07:35');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.5', '10204', 'Add intelligence to Servant checkboxes', '2007-11-24 08:08:09');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.5', '10205', 'Bug - Limiting a search on a different tab should reset the Current Page to 1', '2007-11-24 08:08:39');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.6', '10213', 'Change colour of Scripture links', '2007-11-24 12:54:23');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.6', '10210', 'Show New Page indicator in text Results', '2007-11-24 12:54:23');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.6', '10208', 'Add New Page Indicators to Mse_Text', '2007-11-24 12:54:23');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.6', '10188', 'Calculate the Article Page for MseText', '2007-11-24 12:54:23');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.7', '10206', 'Add Pagination to Volume Preview pane', '2008-05-18 17:26:18');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.8', '10211', 'Highlight Search Terms in Results and Preview', '2008-05-18 17:26:18');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.9', '10267', 'Add Release History', '2008-05-18 19:39:50');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.11', '10272', 'Highlight Footnotes: grey, smaller text', '2008-06-15 21:52:55');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.10', '10271', 'Where a paragraph EndsAbruptly, associate any footnotes on the following page with the original', '2008-06-15 21:22:41');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.10', '10268', 'Add \'News\' to front page - Top 6 most recently added volumes', '2008-06-04 07:48:10');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.12', '10274', 'Correct problem with HIGHLIGHT class being changed if the word LIGHT appears in the text', '2008-06-18 23:42:30');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.12', '10406', 'Test', '2009-03-28 08:58:18');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.13', '10408', 'Ensure Article Scriptures are included in Scripture search', '2009-03-28 15:55:17');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.13', '10407', 'Add \'Exact Phrase\' and \'Any of these words\' options', '2009-03-28 14:05:00');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.14', '10515', 'Create Bible Search: Footnotes only', '2009-12-29 21:19:59');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.14', '10516', 'Remove HTML links from Footnotes, replace with MSE convention', '2009-12-29 21:20:14');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.15', '10520', 'Bible Footnote: Split keyword phrases into multiple words', '2009-12-30 13:42:17');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.15', '10521', 'Ensure multiple refs are parsed correctly', '2009-12-30 13:42:53');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('0.0.15', '10522', 'Ensure multiple refs are displayed correctly', '2009-12-30 13:43:20');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.3.0', '839152', 'Added Sing Along (/sing).', '2021-01-15 21:00:00');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.0.0', '823080', 'Correct deprecated functions', '2014-11-06 00:00:00');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.1.0', '159308', 'Add search by Article Primary', '2015-08-29 00:00:00');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.2.0', '863707', 'Improve GTSE performance and search options', '2015-12-05 00:00:00');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.2.1', '476204', 'Various fixes to remove errors from the logs', '2015-12-12 22:20:00');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.2.2', '481548', 'Replace deprecated ext/mysql calls with MySQLi.', '2020-05-25 23:00:00');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.2.3', '909743', 'Added Tune Search (/tune).', '2020-05-31 21:30:00');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.3.1', '928208', 'Corrected PHP 7.4 Constructor Deprecations', '2022-10-31 22:57:05');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.3.2', '926858', 'Corrected Scripture search for single-chapter Books', '2022-11-01 21:26:10');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.3.3', '284135', 'Replaced the Deutsch Hymn Book with correct text provided, and ensured that search results are displaying German UTF8 characters correctly.', '2022-11-05 11:44:34');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.3.4', '38', 'Changed icons at the bottom of ministry preview; added [Start of Article] button, and increased space between prev/next and the other buttons to avoid accidental use.  TODO: Add Table of Contents button.', '2024-09-08 13:42:15');
INSERT INTO `mse_release_history` (`release_no`, `task_id`, `description`, `completion_date`) VALUES('1.4.0', '59', 'Added Library link to main page, removed non-core ebooks from /ebook/, Added with How-to guide on the feed, Separated new and old generation Kindle instructions, Changed Aldiko to ReadEra (for Android) and Updated to latest Amazon links for Kindle.', '2026-07-26 20:26:24');

