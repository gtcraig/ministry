-- goodteaching_org_min: localfile paths, G. V. Wigram volumes and author, JGB name
--
-- Backslashes: MseBuilder (Volume.LocalFile) expects the stored path to have
-- doubled backslashes, C:\\Dev\\ministry\\..., and turns each \\ back into \.
-- In a MySQL string literal '\\' stores one backslash, so '\\\\' below stores
-- two. This matches the existing rows exactly.
-- (This assumes sql_mode does not include NO_BACKSLASH_ESCAPES; the default does not.)

-- 0. Preview what step 1 will set (run this first if you want to check)
SELECT author, vol, localfile,
       CONCAT('C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\',
              LOWER(author), '\\\\', LOWER(author), vol, '.txt') AS new_localfile
FROM mse_volume
ORDER BY author, vol
LIMIT 20;

-- 1. localfile for every volume: C:\Dev\ministry\dev\text\ministry\<folder>\<folder><vol>.txt
--    MseBuilder treats localfile = '1' as a special value, so those rows are left alone.
UPDATE mse_volume
SET localfile = CONCAT('C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\',
                       LOWER(author), '\\\\', LOWER(author), vol, '.txt')
WHERE localfile <> '1';

-- 2. G. V. Wigram as an author
INSERT INTO mse_author (author, name, fullname, orgname)
VALUES ('GVW', 'G. V. Wigram', 'George Vicesimus Wigram', 'Wigram, George Vicesimus')
ON DUPLICATE KEY UPDATE name = VALUES(name), fullname = VALUES(fullname), orgname = VALUES(orgname);

-- 3. The eight G. V. Wigram volumes (titles as in each file's {#...} line)
INSERT INTO mse_volume (author, vol, title, added, localfile) VALUES
('GVW', 1, 'Memorials Volume 1',                 NOW(), 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\gvw\\\\gvw1.txt'),
('GVW', 2, 'Memorials Volume 2',                 NOW(), 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\gvw\\\\gvw2.txt'),
('GVW', 3, 'Memorials Volume 3 - Letters',       NOW(), 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\gvw\\\\gvw3.txt'),
('GVW', 4, 'Gleanings Volume 1 - First Series',  NOW(), 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\gvw\\\\gvw4.txt'),
('GVW', 5, 'Gleanings Volume 2 - Second Series', NOW(), 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\gvw\\\\gvw5.txt'),
('GVW', 6, 'Gleanings Volume 3 - Third Series',  NOW(), 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\gvw\\\\gvw6.txt'),
('GVW', 7, 'Short Papers',                       NOW(), 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\gvw\\\\gvw7.txt'),
('GVW', 8, 'Collectanea (extracted from)',       NOW(), 'C:\\\\Dev\\\\ministry\\\\dev\\\\text\\\\ministry\\\\gvw\\\\gvw8.txt')
ON DUPLICATE KEY UPDATE title = VALUES(title), localfile = VALUES(localfile);

-- 4. Correct the JGB short name (was 'J. G. Bellatt')
UPDATE mse_author SET name = 'J. G. Bellett' WHERE author = 'JGB';

-- 5. Check
SELECT * FROM mse_author WHERE author IN ('GVW', 'JGB');
SELECT author, vol, title, localfile FROM mse_volume WHERE author = 'GVW' ORDER BY vol;
SELECT author, COUNT(*) AS volumes FROM mse_volume GROUP BY author ORDER BY author;
