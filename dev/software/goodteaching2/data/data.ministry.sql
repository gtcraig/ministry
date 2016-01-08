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
-- CAM  23-Jan-2010  10551 : Added mse_volume.
-- CAM  23-Jan-2010  10552 : Added JND to mse_volume.
-- CAM  28-Dec-2011  gc005 : Added all volumes with correct paths and title fixes.
-- --------------------------------------------------------

--
-- To recreate this file, dump data for the following tables WITHOUT structure:
--
--    mse_author
--    mse_volume
--    mse_volume
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

INSERT INTO mse_author VALUES ('CAC', 'C. A. Coates', 'Charles Andrew Coates', 'Coates, Charles');
INSERT INTO mse_author VALUES ('FER', 'F. E. Raven', 'Frederick Edward Raven', 'Raven, Frederick');
INSERT INTO mse_author VALUES ('GRC', 'G. R. Cowell', 'Gerald Robert Cowell', 'Cowell, Gerald ');
INSERT INTO mse_author VALUES ('JBS', 'J. B. Stoney', 'James Butler Stoney', 'Stoney, James');
INSERT INTO mse_author VALUES ('JND', 'J. N. Darby', 'John Nelson Darby', 'Darby, John');
INSERT INTO mse_author VALUES ('JT', 'J. Taylor, Snr', 'James Taylor, Snr', 'Taylor, James, Snr');
INSERT INTO mse_author VALUES ('VAR', 'Various', 'Various', 'Various');


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
