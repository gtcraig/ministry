# Hymns

456 hymns — English text with German, Italian and Dutch translations — and a
tool that resolves the hymn references scattered through the ministry text.

## Files

| File | Contents |
|---|---|
| `text/hymns/hymns.json` | the hymn tables, as exported from the ministry database |
| `text/hymns/Hymns Index.md` | readable index: number, first line, author, metre, categories |
| `rool/instructions/scripts/hymns.py` | lookup and search, stdlib only |

In this repository they sit under `text/hymns/`; on a Rool drive they sit under
`hymns/`. The script searches for both, so either layout works.

## Shape of `hymns.json`

It is a phpMyAdmin export: an array of 13 tables, each `{"type":"table","name":…,"data":[…]}`.
The useful ones:

| Table | Rows | Fields |
|---|---|---|
| `hymn` | 456 | `hymn_no`, `meter`, `meter_id`, `author_id` |
| `hymn_de` / `hymn_it` / `hymn_nl` | 456 / 456 / 455 | the same, per language |
| `hymn_line` | 8,613 | `hymn_no`, `vers_no`, `line_no`, `line_text` |
| `hymn_line_de` / `_it` / `_nl` | 8,713 / 8,684 / 8,630 | the same, per language |
| `authors` | 213 | `id`, `fullname`, `surname`, `firstnames`, `author_life`, `bio_url` |
| `hymn_categories` | 544 | `hymn_no`, `category_id` |
| `hymn_scheme_categories` | 14 | `id`, `code`, `name`, `scheme_id` |
| `hymn_meter` | 180 | `id`, `meter`, `rhythm`, `chorus` |

A verse is the set of `hymn_line` rows sharing `hymn_no` and `vers_no`, ordered
by `line_no`. Every field is a string.

**`vers_no = 0` is a chorus**, not a first verse, in hymns that carry one (mostly
German). Do not print verse 0 as "verse 1".

## Reference syntax in the ministry text

A hymn is cited with a **backtick**, then `number:verse)` — usually right after
the couplet quoted from it:

```
"Love so amazing, so divine, <br>Demands my soul, my life, my all".  (`272:4)
```

The number is `hymn_no`; the verse is `vers_no`. There are 512 such references
across the 380 ministry files. **505 resolve.** The seven that do not point at
hymn numbers above 456 — 464, 474, 475, 479, 487 — which are outside this
collection. Say so; do not guess at their text.

## Commands

```bash
S=rool/instructions/scripts/hymns.py

python3 $S --hymn 272                    # whole hymn, all languages
python3 $S --hymn 272 --lang en          # English only
python3 $S --ref '`272:4)'               # one verse; the ref can be pasted as found
python3 $S --search 'love so amazing'    # verses containing every word
python3 $S --search 'Vater' --lang de --json
python3 $S --search 'amazing|wondrous' --regex
python3 $S --first-line 'When I survey'  # identify a hymn from its opening line
python3 $S --scan ministry/jt/*.txt      # every reference in a file set
python3 $S --index "text/hymns/Hymns Index.md"   # regenerate the index
```

`--lang` takes `all` (default), or any of `en,de,it,nl` separated by commas.
The script finds `hymns/` by itself from anywhere in the repository.

`--first-line` ignores case, punctuation and leading articles, so
`--first-line 'of all the gifts'` finds 272.

## What the fields mean

- **Metre** is the pattern given in the database (`C.M.`, `8.7.8.7.`, `10.10.10.10.`).
  `hymn_meter` holds the expansions and a `chorus` flag.
- **Author** is `authors.fullname` (`I. Watts`, `J. N. Darby`, `Miss F. R. Havergal`).
  When naming the brother or sister in your own prose, give the honorific and
  surname — Mr Watts, Mr Darby, Miss Havergal — and leave the database's own
  form alone in a citation.
- **Categories** come through `hymn_categories` to `hymn_scheme_categories`
  (14 named categories across 2 schemes), useful for finding hymns by subject.

## Notes on use

- When quoting a hymn in the ministry text, the article's wording is the
  authority for what was sung; use `hymns.json` to identify and complete it.
- Hymn numbering is the ministry's own (`hymn_no`), not a denominational
  hymnal's. Hymn 272 is "When I survey the wondrous cross" here; it is not 272
  in every book.
