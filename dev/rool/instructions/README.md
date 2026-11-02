# Instructions

This folder is the operating manual for the library. Each document describes one
source in full: what the files are, how they are structured, the syntax used to
refer to things inside them, the commands that read them, and the totals to check
against.

| Document | Source | Files |
|---|---|---|
| `Scripture Text.md` | KJV and Darby verse text, and the citation expander | `text/bible/KJV.json`, `Darby.json`, `scripts/expand.py` |
| `Hymns.md` | 456 hymns in four languages, and hymn citation lookup | `text/hymns/hymns.json`, `scripts/hymns.py` |
| `Ministry Texts.md` | 386 files, 13,448 articles, the indexes, the scribe index | `ministry/` |
| `magazines.md` | The magazine source — the repository owner's own document | `magazines/` |

`magazines.md` is written and maintained by the repository owner; it is the model
the other three documents follow. It is not reproduced here.

`prompts/` holds the same knowledge in a different shape: self-contained prompts
that build a working library on a machine that has none of these files. They are
for handing to people, not for reference.

## House rules

- **The text is the authority.** Tools resolve references; they do not correct
  them. Where a citation is a misprint in the source, say so and leave it.
- **Never guess a reference.** If a tool returns nothing, report the article
  file and line, and quote what the text actually says.
- **Cite the place.** Article title, file, page number. A quotation from these
  volumes without its page is not much use to a preacher or a student.
- **Keep the totals honest.** Every document here states expected counts
  (13,448 articles; 8185 of 8197 citations resolving; 505 of 512 hymn
  references resolving). If a rebuild gives different numbers, something has
  changed and it should be investigated, not absorbed.
