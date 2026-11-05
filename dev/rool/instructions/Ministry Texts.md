# Ministry Texts

389 text files — 388 volumes holding 13,600 articles by the Brethren teachers,
plus a note on the symbols used in the text — with three indexes that make them
searchable.

## Files

| File | Contents |
|---|---|
| `text/ministry/<initials>/<initials><n>.txt` | the text, 15 writer folders |
| `text/ministry/index.json` | article index: 388 volumes, 13,600 articles (2.1 MB) |
| `text/ministry/Index.md` | the same, readable, grouped by writer |
| `text/ministry/authors.json` | writer folder → name: `{"smc": {"name": "S. McCallum", "fullname": "Stanley McCallum"}, ...}` |
| `text/ministry/volume_titles.json` | fallback titles, from the goodteaching database, for volumes with no `{#...}` line |
| `text/ministry/jt_initials.json` | the JT initials index: 8,969 entries, volumes 1–100 |
| `text/ministry/JT Initials Index Entries.xlsx` | the source spreadsheet for the above |
| `text/ministry/dm/symbols/notes.txt` | the symbols used in the text; the one file absent from `index.json` |

Folders: `ajg cac chm dm fer grc gvw jbs jgb jnd jr jt smc wj wjh`.

**Writers.** Look a writer up in `authors.json` by folder name: it gives the
short name used in `Index.md` and `index.json` and the full name. `jt` is
James Taylor, Senior.

`jt_initials.json` is the initials index for the JT volumes and applies only
to `jt/` — for any other folder, the speaker is the writer whose folder the
file sits in.

`gvw/` is G. V. Wigram: `gvw1`–`gvw3` *Memorials of the Ministry of G. V.
Wigram* (vol. 3 is his letters, one article per letter), `gvw4`–`gvw6`
*Gleanings* (first to third series), `gvw7` *Short Papers*, `gvw8` extracts
from *Collectanea* and other papers. The source has no printed page numbers, so
in `gvw` each article has its own `{N}`: the "page" is the article's number
within the volume, not a printed page. Cite `gvw` by volume and article title,
not by page number.

## Text format

The full specification is the format section of `text/ministry/README.md` in the
original source repository; the essentials:

- `{1}` `{2}` — page numbers, on the line *before* the page's first line
- `{#Volume 1 - An Outline of Genesis}` — volume title
- `$ARTICLE GROUP NAME`, then `| City | Date`, then a summary line
- **Title**: a line more than 70% uppercase (A–Z against a–z and full stops), with no `<` or `>`
  once any `<sup>...</sup>` is removed. A line starting `%` is a sub-title, not a title
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
  "author": "A. J. Gardiner",
  "pages": 406,
  "article_groups": [{"name": ..., "where": "| City | Date", "file": ..., "line": ...}],
  "articles": [
    {"title": "PIETY", "file": "ajg/ajg1.txt", "group": "",
     "line": 3, "scripture": "@1 Timothy 2:1-4; @1 Timothy 3:14-16"}
  ]
}
```

`line` is 1-based and points at the title line, so `sed -n '3p'` is the title
and `4,` is the article. Use it to jump straight to the text rather than
grepping titles, which recur across volumes.

`scripture` is the `@` line straight after the title, or `""` if there is none.
`group` is set when the title begins with the group's name, as on the site.
`pages` is the highest page number in the file. `volume_title_source:
"database"` marks a title taken from `volume_titles.json`.

`index.json` and `Index.md` are generated: after changing any text file, or
`authors.json`, run `python3 rool/instructions/scripts/build_index.py`
(`--check` reports what would change without writing). It applies the same
rules as the goodteaching parser (`software/MseBuilder`).

## `jt_initials.json`

`{"source": …, "sheets": {"entries": [...], "volumes": [...], "legend": [...]}}`.
Each entry: `index_page`, `volume`, `initials`, `name`, `locality`,
`page_numbers`, `notes`. Blanks are `null`.

How to use it (for `jt/` only):

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
| text files | 389 (388 volumes + `dm/symbols/notes.txt`) |
| writer folders | 15 |
| volumes in `index.json` | 388 |
| articles | 13,600 |
| `@` citation lines | 9,169 (9,128 resolving, 199,226 verses, measured with `expand.py` on 5 Nov 2026) |
| hymn references | 512 (505 resolving) |
| JT initials entries | 8,969 |
| JT initials (distinct) | 1,549 |
| JT initials volumes | 100 |

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
- Quote page numbers **without braces** — "page 23" or "p. 23", never `{23}`.
  The braces are file markup, not part of the citation.
- In `gvw` the `{N}` markers are article numbers, not printed pages. Cite the
  volume and the article title, not a page number.
- The texts were typed from printed volumes, and the typos are in the source.
  When a reference or a word looks wrong, check the context before correcting
  it, and say when you have corrected something.
- Refer to the speakers as brothers, and always name a brother as "Mr Surname"
  — Mr Taylor, Mr Coates, Mr Gardiner — never the surname alone, in prose,
  citations and summaries alike.
