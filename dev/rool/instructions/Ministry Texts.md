# Ministry Texts

381 text files — 380 volumes holding 13,448 articles by the Brethren teachers,
plus a note on the symbols used in the text — with three indexes that make them
searchable.

## Files

| File | Contents |
|---|---|
| `text/ministry/<initials>/<initials><n>.txt` | the text, 14 writer folders |
| `text/ministry/index.json` | article index: 380 volumes, 13,448 articles (6.1 MB) |
| `text/ministry/Index.md` | the same, readable, grouped by writer |
| `text/ministry/scribes.json` | the Scribe index: 8,969 entries, volumes 1–100 |
| `text/ministry/Scribe Index Entries.xlsx` | the source spreadsheet for the above |
| `text/ministry/dm/symbols/notes.txt` | the symbols used in the text; the one file absent from `index.json` |

Folders: `ajg cac chm dm fer grc jbs jgb jnd jr jt smc wj wjh`.

`jr/` is not part of the Scribe series: `jr1.txt` and `jr2.txt` are *First Things
and Other Ministry* by Jim Renton. `scribes.json` covers the `jt/` Scribe
volumes 1–100 and does not apply to them.

## Text format

The full specification is the format section of `text/ministry/README.md` in the
original source repository; the essentials:

- `{1}` `{2}` — page numbers, on the line *before* the page's first line
- `{#Volume 1 - An Outline of Genesis}` — volume title
- `$ARTICLE GROUP NAME`, then `| City | Date`, then a summary line
- **Title**: a line more than 70% uppercase. `PREFATORY NOTE` and `*NOTE*` are not titles
- **Scriptures**: the line immediately after a title, `@`-prefixed, `;`-separated
- `*italics*`; `~` is a possessive apostrophe
- `` ` `` introduces a hymn reference (see `Hymns.md`)
- `¦` or `<sup>` introduces a footnote
- `{` `}` and page numbers are structural, never part of the prose

A paragraph ending mid-sentence continues over the page break.

## `index.json`

One entry per file, keyed by path:

```json
"ajg/ajg1.txt": {
  "volume_title": "Piety and other addresses",
  "pages": {...},
  "article_groups": [...],
  "articles": [
    {"title": "PIETY", "file": "ajg/ajg1.txt", "group": "",
     "line": 3, "scripture": "@1 Timothy 2:1-4; @1 Timothy 3:14-16"}
  ]
}
```

`line` is 1-based and points at the title line, so `sed -n '3p'` is the title
and `4,` is the article. Use it to jump straight to the text rather than
grepping titles, which recur across volumes.

## `scribes.json`

`{"source": …, "sheets": {"entries": [...], "volumes": [...], "legend": [...]}}`.
Each entry: `index_page`, `volume`, `initials`, `name`, `locality`,
`page_numbers`, `notes`. Blanks are `null`.

How to use it:

- The volume number is the number in the **filename**: `jt27` is Volume 27.
  Look up Volume 27 in the index and match the speaker's initials to get the
  name and locality.
- In quoted dialogue, print initials **without dots and in bold** — `**JT**` —
  not `J.T.`.
- A clerk's initials may differ from a writer's folder: `WB-s` and `WB` are
  different entries. Match the full string.

## Counts to check against

| Measure | Expected |
|---|---|
| text files | 381 (380 volumes + `dm/symbols/notes.txt`) |
| writer folders | 14 |
| volumes in `index.json` | 380 |
| articles | 13,448 |
| `@` citation lines | 8,667 (8,627 resolving, 156,097 verses) |
| hymn references | 512 (505 resolving) |
| scribe entries | 8,969 |
| scribe initials (distinct) | 1,549 |
| scribe volumes | 100 |

## Commands

```bash
# every article by one writer, with page numbers
jq -r '.[] | .articles[] | "\(.file):\(.line)\t\(.title)"' text/ministry/index.json \
  | grep '^jt/'

# find articles whose Scriptures read include a book
jq -r '.[] | .articles[] | select(.scripture | test("Ephesians")) | "\(.title) — \(.file)"' \
  text/ministry/index.json

# jump to one article
sed -n '3,40p' text/ministry/ajg/ajg1.txt

# every hymn reference in the corpus
python3 rool/instructions/scripts/hymns.py --scan text/ministry/*/*.txt
```

## Notes on use

- Cite **file, article title and page number**. The page is what a reader can
  find in print; the line number is what a machine can find in the file.
- The texts were typed from printed volumes, and the typos are in the source.
  When a reference or a word looks wrong, check the context before correcting
  it, and say when you have corrected something.
- Refer to the speakers as brothers, and name them with their honorific and
  surname — Mr Taylor, Mr Coates, Mr Gardiner.
