-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2007,2010 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: diff.sql 1149 2010-01-23 12:34:43Z craig $
--
-- Who  When         Why
-- CAM  23-Jan-2010  10552 : Added JND to mse_volume.
-- --------------------------------------------------------

DELETE FROM mse_volume WHERE author='JND' AND vol=1;
DELETE FROM mse_volume WHERE author='JND' AND vol=2;

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
