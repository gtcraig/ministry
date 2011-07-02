SELECT * FROM hymn hen, hymn_nl hnl, hymn_de hde
WHERE hen.hymn_no = hnl.hymn_no
AND hen.hymn_no = hde.hymn_no


SELECT hen.hymn_no, hen.author_id,
  hen.meter meter,
  hen.meter_id meter_id,
  hnl.meter meter_nl,
  hnl.meter_id meter_id_nl,
  hde.meter meter_de,
  hde.meter_id meter_id_de
FROM hymn hen, hymn_nl hnl, hymn_de hde
WHERE hen.hymn_no = hnl.hymn_no
AND hen.hymn_no = hde.hymn_no



INSERT INTO hymn_nl (hymn_no, meter, meter_id, author_id) VALUES ('169', '10.10.10.10. Dakt.', '63', '15');
UPDATE hymn SET meter = '11.10.11.10. Dactylic.' WHERE hymn.hymn_no =4 LIMIT 1 ;
UPDATE hymn SET meter = '11.10.11.10. Dactylic.' WHERE hymn.hymn_no =22 LIMIT 1 ;


UPDATE hymn_line SET vers_no = vers_no * 10 WHERE vers_no >= 10;
UPDATE hymn_line SET vers_no = vers_no * 10 WHERE vers_no < 10;

UPDATE hymn_line SET vers_no=99 WHERE hymn_no=439 AND vers_no=11;
UPDATE hymn_line SET vers_no=2 WHERE hymn_no=439 AND vers_no=20;
UPDATE hymn_line SET vers_no=3 WHERE hymn_no=439 AND vers_no=30;
UPDATE hymn_line SET vers_no=4 WHERE hymn_no=439 AND vers_no=40;
UPDATE hymn_line SET vers_no=1 WHERE hymn_no=439 AND vers_no=10;

UPDATE hymn_line SET vers_no=3 WHERE hymn_no=122 AND vers_no=4;


SELECT h.hymn_no, h.author_id, a.fullname,
  h.meter,
  h.meter_id
FROM hymn h, authors a
WHERE h.author_id = a.id
ORDER BY 1