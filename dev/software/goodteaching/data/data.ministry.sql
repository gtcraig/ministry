-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2007,2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: data.ministry.sql 1149 2010-01-23 12:34:43Z craig $
--
-- Who  When         Why
-- CAM  29-Dec-2009  10514 : File created.
-- CAM  16-Jan-2010  10534 : Added volume titles where missing.
-- CAM  23-Jan-2010  10551 : Added mse_volume_jndhtml.
-- CAM  23-Jan-2010  10552 : Added JND to mse_volume.
-- --------------------------------------------------------

--
-- To recreate this file, dump data for the following tables WITHOUT structure:
--
--    mse_author
--    mse_volume
--    mse_volume_jndhtml
--
-- Note data for the following tables is not required, as they can be recreated from source files
--
--    mse_article
--    mse_text
--

-- --------------------------------------------------------
-- DELETE ALL FROM THIS SECTION DOWNWARDS, THEN PASTE NEW
-- --------------------------------------------------------

--
-- Dumping data for table mse_author
--

INSERT INTO mse_author VALUES ('CAC', 'C. A. Coates');
INSERT INTO mse_author VALUES ('FER', 'F. E. Raven');
INSERT INTO mse_author VALUES ('JBS', 'J. B. Stoney');
INSERT INTO mse_author VALUES ('JND', 'J. N. Darby');
INSERT INTO mse_author VALUES ('JT', 'J. Taylor, Snr');

--
-- Dumping data for table mse_volume
--

INSERT INTO mse_volume VALUES ('CAC', 1, 'An Outline of Genesis', '2008-06-08 14:04:33', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac1.txt');
INSERT INTO mse_volume VALUES ('CAC', 2, 'An Outline of Exodus', '2007-10-22 17:11:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac2.txt');
INSERT INTO mse_volume VALUES ('CAC', 3, 'An Outline of Leviticus', '2007-10-22 17:11:28', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac3.txt');
INSERT INTO mse_volume VALUES ('CAC', 4, 'An Outline of the Book of Numbers', '2007-10-22 17:11:30', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac4.txt');
INSERT INTO mse_volume VALUES ('CAC', 5, 'An Outline of the Book of Deuteronomy', '2007-10-22 17:11:33', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac5.txt');
INSERT INTO mse_volume VALUES ('CAC', 6, 'An Outline of Joshua, Judges and Ruth', '2007-10-22 17:11:36', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac6.txt');
INSERT INTO mse_volume VALUES ('CAC', 7, 'An Outline of The Song of Songs', '2007-10-22 17:11:39', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac7.txt');
INSERT INTO mse_volume VALUES ('CAC', 8, 'An Outline of the Minor Prophets', '2007-10-22 17:11:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac8.txt');
INSERT INTO mse_volume VALUES ('CAC', 9, 'An Outline of Mark''s Gospel and Other Ministry', '2007-10-22 17:11:41', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac9.txt');
INSERT INTO mse_volume VALUES ('CAC', 10, 'An Outline of Luke''s Gospel', '2007-10-22 17:11:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac10.txt');
INSERT INTO mse_volume VALUES ('CAC', 11, 'An Outline of Romans', '2008-06-08 14:03:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac11.txt');
INSERT INTO mse_volume VALUES ('CAC', 12, 'An Outline of the Epistle of James', '2007-10-22 17:11:51', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac12.txt');
INSERT INTO mse_volume VALUES ('CAC', 13, 'An Outline of "The Revelation"', '2007-10-22 17:11:54', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac13.txt');
INSERT INTO mse_volume VALUES ('CAC', 14, 'The True Grace of God', '2007-10-22 17:11:56', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac14.txt');
INSERT INTO mse_volume VALUES ('CAC', 15, 'The Believer Established', '2007-10-22 17:11:59', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac15.txt');
INSERT INTO mse_volume VALUES ('CAC', 16, 'Favour and Freedom', '2007-10-22 17:12:02', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac16.txt');
INSERT INTO mse_volume VALUES ('CAC', 17, 'The Food of Life', '2007-10-22 17:12:03', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac17.txt');
INSERT INTO mse_volume VALUES ('CAC', 18, 'The House of God', '2007-10-22 17:12:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac18.txt');
INSERT INTO mse_volume VALUES ('CAC', 19, 'The Paths of Life', '2007-10-22 17:12:05', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac19.txt');
INSERT INTO mse_volume VALUES ('CAC', 20, 'Spiritual Blessings', '2007-10-22 17:12:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac20.txt');
INSERT INTO mse_volume VALUES ('CAC', 21, 'A Sure Foundation', '2007-10-22 17:12:09', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac21.txt');
INSERT INTO mse_volume VALUES ('CAC', 22, 'Letters of C.A. Coates', '2007-10-22 17:12:10', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac22.txt');
INSERT INTO mse_volume VALUES ('CAC', 23, 'An Outline of the Epistle to the Hebrews', '2007-10-22 17:12:14', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac23.txt');
INSERT INTO mse_volume VALUES ('CAC', 24, 'Notes of Readings on the Lord''s Supper', '2007-10-22 17:12:16', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac24.txt');
INSERT INTO mse_volume VALUES ('CAC', 25, 'Outlines of the Epistles of Paul to the Corinthians', '2007-10-22 17:12:16', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac25.txt');
INSERT INTO mse_volume VALUES ('CAC', 26, 'Outline of Ephesians', '2007-10-22 17:12:19', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac26.txt');
INSERT INTO mse_volume VALUES ('CAC', 27, 'Outlines of Samuel, Kings and the Chronicles', '2007-10-22 17:12:20', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac27.txt');
INSERT INTO mse_volume VALUES ('CAC', 28, 'Notes of Readings on Matthew''s Gospel', '2007-10-22 17:12:22', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac28.txt');
INSERT INTO mse_volume VALUES ('CAC', 29, 'An Outline of John''s Gospel', '2007-10-22 17:12:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac29.txt');
INSERT INTO mse_volume VALUES ('CAC', 30, 'Miscellaneous Ministry on the Old Testament', '2007-10-22 17:12:26', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac30.txt');
INSERT INTO mse_volume VALUES ('CAC', 31, 'Miscellaneous Ministry on the New Testament Matthew-Romans', '2007-10-22 17:12:30', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac31.txt');
INSERT INTO mse_volume VALUES ('CAC', 32, 'Miscellaneous Ministry on the New Testament Corinthians-Colossians', '2007-10-22 17:12:34', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac32.txt');
INSERT INTO mse_volume VALUES ('CAC', 33, 'Miscellaneous Ministry on the New Testament Thessalonians-Revelation', '2007-10-22 17:12:39', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac33.txt');
INSERT INTO mse_volume VALUES ('CAC', 34, 'Words in Season', '2007-10-22 17:12:43', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac34.txt');
INSERT INTO mse_volume VALUES ('CAC', 35, 'Outlines of the Books of the Chronicles', '2007-10-22 17:12:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac35.txt');
INSERT INTO mse_volume VALUES ('CAC', 36, 'Remarks on a pamphlet by A. J. Pollock entitled "The Eternal Son"', '2007-10-22 17:12:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac36.txt');
INSERT INTO mse_volume VALUES ('CAC', 37, 'A Message for You', '2007-10-22 17:12:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\cac\\\\cac37.txt');
INSERT INTO mse_volume VALUES ('FER', 1, '', '2007-10-22 17:12:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer1.txt');
INSERT INTO mse_volume VALUES ('FER', 2, '', '2007-10-22 17:12:51', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer2.txt');
INSERT INTO mse_volume VALUES ('FER', 3, '', '2007-10-22 17:12:55', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer3.txt');
INSERT INTO mse_volume VALUES ('FER', 4, '', '2007-10-22 17:12:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer4.txt');
INSERT INTO mse_volume VALUES ('FER', 5, 'Notes of readings on the Gospel of John', '2007-10-22 17:13:01', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer5.txt');
INSERT INTO mse_volume VALUES ('FER', 6, '', '2007-10-22 17:13:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer6.txt');
INSERT INTO mse_volume VALUES ('FER', 7, '', '2007-10-22 17:13:07', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer7.txt');
INSERT INTO mse_volume VALUES ('FER', 8, '', '2007-10-22 17:13:10', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer8.txt');
INSERT INTO mse_volume VALUES ('FER', 9, '', '2007-10-22 17:13:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer9.txt');
INSERT INTO mse_volume VALUES ('FER', 10, '', '2007-10-22 17:13:16', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer10.txt');
INSERT INTO mse_volume VALUES ('FER', 11, '', '2007-10-22 17:13:20', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer11.txt');
INSERT INTO mse_volume VALUES ('FER', 12, '', '2007-10-22 17:13:23', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer12.txt');
INSERT INTO mse_volume VALUES ('FER', 13, '', '2007-10-22 17:13:26', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer13.txt');
INSERT INTO mse_volume VALUES ('FER', 14, '', '2007-10-22 17:13:28', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer14.txt');
INSERT INTO mse_volume VALUES ('FER', 15, '', '2007-10-22 17:13:32', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer15.txt');
INSERT INTO mse_volume VALUES ('FER', 16, '', '2007-10-22 17:13:35', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer16.txt');
INSERT INTO mse_volume VALUES ('FER', 17, '', '2007-10-22 17:13:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer17.txt');
INSERT INTO mse_volume VALUES ('FER', 18, '', '2007-10-22 17:13:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer18.txt');
INSERT INTO mse_volume VALUES ('FER', 19, '', '2007-10-22 17:13:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer19.txt');
INSERT INTO mse_volume VALUES ('FER', 20, '', '2007-10-22 17:13:44', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer20.txt');
INSERT INTO mse_volume VALUES ('FER', 21, 'Letters', '2007-10-22 17:13:45', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\fer\\\\fer21.txt');
INSERT INTO mse_volume VALUES ('JBS', 1, '', '2007-10-22 17:13:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs1.txt');
INSERT INTO mse_volume VALUES ('JBS', 2, '', '2007-10-22 17:13:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs2.txt');
INSERT INTO mse_volume VALUES ('JBS', 3, '', '2007-10-22 17:13:56', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs3.txt');
INSERT INTO mse_volume VALUES ('JBS', 4, '', '2007-10-22 17:13:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs4.txt');
INSERT INTO mse_volume VALUES ('JBS', 5, '', '2007-10-22 17:14:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs5.txt');
INSERT INTO mse_volume VALUES ('JBS', 6, '', '2007-10-22 17:14:03', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs6.txt');
INSERT INTO mse_volume VALUES ('JBS', 7, '', '2007-10-22 17:14:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs7.txt');
INSERT INTO mse_volume VALUES ('JBS', 8, '', '2007-10-22 17:14:09', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs8.txt');
INSERT INTO mse_volume VALUES ('JBS', 9, '', '2007-10-22 17:14:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs9.txt');
INSERT INTO mse_volume VALUES ('JBS', 10, '', '2007-10-22 17:14:15', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs10.txt');
INSERT INTO mse_volume VALUES ('JBS', 11, '', '2007-10-22 17:14:17', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs11.txt');
INSERT INTO mse_volume VALUES ('JBS', 12, '', '2007-10-22 17:14:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs12.txt');
INSERT INTO mse_volume VALUES ('JBS', 13, '', '2007-10-22 17:14:24', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs13.txt');
INSERT INTO mse_volume VALUES ('JBS', 14, 'Letters 1', '2007-10-22 17:14:27', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs14.txt');
INSERT INTO mse_volume VALUES ('JBS', 15, 'Letters 2', '2007-10-22 17:14:29', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs15.txt');
INSERT INTO mse_volume VALUES ('JBS', 16, 'Letters 3', '2007-10-22 17:14:33', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs16.txt');
INSERT INTO mse_volume VALUES ('JBS', 17, 'From Glory to Glory', '2007-10-22 17:14:36', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jbs\\\\jbs17.txt');
INSERT INTO mse_volume VALUES ('JT', 1, '', '2007-10-22 17:14:37', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt1.txt');
INSERT INTO mse_volume VALUES ('JT', 2, '', '2007-10-22 17:14:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt2.txt');
INSERT INTO mse_volume VALUES ('JT', 3, '', '2007-10-22 17:14:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt3.txt');
INSERT INTO mse_volume VALUES ('JT', 4, '', '2007-10-22 17:14:54', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt4.txt');
INSERT INTO mse_volume VALUES ('JT', 5, '', '2007-10-22 17:20:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt5.txt');
INSERT INTO mse_volume VALUES ('JT', 6, '', '2007-10-22 17:20:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt6.txt');
INSERT INTO mse_volume VALUES ('JT', 7, '', '2007-10-22 17:20:17', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt7.txt');
INSERT INTO mse_volume VALUES ('JT', 8, '', '2007-10-22 17:20:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt8.txt');
INSERT INTO mse_volume VALUES ('JT', 9, '', '2007-10-22 17:20:28', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt9.txt');
INSERT INTO mse_volume VALUES ('JT', 10, '', '2007-10-22 17:14:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt10.txt');
INSERT INTO mse_volume VALUES ('JT', 11, '', '2007-10-22 17:15:02', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt11.txt');
INSERT INTO mse_volume VALUES ('JT', 12, '', '2007-10-22 17:15:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt12.txt');
INSERT INTO mse_volume VALUES ('JT', 13, '', '2007-10-22 17:15:07', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt13.txt');
INSERT INTO mse_volume VALUES ('JT', 14, '', '2007-10-22 17:15:14', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt14.txt');
INSERT INTO mse_volume VALUES ('JT', 15, '', '2007-10-22 17:15:17', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt15.txt');
INSERT INTO mse_volume VALUES ('JT', 16, '', '2007-10-22 17:15:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt16.txt');
INSERT INTO mse_volume VALUES ('JT', 17, '', '2007-10-22 17:15:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt17.txt');
INSERT INTO mse_volume VALUES ('JT', 18, '', '2007-10-22 17:15:31', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt18.txt');
INSERT INTO mse_volume VALUES ('JT', 19, '', '2007-10-22 17:15:34', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt19.txt');
INSERT INTO mse_volume VALUES ('JT', 20, '', '2007-10-22 17:15:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt20.txt');
INSERT INTO mse_volume VALUES ('JT', 21, '', '2007-10-22 17:15:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt21.txt');
INSERT INTO mse_volume VALUES ('JT', 22, '', '2007-10-22 17:15:44', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt22.txt');
INSERT INTO mse_volume VALUES ('JT', 23, '', '2007-10-22 17:15:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt23.txt');
INSERT INTO mse_volume VALUES ('JT', 24, '', '2007-10-22 17:15:50', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt24.txt');
INSERT INTO mse_volume VALUES ('JT', 25, '', '2007-10-22 17:15:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt25.txt');
INSERT INTO mse_volume VALUES ('JT', 26, '', '2007-10-22 17:15:56', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt26.txt');
INSERT INTO mse_volume VALUES ('JT', 27, '', '2007-10-22 17:15:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt27.txt');
INSERT INTO mse_volume VALUES ('JT', 28, '', '2007-10-22 17:16:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt28.txt');
INSERT INTO mse_volume VALUES ('JT', 29, '', '2007-10-22 17:16:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt29.txt');
INSERT INTO mse_volume VALUES ('JT', 30, '', '2007-10-22 17:16:09', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt30.txt');
INSERT INTO mse_volume VALUES ('JT', 31, '', '2007-10-22 17:16:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt31.txt');
INSERT INTO mse_volume VALUES ('JT', 32, '', '2008-06-03 18:28:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt32.txt');
INSERT INTO mse_volume VALUES ('JT', 33, '', '2007-10-22 17:16:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt33.txt');
INSERT INTO mse_volume VALUES ('JT', 34, '', '2007-10-22 17:16:27', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt34.txt');
INSERT INTO mse_volume VALUES ('JT', 35, '', '2007-10-22 17:16:31', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt35.txt');
INSERT INTO mse_volume VALUES ('JT', 36, '', '2007-10-22 17:16:34', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt36.txt');
INSERT INTO mse_volume VALUES ('JT', 37, '', '2007-10-22 17:16:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt37.txt');
INSERT INTO mse_volume VALUES ('JT', 38, '', '2007-10-22 17:16:44', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt38.txt');
INSERT INTO mse_volume VALUES ('JT', 39, '', '2007-10-22 17:16:47', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt39.txt');
INSERT INTO mse_volume VALUES ('JT', 40, '', '2007-10-22 17:16:51', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt40.txt');
INSERT INTO mse_volume VALUES ('JT', 41, '', '2007-10-22 17:16:54', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt41.txt');
INSERT INTO mse_volume VALUES ('JT', 42, '', '2007-10-22 17:16:57', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt42.txt');
INSERT INTO mse_volume VALUES ('JT', 43, '', '2007-10-22 17:17:02', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt43.txt');
INSERT INTO mse_volume VALUES ('JT', 44, '', '2007-10-22 17:17:05', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt44.txt');
INSERT INTO mse_volume VALUES ('JT', 45, '', '2007-10-22 17:17:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt45.txt');
INSERT INTO mse_volume VALUES ('JT', 46, '', '2007-10-22 17:17:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt46.txt');
INSERT INTO mse_volume VALUES ('JT', 47, '', '2007-10-22 17:17:15', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt47.txt');
INSERT INTO mse_volume VALUES ('JT', 48, '', '2007-10-22 17:17:19', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt48.txt');
INSERT INTO mse_volume VALUES ('JT', 49, '', '2007-10-22 17:17:22', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt49.txt');
INSERT INTO mse_volume VALUES ('JT', 50, 'Divine Names', '2007-10-22 17:17:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt50.txt');
INSERT INTO mse_volume VALUES ('JT', 51, '', '2007-10-22 17:17:29', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt51.txt');
INSERT INTO mse_volume VALUES ('JT', 52, '', '2007-10-22 17:17:32', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt52.txt');
INSERT INTO mse_volume VALUES ('JT', 53, '', '2007-10-22 17:17:36', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt53.txt');
INSERT INTO mse_volume VALUES ('JT', 54, '', '2007-10-22 17:17:39', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt54.txt');
INSERT INTO mse_volume VALUES ('JT', 55, '', '2007-10-22 17:17:44', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt55.txt');
INSERT INTO mse_volume VALUES ('JT', 56, '', '2007-10-22 17:17:47', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt56.txt');
INSERT INTO mse_volume VALUES ('JT', 57, '', '2007-10-22 17:17:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt57.txt');
INSERT INTO mse_volume VALUES ('JT', 58, '', '2007-10-22 17:17:55', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt58.txt');
INSERT INTO mse_volume VALUES ('JT', 59, '', '2007-10-22 17:17:59', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt59.txt');
INSERT INTO mse_volume VALUES ('JT', 60, '', '2007-10-22 17:18:01', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt60.txt');
INSERT INTO mse_volume VALUES ('JT', 61, '', '2007-10-22 17:18:06', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt61.txt');
INSERT INTO mse_volume VALUES ('JT', 62, '', '2007-10-22 17:18:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt62.txt');
INSERT INTO mse_volume VALUES ('JT', 63, '', '2007-10-22 17:18:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt63.txt');
INSERT INTO mse_volume VALUES ('JT', 64, '', '2007-10-22 17:18:15', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt64.txt');
INSERT INTO mse_volume VALUES ('JT', 65, '', '2007-10-22 17:18:19', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt65.txt');
INSERT INTO mse_volume VALUES ('JT', 66, '', '2007-10-22 17:18:23', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt66.txt');
INSERT INTO mse_volume VALUES ('JT', 67, '', '2007-10-22 17:18:25', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt67.txt');
INSERT INTO mse_volume VALUES ('JT', 68, '', '2007-10-22 17:18:31', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt68.txt');
INSERT INTO mse_volume VALUES ('JT', 69, '', '2007-10-22 17:18:35', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt69.txt');
INSERT INTO mse_volume VALUES ('JT', 70, '', '2007-10-22 17:18:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt70.txt');
INSERT INTO mse_volume VALUES ('JT', 71, '', '2007-10-22 17:18:42', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt71.txt');
INSERT INTO mse_volume VALUES ('JT', 72, '', '2007-10-22 17:18:50', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt72.txt');
INSERT INTO mse_volume VALUES ('JT', 73, '', '2007-10-22 17:18:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt73.txt');
INSERT INTO mse_volume VALUES ('JT', 74, '', '2007-10-22 17:18:54', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt74.txt');
INSERT INTO mse_volume VALUES ('JT', 75, '', '2007-10-22 17:18:58', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt75.txt');
INSERT INTO mse_volume VALUES ('JT', 76, '', '2007-10-22 17:19:01', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt76.txt');
INSERT INTO mse_volume VALUES ('JT', 77, '', '2007-10-22 17:19:05', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt77.txt');
INSERT INTO mse_volume VALUES ('JT', 78, '', '2007-10-22 17:19:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt78.txt');
INSERT INTO mse_volume VALUES ('JT', 79, '', '2007-10-22 17:19:12', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt79.txt');
INSERT INTO mse_volume VALUES ('JT', 80, '', '2007-10-22 17:19:15', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt80.txt');
INSERT INTO mse_volume VALUES ('JT', 81, '', '2007-10-22 17:19:19', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt81.txt');
INSERT INTO mse_volume VALUES ('JT', 82, '', '2007-10-22 17:19:23', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt82.txt');
INSERT INTO mse_volume VALUES ('JT', 83, '', '2007-10-22 17:19:26', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt83.txt');
INSERT INTO mse_volume VALUES ('JT', 84, '', '2007-10-22 17:20:37', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt84.txt');
INSERT INTO mse_volume VALUES ('JT', 85, '', '2007-10-22 17:19:30', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt85.txt');
INSERT INTO mse_volume VALUES ('JT', 86, '', '2007-10-22 17:20:40', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt86.txt');
INSERT INTO mse_volume VALUES ('JT', 87, '', '2007-10-22 17:20:43', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt87.txt');
INSERT INTO mse_volume VALUES ('JT', 88, '', '2007-10-22 17:20:46', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt88.txt');
INSERT INTO mse_volume VALUES ('JT', 89, '', '2007-10-22 17:20:49', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt89.txt');
INSERT INTO mse_volume VALUES ('JT', 90, '', '2007-10-22 17:20:52', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt90.txt');
INSERT INTO mse_volume VALUES ('JT', 91, '', '2007-10-22 17:20:57', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt91.txt');
INSERT INTO mse_volume VALUES ('JT', 92, '', '2007-10-22 17:21:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt92.txt');
INSERT INTO mse_volume VALUES ('JT', 93, '', '2007-10-22 17:21:04', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt93.txt');
INSERT INTO mse_volume VALUES ('JT', 94, '', '2007-10-22 17:21:08', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt94.txt');
INSERT INTO mse_volume VALUES ('JT', 95, '', '2007-10-22 17:21:14', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt95.txt');
INSERT INTO mse_volume VALUES ('JT', 96, '', '2007-10-22 17:21:17', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt96.txt');
INSERT INTO mse_volume VALUES ('JT', 97, '', '2007-10-22 17:21:21', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt97.txt');
INSERT INTO mse_volume VALUES ('JT', 98, '', '2007-10-22 17:21:24', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt98.txt');
INSERT INTO mse_volume VALUES ('JT', 99, '', '2007-10-22 17:21:29', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt99.txt');
INSERT INTO mse_volume VALUES ('JT', 100, '', '2007-10-22 17:19:34', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt100.txt');
INSERT INTO mse_volume VALUES ('JT', 101, 'Volume 100a', '2007-10-22 17:19:38', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt101.txt');
INSERT INTO mse_volume VALUES ('JT', 102, 'Letters - Volume 1', '2007-10-22 17:19:39', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt102.txt');
INSERT INTO mse_volume VALUES ('JT', 103, 'Letters - Volume 2', '2007-10-22 17:19:45', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jt\\\\jt103.txt');
INSERT INTO mse_volume VALUES ('JND',1, 'CW Vol 1 - Ecclesiastical 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd1.txt');
INSERT INTO mse_volume VALUES ('JND',2, 'CW Vol 2 - Prophetic 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd2.txt');
INSERT INTO mse_volume VALUES ('JND',3, 'CW Vol 3 - Doctrinal 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd3.txt');
INSERT INTO mse_volume VALUES ('JND',4, 'CW Vol 4 - Ecclesiastical 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd4.txt');
INSERT INTO mse_volume VALUES ('JND',5, 'CW Vol 5 - Prophetic 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd5.txt');
INSERT INTO mse_volume VALUES ('JND',6, 'CW Vol 6 - Apologetic 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd6.txt');
INSERT INTO mse_volume VALUES ('JND',7, 'CW Vol 7 - Doctrinal 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd7.txt');
INSERT INTO mse_volume VALUES ('JND',8, 'CW Vol 8 - Prophetic 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd8.txt');
INSERT INTO mse_volume VALUES ('JND',9, 'CW Vol 9 - Apologetic 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd9.txt');
INSERT INTO mse_volume VALUES ('JND',10, 'CW Vol 10 - Doctrinal 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd10.txt');
INSERT INTO mse_volume VALUES ('JND',11, 'CW Vol 11 - Prophetic 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd11.txt');
INSERT INTO mse_volume VALUES ('JND',12, 'CW Vol 12 - Evangelical 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd12.txt');
INSERT INTO mse_volume VALUES ('JND',13, 'CW Vol 13 - Critical 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd13.txt');
INSERT INTO mse_volume VALUES ('JND',14, 'CW Vol 14 - Ecclesiastical 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd14.txt');
INSERT INTO mse_volume VALUES ('JND',15, 'CW Vol 15 - Doctrinal 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd15.txt');
INSERT INTO mse_volume VALUES ('JND',16, 'CW Vol 16 - Practical 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd16.txt');
INSERT INTO mse_volume VALUES ('JND',17, 'CW Vol 17 - Practical 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd17.txt');
INSERT INTO mse_volume VALUES ('JND',18, 'CW Vol 18 - Doctrinal 5', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd18.txt');
INSERT INTO mse_volume VALUES ('JND',19, 'CW Vol 19 - Expository 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd19.txt');
INSERT INTO mse_volume VALUES ('JND',20, 'CW Vol 20 - Ecclesiastical 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd20.txt');
INSERT INTO mse_volume VALUES ('JND',21, 'CW Vol 21 - Evangelical 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd21.txt');
INSERT INTO mse_volume VALUES ('JND',22, 'CW Vol 22 - Doctrinal 6', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd22.txt');
INSERT INTO mse_volume VALUES ('JND',23, 'CW Vol 23 - Doctrinal 7', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd23.txt');
INSERT INTO mse_volume VALUES ('JND',24, 'CW Vol 24 - Expository 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd24.txt');
INSERT INTO mse_volume VALUES ('JND',25, 'CW Vol 25 - Expository 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd25.txt');
INSERT INTO mse_volume VALUES ('JND',26, 'CW Vol 26 - Expository 5', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd26.txt');
INSERT INTO mse_volume VALUES ('JND',27, 'CW Vol 27 - Expository 6', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd27.txt');
INSERT INTO mse_volume VALUES ('JND',28, 'CW Vol 28 - Expository 7', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd28.txt');
INSERT INTO mse_volume VALUES ('JND',29, 'CW Vol 29 - Doctrinal 8', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd29.txt');
INSERT INTO mse_volume VALUES ('JND',30, 'CW Vol 30 - Expository 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd30.txt');
INSERT INTO mse_volume VALUES ('JND',31, 'CW Vol 31 - Doctrinal 9', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd31.txt');
INSERT INTO mse_volume VALUES ('JND',32, 'CW Vol 32 - Miscellaneous 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd32.txt');
INSERT INTO mse_volume VALUES ('JND',33, 'CW Vol 33 - Miscellaneous 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd33.txt');
INSERT INTO mse_volume VALUES ('JND',34, 'CW Vol 34 - Miscellaneous 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd34.txt');
INSERT INTO mse_volume VALUES ('JND',35, 'N&C Vol 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd35.txt');
INSERT INTO mse_volume VALUES ('JND',36, 'N&C Vol 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd36.txt');
INSERT INTO mse_volume VALUES ('JND',37, 'N&C Vol 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd37.txt');
INSERT INTO mse_volume VALUES ('JND',38, 'N&C Vol 4', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd38.txt');
INSERT INTO mse_volume VALUES ('JND',39, 'N&C Vol 5', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd39.txt');
INSERT INTO mse_volume VALUES ('JND',40, 'N&C Vol 6', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd40.txt');
INSERT INTO mse_volume VALUES ('JND',41, 'N&C Vol 7', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd41.txt');
INSERT INTO mse_volume VALUES ('JND',42, 'N&C Notes and Jottings', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd42.txt');
INSERT INTO mse_volume VALUES ('JND',43, 'Synopsis: Genesis - 2 Chronicles', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd43.txt');
INSERT INTO mse_volume VALUES ('JND',44, 'Synopsis: Ezra - Malachi', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd44.txt');
INSERT INTO mse_volume VALUES ('JND',45, 'Synopsis: Matthew - John', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd45.txt');
INSERT INTO mse_volume VALUES ('JND',46, 'Synopsis: Acts - Philippians', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd46.txt');
INSERT INTO mse_volume VALUES ('JND',47, 'Synopsis: Colossians - Revelation', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd47.txt');
INSERT INTO mse_volume VALUES ('JND',48, 'Misc: The World or Christ?', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd48.txt');
INSERT INTO mse_volume VALUES ('JND',49, 'Misc: What the World is and how a Christian can live in it', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd49.txt');
INSERT INTO mse_volume VALUES ('JND',50, 'Letters Vol 1', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd50.txt');
INSERT INTO mse_volume VALUES ('JND',51, 'Letters Vol 2', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd51.txt');
INSERT INTO mse_volume VALUES ('JND',52, 'Letters Vol 3', '2010-01-23 08:30:00', 'C:\\\\Dev\\\\Scriptures\\\\MSE\\\\jnd\\\\jnd52.txt');

INSERT INTO mse_volume_jndhtml VALUES ('JND',1, 'CW Vol 1 - Ecclesiastical 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd1.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',2, 'CW Vol 2 - Prophetic 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd2.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',3, 'CW Vol 3 - Doctrinal 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd3.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',4, 'CW Vol 4 - Ecclesiastical 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd4.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',5, 'CW Vol 5 - Prophetic 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd5.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',6, 'CW Vol 6 - Apologetic 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd6.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',7, 'CW Vol 7 - Doctrinal 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd7.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',8, 'CW Vol 8 - Prophetic 3', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd8.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',9, 'CW Vol 9 - Apologetic 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd9.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',10, 'CW Vol 10 - Doctrinal 3', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd10.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',11, 'CW Vol 11 - Prophetic 4', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd11.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',12, 'CW Vol 12 - Evangelical 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd12.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',13, 'CW Vol 13 - Critical 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd13.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',14, 'CW Vol 14 - Ecclesiastical 3', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd14.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',15, 'CW Vol 15 - Doctrinal 4', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd15.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',16, 'CW Vol 16 - Practical 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd16.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',17, 'CW Vol 17 - Practical 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd17.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',18, 'CW Vol 18 - Doctrinal 5', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd18.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',19, 'CW Vol 19 - Expository 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd19.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',20, 'CW Vol 20 - Ecclesiastical 4', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd20.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',21, 'CW Vol 21 - Evangelical 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd21.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',22, 'CW Vol 22 - Doctrinal 6', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd22.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',23, 'CW Vol 23 - Doctrinal 7', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd23.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',24, 'CW Vol 24 - Expository 3', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd24.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',25, 'CW Vol 25 - Expository 4', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd25.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',26, 'CW Vol 26 - Expository 5', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd26.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',27, 'CW Vol 27 - Expository 6', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd27.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',28, 'CW Vol 28 - Expository 7', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd28.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',29, 'CW Vol 29 - Doctrinal 8', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd29.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',30, 'CW Vol 30 - Expository 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd30.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',31, 'CW Vol 31 - Doctrinal 9', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd31.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',32, 'CW Vol 32 - Miscellaneous 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd32.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',33, 'CW Vol 33 - Miscellaneous 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd33.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',34, 'CW Vol 34 - Miscellaneous 3', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd34.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',35, 'N&C Vol 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd35.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',36, 'N&C Vol 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd36.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',37, 'N&C Vol 3', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd37.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',38, 'N&C Vol 4', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd38.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',39, 'N&C Vol 5', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd39.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',40, 'N&C Vol 6', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd40.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',41, 'N&C Vol 7', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd41.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',42, 'N&C Notes and Jottings', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd42.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',43, 'Synopsis: Genesis - 2 Chronicles', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd43.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',44, 'Synopsis: Ezra - Malachi', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd44.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',45, 'Synopsis: Matthew - John', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd45.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',46, 'Synopsis: Acts - Philippians', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd46.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',47, 'Synopsis: Colossians - Revelation', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd47.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',48, 'Misc: The World or Christ?', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd48.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',49, 'Misc: What the World is and how a Christian can live in it', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd49.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',50, 'Letters Vol 1', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd50.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',51, 'Letters Vol 2', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd51.htm');
INSERT INTO mse_volume_jndhtml VALUES ('JND',52, 'Letters Vol 3', '2010-01-23 08:30:00', 'C:\\\\Program Files\\\\mse\\\\jnd\\\\jnd52.htm');
