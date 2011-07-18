-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: empty.sql 808 2008-05-11 13:10:04Z craig $
--
-- Who  When         Why
-- CAM  12-Nov-2007  10214 : Created for ease of emptying the database of generated content.
-- --------------------------------------------------------

ALTER TABLE mse_text DROP INDEX inits;
ALTER TABLE mse_text DROP INDEX ft;

TRUNCATE TABLE mse_article;
TRUNCATE TABLE mse_text;
TRUNCATE TABLE mse_bible_ref;
TRUNCATE TABLE mse_bible_ref_error;

