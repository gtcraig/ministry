-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2009 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: data.bible.sql 1102 2009-12-29 16:51:54Z craig $
--
-- Who  When         Why
-- CAM  29-Dec-2009  10514 : File created.
-- --------------------------------------------------------

--
-- To recreate this file, dump data for the following tables WITHOUT structure:
--
--    mse_bible_book
--    mse_bible_version
--
-- Note data for the following tables is not required, as they can be recreated from source files
--
--    mse_bible_footnote
--    mse_bible_footnote_ref
--    mse_bible_footnote_xref
--    mse_bible_ref
--    mse_bible_ref_error
--    mse_bible_text

-- --------------------------------------------------------
-- DELETE ALL FROM THIS SECTION DOWNWARDS, THEN PASTE NEW
-- --------------------------------------------------------

INSERT INTO mse_bible_book VALUES (1, 'Genesis', 'OT', 1, NULL, 'In the beginning God created the heavens and the earth.');
INSERT INTO mse_bible_book VALUES (2, 'Exodus', 'OT', 2, NULL, 'And these are the names of the sons of Israel who had come into Egypt; with Jacob had they come, each with his household:');
INSERT INTO mse_bible_book VALUES (3, 'Leviticus', 'OT', 3, NULL, 'And Jehovah called to Moses and spoke to him out of the tent of meeting, saying,');
INSERT INTO mse_bible_book VALUES (4, 'Numbers', 'OT', 4, NULL, 'And Jehovah spoke to Moses in the wilderness of Sinai in the tent of meeting, on the first of the second month, in the second year after their departure from the land of Egypt, saying,');
INSERT INTO mse_bible_book VALUES (5, 'Deuteronomy', 'OT', 5, NULL, 'These are the words which Moses spoke to all Israel on this side the Jordan, in the wilderness, in the plain, opposite to Suph, between Paran and Tophel, Laban, Hazeroth, and Dizahab.');
INSERT INTO mse_bible_book VALUES (6, 'Joshua', 'OT', 6, NULL, 'And it came to pass after the death of Moses the servant of Jehovah, that Jehovah spoke to Joshua the son of Nun, Moses'' attendant, saying,');
INSERT INTO mse_bible_book VALUES (7, 'Judges', 'OT', 7, NULL, 'After the death of Joshua the people of Israel inquired of the LORD, "Who shall go up first for us against the Canaanites, to fight against them?"');
INSERT INTO mse_bible_book VALUES (8, 'Ruth', 'OT', 8, NULL, 'And it came to pass in the days when the judges ruled, that there was a famine in the land. And a certain man went from Bethlehem-Judah, to sojourn in the country of Moab, he, and his wife, and his two sons.');
INSERT INTO mse_bible_book VALUES (9, '1 Samuel', 'OT', 9, NULL, 'And there was a certain man of Ramathaim-zophim, of mount Ephraim, and his name was Elkanah, the son of Jeroham, the son of Elihu, the son of Tohu, the son of Zuph, an Ephrathite.');
INSERT INTO mse_bible_book VALUES (10, '2 Samuel', 'OT', 10, NULL, 'And it came to pass after the death of Saul, when David had returned from the slaughter of the Amalekites, that David abode two days in Ziklag.');
INSERT INTO mse_bible_book VALUES (11, '1 Kings', 'OT', 11, NULL, 'And king David was old [and] advanced in age; and they covered him with clothes, but he obtained no warmth.');
INSERT INTO mse_bible_book VALUES (12, '2 Kings', 'OT', 12, NULL, 'And Moab rebelled against Israel after the death of Ahab.');
INSERT INTO mse_bible_book VALUES (13, '1 Chronicles', 'OT', 13, NULL, 'Adam, Seth, Enosh,');
INSERT INTO mse_bible_book VALUES (14, '2 Chronicles', 'OT', 14, NULL, 'And Solomon the son of David was strengthened in his kingdom, and Jehovah his God was with him and magnified him exceedingly.');
INSERT INTO mse_bible_book VALUES (15, 'Ezra', 'OT', 15, NULL, 'And in the first year of Cyrus king of Persia, that the word of Jehovah by the mouth of Jeremiah might be accomplished, Jehovah stirred up the spirit of Cyrus king of Persia, and he made a proclamation throughout his kingdom, and also in writing, saying,');
INSERT INTO mse_bible_book VALUES (16, 'Nehemiah', 'OT', 16, NULL, 'The words of Nehemiah the son of Hachaliah. And it came to pass in the month Chislev, in the twentieth year, as I was in Shushan the fortress,');
INSERT INTO mse_bible_book VALUES (17, 'Esther', 'OT', 17, NULL, 'And it came to pass in the days of Ahasuerus (that is, the Ahasuerus that reigned from India even to Ethiopia, over a hundred and twenty-seven provinces),');
INSERT INTO mse_bible_book VALUES (18, 'Job', 'OT', 18, NULL, 'There was a man in the land of Uz whose name was Job; and this man was perfect and upright, and one that feared God and abstained from evil.');
INSERT INTO mse_bible_book VALUES (19, 'Psalm', 'OT', 19, NULL, 'Blessed is the man that walketh not in the counsel of the wicked, and standeth not in the way of sinners, and sitteth not in the seat of scorners;');
INSERT INTO mse_bible_book VALUES (20, 'Proverbs', 'OT', 20, NULL, 'Proverbs of Solomon, son of David, king of Israel:');
INSERT INTO mse_bible_book VALUES (21, 'Ecclesiastes', 'OT', 21, NULL, 'The words of the Preacher, the son of David, king in Jerusalem.');
INSERT INTO mse_bible_book VALUES (22, 'Song of Songs', 'OT', 22, NULL, 'The song of songs, which is Solomon''s.');
INSERT INTO mse_bible_book VALUES (23, 'Isaiah', 'OT', 23, NULL, 'The vision of Isaiah the son of Amos, which he saw concerning Judah and Jerusalem in the days of Uzziah, Jotham, Ahaz, Hezekiah, kings of Judah.');
INSERT INTO mse_bible_book VALUES (24, 'Jeremiah', 'OT', 24, NULL, 'The words of Jeremiah the son of Hilkijah, of the priests that were in Anathoth in the land of Benjamin:');
INSERT INTO mse_bible_book VALUES (25, 'Lamentations', 'OT', 25, NULL, 'How doth the city sit solitary [that] was full of people! She that was great among the nations is become as a widow; the princess among the provinces is become tributary!');
INSERT INTO mse_bible_book VALUES (26, 'Ezekiel', 'OT', 26, NULL, 'Now it came to pass in the thirtieth year, in the fourth [month], on the fifth of the month, as I was among the captives by the river Chebar, the heavens were opened, and I saw visions of God.');
INSERT INTO mse_bible_book VALUES (27, 'Daniel', 'OT', 27, NULL, 'In the third year of the reign of Jehoiakim king of Judah came Nebuchadnezzar king of Babylon unto Jerusalem, and besieged it.');
INSERT INTO mse_bible_book VALUES (28, 'Hosea', 'OT', 28, NULL, 'The word of Jehovah that came unto Hosea, the son of Beeri, in the days of Uzziah, Jotham, Ahaz, Hezekiah, kings of Judah, and in the days of Jeroboam the son of Joash, king of Israel.');
INSERT INTO mse_bible_book VALUES (29, 'Joel', 'OT', 29, NULL, 'The word of Jehovah that came to Joel the son of Pethuel.');
INSERT INTO mse_bible_book VALUES (30, 'Amos', 'OT', 30, NULL, 'The words of Amos, who was among the herdmen of Tekoa, which he saw concerning Israel in the days of Uzziah king of Judah, and in the days of Jeroboam the son of Joash, king of Israel, two years before the earthquake.');
INSERT INTO mse_bible_book VALUES (31, 'Obadiah', 'OT', 31, 1, 'The vision of Obadiah. Thus saith the Lord Jehovah concerning Edom: We have heard a report from Jehovah, and an ambassador is sent among the nations. Arise ye, and let us rise up against her in battle.');
INSERT INTO mse_bible_book VALUES (32, 'Jonah', 'OT', 32, NULL, 'And the word of Jehovah came unto Jonah the son of Amittai, saying,');
INSERT INTO mse_bible_book VALUES (33, 'Micah', 'OT', 33, NULL, 'The word of Jehovah that came to Micah the Morasthite in the days of Jotham, Ahaz, [and] Hezekiah, kings of Judah, which he saw concerning Samaria and Jerusalem.');
INSERT INTO mse_bible_book VALUES (34, 'Nahum', 'OT', 34, NULL, 'The burden of Nineveh. The book of the vision of Nahum the Elkoshite.');
INSERT INTO mse_bible_book VALUES (35, 'Habakkuk', 'OT', 35, NULL, 'The burden which Habakkuk the prophet did see.');
INSERT INTO mse_bible_book VALUES (36, 'Zephaniah', 'OT', 36, NULL, 'The word of Jehovah that came unto Zephaniah the son of Cushi, the son of Gedaliah, the son of Amariah, the son of Hezekiah, in the days of Josiah the son of Amon, king of Judah.');
INSERT INTO mse_bible_book VALUES (37, 'Haggai', 'OT', 37, NULL, 'In the second year of Darius the king, in the sixth month, on the first day of the month, came the word of Jehovah by the prophet Haggai unto Zerubbabel the son of Shealtiel, governor of Judah, and to Joshua the son of Jehozadak, the high priest, saying,');
INSERT INTO mse_bible_book VALUES (38, 'Zechariah', 'OT', 38, NULL, 'In the eighth month, in the second year of Darius, came the word of Jehovah unto Zechariah the prophet, the son of Berechiah, the son of Iddo, saying,');
INSERT INTO mse_bible_book VALUES (39, 'Malachi', 'OT', 39, NULL, 'The burden of the word of Jehovah to Israel by Malachi.');
INSERT INTO mse_bible_book VALUES (40, 'Matthew', 'NT', 1, NULL, 'Book of the generation of Jesus Christ, Son of David, Son of Abraham.');
INSERT INTO mse_bible_book VALUES (41, 'Mark', 'NT', 2, NULL, 'Beginning of the glad tidings of Jesus Christ, Son of God;');
INSERT INTO mse_bible_book VALUES (42, 'Luke', 'NT', 3, NULL, 'Forasmuch as many have undertaken to draw up a relation concerning the matters fully believed among us,');
INSERT INTO mse_bible_book VALUES (43, 'John', 'NT', 3, NULL, 'In [the] beginning was the Word, and the Word was with God, and the Word was God.');
INSERT INTO mse_bible_book VALUES (44, 'Acts', 'NT', 4, NULL, 'I composed the first discourse, O Theophilus, concerning all things which Jesus began both to do and to teach,');
INSERT INTO mse_bible_book VALUES (45, 'Romans', 'NT', 5, NULL, 'Paul, bondman of Jesus Christ, [a] called apostle, separated to God''s glad tidings,');
INSERT INTO mse_bible_book VALUES (46, '1 Corinthians', 'NT', 6, NULL, 'Paul, [a] called apostle of Jesus Christ, by God''s will, and Sosthenes the brother,');
INSERT INTO mse_bible_book VALUES (47, '2 Corinthians', 'NT', 7, NULL, 'Paul, apostle of Jesus Christ by God''s will, and the brother Timotheus, to the assembly of God which is in Corinth, with all the saints who are in the whole of Achaia.');
INSERT INTO mse_bible_book VALUES (48, 'Galatians', 'NT', 8, NULL, 'Paul, apostle, not from men nor through man, but through Jesus Christ, and God [the] Father who raised him from among [the] dead,');
INSERT INTO mse_bible_book VALUES (49, 'Ephesians', 'NT', 9, NULL, 'Paul, apostle of Jesus Christ by God''s will, to the saints and faithful in Christ Jesus who are at Ephesus.');
INSERT INTO mse_bible_book VALUES (50, 'Philippians', 'NT', 10, NULL, 'Paul and Timotheus, bondmen of Jesus Christ, to all the saints in Christ Jesus who are in Philippi, with [the] overseers and ministers;');
INSERT INTO mse_bible_book VALUES (51, 'Colossians', 'NT', 11, NULL, 'Paul, apostle of Christ Jesus, by God''s will, and Timotheus the brother,');
INSERT INTO mse_bible_book VALUES (52, '1 Thessalonians', 'NT', 12, NULL, 'Paul and Silvanus and Timotheus to the assembly of Thessalonians in God [the] Father and [the] Lord Jesus Christ. Grace to you and peace.');
INSERT INTO mse_bible_book VALUES (53, '2 Thessalonians', 'NT', 13, NULL, 'Paul and Silvanus and Timotheus to the assembly of Thessalonians in God our Father and [the] Lord Jesus Christ.');
INSERT INTO mse_bible_book VALUES (54, '1 Timothy', 'NT', 14, NULL, 'Paul, apostle of Jesus Christ, according to [the] command of God our Saviour, and of Christ Jesus our hope,');
INSERT INTO mse_bible_book VALUES (55, '2 Timothy', 'NT', 15, NULL, 'Paul, apostle of Jesus Christ by God''s will, according to promise of life, the [life] which [is] in Christ Jesus,');
INSERT INTO mse_bible_book VALUES (56, 'Titus', 'NT', 16, NULL, 'Paul, bondman of God, and apostle of Jesus Christ according to [the] faith of God''s elect, and knowledge of [the] truth which [is] according to piety;');
INSERT INTO mse_bible_book VALUES (57, 'Philemon', 'NT', 17, 1, 'Paul, prisoner of Christ Jesus, and Timotheus the brother, to Philemon the beloved and our fellow-workman,');
INSERT INTO mse_bible_book VALUES (58, 'Hebrews', 'NT', 18, NULL, 'God having spoken in many parts and in many ways formerly to the fathers in the prophets,');
INSERT INTO mse_bible_book VALUES (59, 'James', 'NT', 19, NULL, 'James, bondman of God and of [the] Lord Jesus Christ, to the twelve tribes which [are] in the dispersion, greeting.');
INSERT INTO mse_bible_book VALUES (60, '1 Peter', 'NT', 20, NULL, 'Peter, apostle of Jesus Christ, to [the] sojourners of [the] dispersion of Pontus, Galatia, Cappadocia, Asia, and Bithynia,');
INSERT INTO mse_bible_book VALUES (61, '2 Peter', 'NT', 21, NULL, 'Simon Peter, bondman and apostle of Jesus Christ, to them that have received like precious faith with us through [the] righteousness of our God and Saviour Jesus Christ:');
INSERT INTO mse_bible_book VALUES (62, '1 John', 'NT', 22, NULL, 'That which was from [the] beginning, that which we have heard, which we have seen with our eyes; that which we contemplated, and our hands handled, concerning the word of life;');
INSERT INTO mse_bible_book VALUES (63, '2 John', 'NT', 23, 1, 'The elder to [the] elect lady and her children, whom *I* love in truth, and not *I* only but also all who have known the truth,');
INSERT INTO mse_bible_book VALUES (64, '3 John', 'NT', 24, 1, 'The elder to the beloved Gaius, whom I love in truth.');
INSERT INTO mse_bible_book VALUES (65, 'Jude', 'NT', 25, 1, 'Jude, bondman of Jesus Christ, and brother of James, to the called ones beloved in God [the] Father and preserved in Jesus Christ:');
INSERT INTO mse_bible_book VALUES (66, 'Revelation', 'NT', 26, NULL, 'Revelation of Jesus Christ, which God gave to him, to shew to his bondmen what must shortly take place; and he signified [it], sending by his angel, to his bondman John,');

--
-- Dumping data for table mse_bible_version
--

INSERT INTO mse_bible_version VALUES (1, 'JND', 'Darby Translation');
INSERT INTO mse_bible_version VALUES (2, 'KJV', 'King James Version');

