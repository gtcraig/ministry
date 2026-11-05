# Prompts

Self-contained prompts for setting up a Rool Machine from public sources. Each
one is written to be pasted whole into a machine with no library and no files
from this repository, and each carries the scripts it needs inline, so nothing
has to be fetched from anywhere but `raw.githubusercontent.com`.

| Prompt | Builds |
|---|---|
| `Setting Up Scripture Text Prompt.md` | `bible/KJV.json`, `Darby.json`, `expand.py` |
| `Adding Hymn Search Prompt.md` | `hymns/hymns.json`, `hymns.py`, notes |
| `Adding JT Initials Prompt.md` | `ministry/jt_initials.json` from the spreadsheet (attach the .xlsx) |

Run them in that order: hymns and JT initials both assume the ministry texts are
already in place.

The authoritative copies of the two scripts live in
`rool/instructions/scripts/`. The prompts embed them as they stood when written;
if a script is improved, update the matching prompt too.
