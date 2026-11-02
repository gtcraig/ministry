# Prompts

Self-contained prompts for setting up a Rool Machine from public sources. Each
one is written to be pasted whole into a machine with no library and no files
from this repository, and each carries the scripts it needs inline, so nothing
has to be fetched from anywhere but `raw.githubusercontent.com`.

| Prompt | Builds |
|---|---|
| `Setting Up Scripture Text Prompt.md` | `bible/KJV.json`, `Darby.json`, `expand.py` |
| `Adding Hymn Search Prompt.md` | `hymns/hymns.json`, `hymns.py`, notes |
| `Adding Scribe Initials Prompt.md` | `ministry/scribes.json` from the spreadsheet (attach the .xlsx) |

Run them in that order: hymns and scribes both assume the ministry texts are
already in place.

The authoritative copies of the two scripts live in
`rool/instructions/scripts/`. The prompts embed them as they stood when written;
if a script is improved, update the matching prompt too.
