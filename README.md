# Ministry Library

The source behind [goodteaching.org](https://goodteaching.org): the ministry
writings of the Brethren teachers, the hymns they were quoted with, and the
Scriptures they were read from. It also holds the software that builds the site
and the instructions that let an AI agent (a Rool Machine) search the library
properly.

The point of this repository is not just to hold the text. It is to hold the
*relationships*: which hymn a preacher quoted, which verses an article was
preached on, which brother was speaking on which page. Those relationships are
what make the library searchable rather than merely readable.

## Layout

| Path | What it holds |
|---|---|
| `dev/` | Everything in use: the texts, the software and the instructions |
| `tunes/` | Hymn tunes: MIDI and MP3 files, scanned tune images, the tune tables, and the scripts that serve them |
| `release/` | Ebook editions of the ministry volumes (EPUB for Apple, MOBI for Kindle, v01–v03), last released in 2013 |
| `.github/` | `CODEOWNERS` |

### `dev/text/` — the library

| Path | What it holds |
|---|---|
| `dev/text/ministry/` | 389 text files, 388 volumes (13,600 articles) in 15 writer folders, with `index.json` and `Index.md` (the article index), `authors.json` (writer names), `volume_titles.json`, and `jt_initials.json` (the speakers' initials for the J. Taylor, Sr volumes). The text format is described in `dev/text/ministry/README.md`. |
| `dev/text/magazines/` | 1,293 magazine issues as JSON — *A Word in its Season* and *Notes of Ministry*. See `dev/rool/instructions/magazines.md`. |
| `dev/text/hymns/` | `hymns.json` (456 hymns, EN/DE/IT/NL, authors, metres, categories) and a readable index |
| `dev/text/bible/` | `KJV.json` and `Darby.json`, verse by verse, public domain |
| `dev/text/initials/` | The source material for `jt_initials.json`: the scanned `initials.pdf`, the extraction spec and the working spreadsheet |
| `dev/text/FixFiles.py` | A one-off text clean-up script |

### `dev/software/` — the site and its tools

| Path | What it holds |
|---|---|
| `dev/software/MseBuilder/` | The C# builder that parses the text files and loads them into the goodteaching.org database. Its parser defines the text format. |
| `dev/software/goodteaching/` | The goodteaching.org website (PHP) |
| `dev/software/goodteaching2/` | A second version of the website |
| `dev/software/BlankMSE_Java/` | A Java version of the ministry search engine |
| `dev/software/Macros/` | Word macros used when preparing the texts |
| `dev/software/*.sql`, `ErrorTracking.accdb` | Database scripts, and the Access database used for tracking text errors |

### `dev/rool/` — instructions for an AI agent

| Path | What it holds |
|---|---|
| `dev/rool/instructions/` | **`GoodTeaching.md` first** — fetch it to a machine and the library builds and refreshes itself from this repository. Then one document per source: how to read, index and search it. Written for an AI agent; readable by anyone. |
| `dev/rool/instructions/scripts/` | Four small stdlib-only Python tools: `refresh.py` (install and refresh from this repository), `expand.py` (Scripture references → verse text), `hymns.py` (hymn lookup and search) and `build_index.py` (regenerate `index.json` and `Index.md` from the text) |
| `dev/rool/instructions/prompts/` | Stand-alone prompts that set a machine up from scratch, for people who cannot copy this repository |

### Elsewhere in `dev/`

| Path | What it holds |
|---|---|
| `dev/scripts/` | `build_magazines.py` and `update_magazines.py`, which build the magazine JSON from the calibre library |
| `dev/goodteaching_org_min.sql.zip` | A dump of the goodteaching.org database |
| `dev/OSTicket_Scripts.*` | SQL for the site's osTicket help desk (text-mistake tickets) |

## Installing on a Rool Machine

One prompt, from a machine that has none of these files:

> Build the Good Teaching library from
> `https://raw.githubusercontent.com/gtcraig/ministry/main/dev/rool/instructions/GoodTeaching.md`

The machine fetches `GoodTeaching.md`, which fetches `scripts/refresh.py`, which
installs the four data folders — `ministry/`, `magazines/`, `bible/`, `hymns/` —
into `/rool-drive` and checks itself against the expected totals. Nothing is
copied by hand.

Afterwards, **"Refresh from repo"** runs the same script again: it reads the
repository listing, downloads only files that are new or changed, and deletes any
that have been removed. A typical refresh is one request and a few seconds.

`GoodTeaching.md` carries the layout, the reference syntax, the command lines,
the counts to check against, and the rules of use.

## Changing the texts

After adding or changing a text file in `dev/text/ministry/`, or editing
`authors.json`, regenerate the index from `dev/`:

```
python3 rool/instructions/scripts/build_index.py
```

## Licences

The King James Version and the Darby translation are public domain, as are the
English hymn texts of the eighteenth and nineteenth centuries. The German,
Italian and Dutch hymn translations and the ministry texts were transcribed by
goodteaching.org; treat their status as needing a check before commercial reuse.
