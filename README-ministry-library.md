# Ministry Library

A public source of the texts behind goodteaching.org: the ministry writings of
the Brethren teachers, the hymns they were quoted with, and the Scriptures they
were read from — plus the instructions that let an AI agent (a Rool Machine)
search them properly.

The point of this repository is not just to hold the text. It is to hold the
*relationships*: which hymn a preacher quoted, which verses an article was
preached on, which brother was speaking on which page. Those relationships are
what makes the library searchable rather than merely readable.

## Layout

| Path | What it holds |
|---|---|
| `dev/rool/instructions/` | **`GoodTeaching.md` first** — fetch it to a machine and the library builds and refreshes itself from this repository. Then one document per source: how to read, index and search it. Written for an AI agent; readable by anyone. |
| `dev/rool/instructions/scripts/` | Four small stdlib-only Python tools: `refresh.py` (install and refresh from this repository), `expand.py` (Scripture references → verse text), `hymns.py` (hymn lookup and search) and `build_index.py` (regenerate `index.json` and `Index.md` from the text). |
| `dev/rool/instructions/prompts/` | Stand-alone prompts that set a machine up from scratch, for people who cannot copy this repository. |
| `dev/text/hymns/` | `hymns.json` (456 hymns, EN/DE/IT/NL, authors, metres, categories) and a readable index. |
| `dev/text/bible/` | `KJV.json` and `Darby.json`, verse by verse, public domain. |
| `dev/text/ministry/` | 389 text files, 388 volumes (13,600 articles), the article index, the volume index, the scribe index, and `authors.json` (writer names). |
| `dev/text/magazines/` | 1,293 magazine issues — *A Word in its Season* and *Notes of Ministry*. See `dev/rool/instructions/magazines.md`. |

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
the counts to check against, and the rules of use. `Copying These Files Into The
Repo.md` has the manual route, if the repository is unreachable.

## Licences

The King James Version and the Darby translation are public domain, as are the
English hymn texts of the eighteenth and nineteenth centuries. The German,
Italian and Dutch hymn translations and the ministry texts were transcribed by
goodteaching.org; treat their status as needing a check before commercial reuse.
