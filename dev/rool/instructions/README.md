# Instructions

This folder is the operating manual for the library. Each document describes one
source in full: what the files are, how they are structured, the syntax used to
refer to things inside them, the commands that read them, and the totals to check
against.

**Start with `GoodTeaching.md`.** It is the build instruction: one prompt to
build the library on a fresh machine, one command to refresh it from the
repository, the checks to run and the counts to expect.

| Document | Source | Files |
|---|---|---|
| `GoodTeaching.md` | The build and refresh: install, layout, checks, counts, rules, known quirks | all of the below |
| `Scripture Text.md` | KJV and Darby verse text, and the citation expander | `text/bible/KJV.json`, `Darby.json`, `scripts/expand.py` |
| `Hymns.md` | 456 hymns in four languages, and hymn citation lookup | `text/hymns/hymns.json`, `scripts/hymns.py` |
| `Ministry Texts.md` | 391 files, 13,662 articles, the indexes, the JT initials index | `text/ministry/` |
| `magazines.md` | The magazine source — the repository owner's own document | `text/magazines/` |

All paths in these documents are relative to `dev/` in this repository. On an
installed machine the folders are `ministry/`, `bible/`, `hymns/`, `magazines/`.

`magazines.md` is written and maintained by the repository owner; it is the model
the other three documents follow. It is not reproduced here.

`scripts/` holds the two lookup tools and the installer: `expand.py`,
`hymns.py` and `refresh.py`.

`prompts/` holds the same knowledge in a different shape: self-contained prompts
that build a working library on a machine that has none of these files. They are
for handing to people, not for reference.

## House rules

- **The text is the authority.** Tools resolve references; they do not correct
  them. Where a citation is a misprint in the source, say so and leave it.
- **Never guess a reference.** If a tool returns nothing, report the article
  file and line, and quote what the text actually says.
- **Cite the place.** Article title, file, page number. A quotation from these
  volumes without its page is not much use to a preacher or a student. Quote the
  page without braces — "page 23" or "p. 23", never `{23}`. In `gvw` the `{N}`
  markers are article numbers, not printed pages: cite the volume and article
  title instead.
- **Name the brothers with honour.** Always "Mr Surname" — Mr Taylor, Mr Coates,
  Mr Gardiner — never the surname alone, in prose, citations and summaries alike.
- **Keep the totals honest.** Every document here states expected counts
  (13,662 articles; 9,128 of 9,169 `@` citation lines resolving; 505 of 512
  hymn references resolving). If a rebuild gives different numbers, something
  has changed and it should be investigated, not absorbed.
