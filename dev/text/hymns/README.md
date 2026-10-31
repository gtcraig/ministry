# Hymns data source

`hymns.json` is a phpMyAdmin (5.2.3) JSON export of the hymn tables from the
`goodteaching_org_min` MySQL database. It holds 456 hymns with full text in
English, German, Italian and Dutch, plus authors, metres and usage categories.

The file is treated as **read-only**: it is the export as produced, and new
languages are added alongside it rather than edited into it (see
[Adding a language](#adding-a-language)).

## File structure

The top level is a JSON array of blocks, each with a `type`:

| `type`     | Meaning                                                    |
|------------|------------------------------------------------------------|
| `header`   | Export tool and version. Ignore.                           |
| `database` | Source database name. Ignore.                              |
| `table`    | One table: `name` is the table name, `data` is its rows.   |

Readers should locate tables by `name`, never by position in the array.

**Every value is a string or `null`** — including ids and numbers
(`"hymn_no":"12"`). Cast `hymn_no`, `vers_no`, `line_no`, `*_id` and
`disp_order` to integers when loading.

## Tables

### Language tables

Each language has a pair of tables. English has no suffix; every other
language uses a lowercase ISO 639-1 suffix.

| Language | Hymn table | Line table      | Hymns | Lines |
|----------|------------|-----------------|------:|------:|
| English  | `hymn`     | `hymn_line`     |   456 | 8,613 |
| German   | `hymn_de`  | `hymn_line_de`  |   456 | 8,713 |
| Italian  | `hymn_it`  | `hymn_line_it`  |   456 | 8,684 |
| Dutch    | `hymn_nl`  | `hymn_line_nl`  |   455 | 8,630 |

The language list is defined by this naming pattern, so a reader should
discover languages from table names (`hymn` / `hymn_<xx>`) rather than
hard-coding them.

**`hymn[_xx]`** — one row per hymn.

| Field       | Description                                                      |
|-------------|------------------------------------------------------------------|
| `hymn_no`   | Hymn number, 1–456. The same number is the same hymn in every language. |
| `meter`     | Metre as printed in that language's book, e.g. `8.7.8.7. Dactylic`, `11.10.11.10. Dattilico.` Free text, display only. |
| `meter_id`  | → `hymn_meter.id`. May differ between languages where the translation is in a different metre. |
| `author_id` | → `authors.id`. Always the original (English) author; identical across languages. |

**`hymn_line[_xx]`** — one row per printed line.

| Field       | Description                         |
|-------------|-------------------------------------|
| `hymn_no`   | → `hymn[_xx].hymn_no`               |
| `vers_no`   | Verse (stanza) number               |
| `line_no`   | Line number within the verse        |
| `line_text` | The line, UTF-8                     |

Rows are **not guaranteed to be in order** in the file. Always sort by
`(hymn_no, vers_no, line_no)` as integers. Treat `vers_no` / `line_no` as
sort keys, not as display numbers — see [Known data issues](#known-data-issues).

In the translations the first word (or words) of each hymn is capitalised,
as in the printed books (`VON all den Gaben…`). English is not.

### Shared tables

**`authors`** (213 rows)

| Field         | Description                                               |
|---------------|-----------------------------------------------------------|
| `id`          | Key. `9998` = Unknown, `9999` = Anonymous.                |
| `fullname`    | Display name, e.g. `A. M. Toplady`. Always present.        |
| `surname`     | Sort key. `null` for Unknown, Anonymous, Bernard of Clairvaux. |
| `firstnames`  | Often `null`.                                             |
| `author_life` | Dates as display text, including brackets: `(1740-1778)`.  |
| `bio_url`     | External biography link, often `null`. All are `http://` and may be dead. |
| `created`     | Always `null`. Ignore.                                    |
| `modified`    | `YYYY-MM-DD HH:MM:SS` or `null`. Ignore.                  |

**`hymn_meter`** (180 rows)

| Field        | Description                                               |
|--------------|-----------------------------------------------------------|
| `id`         | Key                                                       |
| `meter`      | Canonical metre, e.g. `C.M.`, `8.7.8.7.`                   |
| `rhythm`     | `Dactylic`, `Iambic`, … or `null`                         |
| `chorus`     | Chorus metre or `null`                                    |
| `disp_order` | Sort order for listing metres                             |

The same `meter` text appears on several rows that differ only by `rhythm`
or `chorus`, so group tunes by `id`, not by `meter` text.

**`hymn_schemes`** — schemes for classifying hymns by use: `1` GM (George
Murray), `2` AD (Alan Davies). Only scheme 1 currently has categories.

**`hymn_scheme_categories`** (14 rows) — `id`, `code`, `name`, `scheme_id`,
`disp_order`. E.g. `SL1` "Service of God - Lord Jesus - 1st Hymn", `G`
"Gospel". Several share `disp_order` 9; break ties by `id`.

**`hymn_categories`** (544 rows) — links `hymn_no` → `category_id`
(→ `hymn_scheme_categories.id`). A hymn can be in 1–4 categories; categories
apply to the hymn in every language.

## Relationships

```
authors.id ◄── hymn[_xx].author_id
hymn_meter.id ◄── hymn[_xx].meter_id
hymn[_xx].hymn_no ◄── hymn_line[_xx].hymn_no
hymn.hymn_no ◄── hymn_categories.hymn_no
hymn_scheme_categories.id ◄── hymn_categories.category_id
hymn_schemes.id ◄── hymn_scheme_categories.scheme_id
```

## Adding a language

Do not edit `hymns.json`. Put each new language in its own file next to it,
in exactly the same phpMyAdmin format, e.g. `hymns_fr.json` containing tables
`hymn_fr` and `hymn_line_fr`.

A reader should therefore:

1. Load every `hymns*.json` file in this folder.
2. Merge all `table` blocks by `name` (table names must be unique across files).
3. Detect languages from the `hymn` / `hymn_<xx>` table names.

The easiest way to produce the file is to create the two tables in MySQL with
the same columns as `hymn_de` / `hymn_line_de` and export just those two
tables with phpMyAdmin's JSON export.

A new language must use the same `hymn_no` values as English, `author_id`
from English, and a `meter_id` that exists in `hymn_meter` (add rows there
only via a fresh full export).

## Known data issues

As of this export (October 2026):

- **Dutch hymn 169** has lines in `hymn_line_nl` but no row in `hymn_nl`.
  Fall back to English `meter`/`author_id`, or skip the hymn.
- **Single-verse hymns are numbered inconsistently.** English uses verse 1.
  German uses verse `0` for hymns 7, 8, 10, 17, 60, 73, 218, 260, 310, 319.
  Dutch stores some under a later verse with lines not starting at 1
  (e.g. hymn 17 is verse 2, lines 5–12; also 60, 73, 91, 218). Renumber
  verses and lines from 1 for display.
- **Verse gaps:** German hymn 59 has no verse 3; Italian 113 has verses 1 and
  3 only, 116 has no verse 4.
- **Verse counts differ** from English in some translations (10 German,
  49 Italian, 7 Dutch hymns) — translations sometimes omit or split verses.
  This is not necessarily an error, but don't align verses across languages
  by number.
- **Italian hymn 285, line 1** contains a Cyrillic `Ї` (U+0407) in
  `GLORЇOSO`; it should be `Ï`.
- `hymn_line` (English) hymn 127 is stored in reverse order — harmless if
  you sort as described.
- 3 metres in `hymn_meter` are not used by any hymn.
