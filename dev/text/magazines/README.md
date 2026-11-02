# Magazines data source

JSON versions of the two monthly magazines, one file per issue, built from the
EPUBs in the calibre library for search tools (e.g. the Rool machine). The
JSON holds the full text, so it supersedes the PDF / Word / EPUB as a source.

| Folder   | calibre series                            | Files                | Example            |
|----------|-------------------------------------------|----------------------|--------------------|
| `awiis/` | A Word in its Season, 1st Series (id 1)   | `awiis1-NNN.json`    | `awiis1-296.json`  |
| `awiis/` | A Word in its Season, 2nd Series (id 4)   | `awiis2-NNN.json`    | `awiis2-059.json`  |
| `nom/`   | Notes of Ministry (id 2)                  | `nom-NNN.json`       | `nom-108.json`     |

`NNN` is the issue number padded to three digits. Specials keep a suffix:
`awiis1-048-sup.json` (the March 1977 supplement), `nom-512a.json`.

The files are **generated** — do not edit them by hand. Correct the EPUB in
calibre and rebuild the issue instead (see [Building](#building)).

## Building

The scripts are in `dev/scripts` and use only the Python standard library.

| Script                | What it does                                                         |
|-----------------------|----------------------------------------------------------------------|
| `build_magazines.py`  | Reads calibre's `metadata.db` (read-only), finds each issue's EPUB and writes the JSON here. By default builds only issues that have no JSON yet. |
| `update_magazines.cmd` / `update_magazines.py` | Switches to the `magazine` branch, runs the build for anything missing, commits the new files, and switches back. |

```
dev\scripts\update_magazines                 rem build what is missing and commit on 'magazine'
dev\scripts\update_magazines --push          rem ... and push the branch
dev\scripts\update_magazines --changed       rem also rebuild issues whose EPUB is newer than its JSON
dev\scripts\update_magazines --issue 67      rem prefix the commit message with #67

python dev\scripts\build_magazines.py --all          rem rebuild everything (no git)
python dev\scripts\build_magazines.py --ids 458      rem rebuild one issue by calibre book id
python dev\scripts\build_magazines.py --library "D:\Calibre Library"
```

The library defaults to `%USERPROFILE%\Calibre Library` (or `CALIBRE_LIBRARY`
if set). calibre does not need to be closed: the database is opened read-only.

Issues with no EPUB (NOM 195–205) are read from their DOCX.

## How an issue is split into articles

1. The EPUB's own table of contents (`toc.ncx` for EPUB 2, `nav.xhtml` for
   EPUB 3) gives the article starts. If an issue has no usable TOC, `h1`
   headings are used (`source.split_by` says which). If the TOC misses text
   before its first entry, articles are started there as well (`toc+front`).
2. The cover page and contents list before the first article are dropped. The
   publisher/printer lines and any repeated contents at the end go in
   `back_matter`.
3. **Key / List of Initials.** In the EPUBs these are usually a heading of
   their own ("Key to Initials:", "LIST OF INITIALS:-", …) and sometimes a
   paragraph at the end of a reading. Either way the key is parsed and merged
   into the article it belongs to, the one before it, as `initials`.
4. **Article groups.** A heading with no text of its own ("AT TWO BURIALS - 1",
   "SOME FUNDAMENTALS -") is not an article: it becomes `group` on the article
   after it and on any following "(ii)", "(iii)" sub-articles.
5. Within each article the usual layout is

   ```
   TITLE
   Author                       (some issues, mainly AWIIS 2nd Series and NOM)
   Scriptures
   <body>
   <type of meeting>, Locality
   Date
   Brother (servant)
   ```

   The header and footer lines are lifted into their own fields; everything
   else is in `paragraphs`. NOM often gives the footer on one line —
   "Word in meeting for ministry, Grangemouth 28 April 1981" — and that is
   split the same way.

The parsing of these fields is heuristic. The text itself is complete (a
check against calibre's full-text index finds every issue at 97–100 % of the
EPUB's words; the difference is the cover and contents pages), but a field
may occasionally be missed or mis-assigned, in which case the line stays in
`paragraphs` or `footer`.

## File format

```json
{
 "schema": 1,
 "magazine": "A Word in its Season",
 "code": "awiis",
 "series": 2,
 "issue": "59",
 "number": 59,
 "title": "A Word in its Season 059 - Feb 2012",
 "date": "2012-02",
 "publisher": "Burr, D Andrew & Brown, David C",
 "source": {
  "calibre_id": 458,
  "format": "EPUB",
  "file": "Various/A Word in its Season 059 - Feb 2012 (458)/A Word in its Season 059 - Feb - Various.epub",
  "modified": "2026-05-08T05:30:58Z",
  "split_by": "toc"
 },
 "article_count": 4,
 "articles": [
  {
   "number": 1,
   "title": "COMMITTAL AND FAITHFULNESS",
   "scriptures": ["Ecclesiastes 5: 4", "1 Samuel 1: 8-11, 25-28", "Joshua 24: 15", "1 Corinthians 16: 15, 16"],
   "place": "Calgary",
   "date": "2nd July 2011",
   "speakers": ["WSC", "APD", "JAH", "..."],
   "initials": [
    {"initials": "JRB", "name": "J R Bellamy", "place": "Vancouver"},
    {"initials": "NSB", "name": "N S Brien", "place": "Calgary"}
   ],
   "initials_heading": "Key to initials:",
   "initials_text": ["J R Bellamy, Vancouver; N S Brien, Calgary; ..."],
   "paragraphs": [
    {"speaker": "WSC", "text": "We are considering the subject of the structure, or the pillars, ..."},
    {"speaker": "APD", "text": "..."}
   ]
  }
 ],
 "back_matter": ["Edited and Published by", "David Brown and Andrew Burr 81 Roxburgh Road. ..."]
}
```

### Issue fields

| Field           | Meaning |
|-----------------|---------|
| `schema`        | Format version (currently `1`). |
| `magazine`      | "A Word in its Season" or "Notes of Ministry". |
| `code`          | `awiis` or `nom` (the folder). |
| `series`        | `1` or `2` for AWIIS; `null` for NOM. |
| `issue`         | Issue as printed: `"59"`, `"512A"`, `"48 Supplement"`. |
| `number`        | Issue number as an integer. |
| `title`         | The calibre title. |
| `date`          | Publication month `YYYY-MM` (from calibre). |
| `publisher`     | From calibre, if set. |
| `source`        | calibre book id, which file was read (relative to the library), its modified time, and how it was split. |
| `article_count` | Number of articles. |
| `articles`      | The articles, in order. |
| `back_matter`   | Closing lines of the issue (publisher, printer, repeated contents). Optional. |

### Article fields

Only `number`, `title` and `paragraphs` are always present.

| Field              | Meaning |
|--------------------|---------|
| `number`           | 1-based position in the issue. |
| `group`            | The article-group heading this article sits under. |
| `title`            | Title as in the issue's table of contents. |
| `author`           | Name given under the title (e.g. "George A Coull", "J. Renton"). |
| `scriptures`       | Scriptures read, one entry per line as printed. |
| `notes`            | Short label lines in the header, e.g. "(Address)". |
| `meeting`          | Type of meeting, e.g. "Reading", "Address", "Word in meeting for ministry". |
| `place`            | Locality. |
| `date`             | Date as printed, e.g. "4th October 2011", "28 April 1981". |
| `servant`          | The brother named at the end of the article. |
| `speakers`         | Distinct speaker initials in the order they first speak (readings). |
| `initials`         | The merged Key / List of Initials: `initials` (as used in the text, derived from the name when the key does not give them), `name`, and `place` if given. |
| `initials_heading` | The key's heading as printed. |
| `initials_text`    | The key exactly as printed, in case the parsed form needs checking. |
| `footer`           | Any other closing lines, e.g. "Words given at a marriage meeting". |
| `paragraphs`       | The body. Each is `{"text": ...}`, plus `"speaker"` when a reading paragraph begins with someone's initials (removed from `text`), and `"source"` when an extract is followed by its attribution, e.g. "J. Taylor (Vol. 47, p.11, 12)". Line breaks within a paragraph (poetry, hymn lines) are kept as `\n`. |
