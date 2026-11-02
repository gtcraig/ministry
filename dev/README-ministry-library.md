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
| `rool/instructions/` | How to read, index and search each source. Written for an AI agent; readable by anyone. |
| `rool/instructions/scripts/` | Two small stdlib-only Python tools: `expand.py` (Scripture references → verse text) and `hymns.py` (hymn lookup and search). |
| `rool/instructions/prompts/` | Stand-alone prompts that set a machine up from scratch, for people who cannot copy this repository. |
| `hymns/` | `hymns.json` (456 hymns, EN/DE/IT/NL, authors, metres, categories) and a readable index. |
| `text/bible/` | `KJV.json` and `Darby.json`, verse by verse, public domain. |
| `ministry/` | 386 text files (13,448 articles), the article index, the volume index, and the scribe index. |
| `magazines/` | Magazine source material. See `rool/instructions/magazines.md`. |

## Installing on a Rool Machine

Copy the three data folders to a machine's drive and give it the matching
instruction documents:

```
/rool-drive/ministry      ← ministry/index.json, Index.md, scribes.json, *.txt
/rool-drive/bible         ← KJV.json, Darby.json
/rool-drive/hymns         ← hymns.json
```

Then tell the machine to read `rool/instructions/`. It has everything it needs
there: the file structures, the reference syntax, the command lines, and the
counts to check itself against.

`Copying These Files Into The Repo.md` has the exact shell commands.

## Licences

The King James Version and the Darby translation are public domain, as are the
English hymn texts of the eighteenth and nineteenth centuries. The German,
Italian and Dutch hymn translations and the ministry texts were transcribed by
goodteaching.org; treat their status as needing a check before commercial reuse.
