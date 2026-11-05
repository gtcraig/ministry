# Prompt: add the JT initials index to a ministry library

For a Rool machine that already holds the ministry texts at `/rool-drive/ministry`
(with `index.json`). You also need to send them `JT Initials Index Entries.xlsx` — the
8,969-row index extracted from `initials.pdf` (JT volumes 1–100). Paste the
prompt below and attach the spreadsheet.

---

Add the JT initials index to my ministry library and start using it.

1. Put the attached `JT Initials Index Entries.xlsx` in `/rool-drive/ministry/` under
   exactly that name, and read `README.md` there first so you know the text format.

2. Convert it to `/rool-drive/ministry/jt_initials.json` — a machine-readable copy with
   `source`, and `sheets` holding `entries` (index_page, volume, initials, name,
   locality, page_numbers, notes), `volumes` (volume number, locations, dates, raw
   subheading, entries count, highest page number seen) and `legend` (the Note codes).
   Normalise blanks/NaN to null. Expect 8,969 entries, 1,547 distinct initials,
   volumes 1–100. Report those counts when done.

3. Then record these rules in my `ministry-library` memory (or equivalent), because
   they are how the initials are actually used:

   - The JT volume number is the number in the FILENAME: `jt27` = Volume 27,
     `jt43` = Volume 43. (Any "Volume 87" printed in an article header is the
     Ministry-series volume, a different number. Ignore it.)
   - To identify a speaker's initials: take the volume from the filename, look up
     that volume in `jt_initials.json`, and match the initials to get name and locality.
     Where the same code appears in several volumes, use the volume, then the printed
     page number, to choose.
   - `jt_initials.json` is the initials index for the JT volumes and applies only
     to `jt/` — for any other folder, the speaker is the writer whose folder the
     file sits in.
   - Quote dialogue as initials with no dots, in bold: **JT**: … (not J.T.).
   - Refer to the speakers as "brother" / "brothers", never "man" / "men", and
     always name a brother as "Mr Surname" (Mr Taylor), never the surname alone.
   - Cite file + article title + page number when answering from the texts.
     Quote the page without braces — "page 23" or "p. 23", never `{23}`.

4. Verify before finishing: print one known code per volume you sample (e.g. Volume 27
   → JT = James Taylor, New York), check a confidence case where the same initials
   name two different brothers in different volumes, and show me the entries whose
   Note is not null so I can see where the transcription was uncertain.

---

The workbook's own Legend sheet explains the Notes codes (PAR, ?N, ?L, NOLOC, BARE,
2ND, PRE:x, INNAME, TR:x, ALTLOC:x, OVR, SIC:x) — tell your machine to read it rather
than guess, and to leave an entry uncertain rather than invent a name.
