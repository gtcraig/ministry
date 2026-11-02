# Good Teaching — build and refresh

This is the only file needed to build the Good Teaching library on a fresh
machine, and the only file needed to keep it current afterwards. It fetches the
texts from the repository, installs the lookup tools, checks the result against
known totals, and records what it installed so that the next run downloads only
what has actually changed.

One prompt builds it:

> **Build the Good Teaching library from**
> `https://raw.githubusercontent.com/gtcraig/ministry/main/dev/rool/instructions/GoodTeaching.md`

And one command keeps it current:

> **Refresh from repo**

(The file in GitHub's web view is at
`https://github.com/gtcraig/ministry/tree/main/dev/rool/instructions/GoodTeaching.md`.
Use the `raw.githubusercontent.com` address above when a machine is fetching it;
the `github.com` address is the one to read in a browser.)

---

## 1. What gets built

Four data sets, from the `dev/text/` folders of the repository.

| Folder | Contents | Files | Size |
|---|---|---|---|
| `ministry/` | 380 volumes of ministry text, 13,448 articles, `index.json`, `scribes.json` | 381 `.txt` + indexes | ~215 MB |
| `magazines/` | 1,293 magazine issues — *A Word in its Season* (644) and *Notes of Ministry* (649) | 1,293 `.json` | ~75 MB |
| `bible/` | KJV and Darby verse text, with `expand.py` | 2 JSON + 2 folders | ~22 MB |
| `hymns/` | 456 hymns in EN/DE/IT/NL, index, `hymns.py` | 2 files + 1 index | ~3 MB |

On the machine these live at `/rool-drive/ministry`, `/rool-drive/magazines`,
`/rool-drive/bible`, `/rool-drive/hymns`. The scripts find their data by folder
name, so either layout works. The installer keeps its own state in
`/rool-drive/Good Teaching/`.

## 2. Build

Two commands.

```bash
curl -fsSL https://raw.githubusercontent.com/gtcraig/ministry/main/dev/rool/instructions/scripts/refresh.py -o /tmp/refresh.py
python3 /tmp/refresh.py
```

The first run downloads the whole data set, about 300 MB, in roughly half a
minute on a good connection. It writes only into `/rool-drive` and leaves
everything else alone. Python 3.8 or later; standard library only; no `pip`.

Keep the script somewhere durable so that "Refresh from repo" is always one
command:

```bash
mkdir -p "/rool-drive/Good Teaching"
cp /tmp/refresh.py "/rool-drive/Good Teaching/refresh.py"
```

## 3. Refresh from repo

```bash
python3 "/rool-drive/Good Teaching/refresh.py"
```

This is the whole of it. Under the surface it makes **one** request to the GitHub
API for a listing of every file with its blob id, compares that list with the
manifest written by the previous run, and downloads only the files whose id has
changed — plus any file that has appeared since, and deleting any that has gone.
A refresh that has nothing to do costs one request and under a second; a refresh
that picks up a new magazine costs that plus the file itself.

Useful variations:

```bash
python3 refresh.py --check              # say what would change; write nothing
python3 refresh.py --branch change/69   # a branch other than main
python3 refresh.py --dest /tmp/gt       # somewhere other than /rool-drive
python3 refresh.py --quiet              # totals only
```

The manifest is only written after every file has been fetched, so a failed or
interrupted run is simply run again. Files are written through a temporary copy,
so a half-downloaded text file never lands in the library.

**Re-run the checks after any refresh.** If the repository gains text files but
`ministry/index.json` is not regenerated, the article count falls out of step and
the refresh will say so.

## 4. What to read next

`GoodTeaching.md` is the build. The detail for each folder sits beside it; read
the one that matches the work in hand. Paths are relative to `dev/rool/instructions/`.

| Document | Read it for |
|---|---|
| `Scripture Text.md` | `bible/` — the KJV and Darby files, the `@` citation syntax, and every flag of `expand.py` |
| `Ministry Texts.md` | `ministry/` — file structure, article headings, page numbers, `index.json`, `scribes.json`, volume initials |
| `Hymns.md` | `hymns/` — the 13 tables in `hymns.json`, hymn citation syntax, and every flag of `hymns.py` |
| `magazines.md` | `magazines/` — the schema of the issue files. Written by the repository owner; not reproduced here |
| `prompts/` | Stand-alone prompts that rebuild each data set on a machine that has none of these files |
| `README.md` | The index of the above |

## 5. Checks, and the totals to expect

The installer runs these itself at the end of a build. They can be run by hand:

```bash
find /rool-drive/ministry -name '*.txt' | wc -l                        # 381
jq '[.[] | .articles | length] | add' /rool-drive/ministry/index.json  # 13448
jq 'length' /rool-drive/ministry/index.json                            # 380
jq 'length' /rool-drive/ministry/scribes.json                          # 8969
ls /rool-drive/magazines/*/*.json | wc -l                              # 1293
python3 /rool-drive/hymns/hymns.py --hymn 272                          # When I survey
python3 /rool-drive/bible/expand.py --trans Darby "@John 3: 16"        # For God so loved
```

If a refresh reports different numbers, something has changed in the repository
and should be investigated rather than absorbed. Two particular cases:

- **article count above 13,448** — text has been added and `index.json` needs
  regenerating in the repository, otherwise the new articles are unreachable
  through the index.
- **magazine count above 1,293** — a new issue has been added; good news, and the
  only thing to do is note the new figure here.

## 6. House rules

These are the working rules of the library. Put them into the machine's memory so
that they hold in every conversation, including one where nobody mentions them.

- **The text is the authority.** Tools resolve references; they do not correct
  them. Where a citation is a misprint in the source, say so and leave it.
- **Never guess a reference.** If a lookup returns nothing, give the article
  file and line and quote what the text actually says.
- **Cite the place.** Article title, file, page number. A quotation from these
  volumes without its page is not much use to a preacher or a student.
- **Name the servants with honour.** Brother, or brothers; never "man" or "men".
  Honorific and surname every time — Mr Spurgeon, Mr Lloyd-Jones, Mr Packer —
  never the bare surname and never the first name alone. After the full name,
  "the brother" may be used. For a sister, Mrs, Miss or Sister with the surname.
- **Initials in dialogue are rendered without dots and in bold**: **JT**: …
- **Identify a speaker by volume, then initial.** The volume is the number in the
  filename (`jt27` is Volume 27); look that volume up in `scribes.json` and match
  the initials to get the name and locality.
- **Do not blend traditions.** Note the stream a source speaks from; where
  servants genuinely disagree, set out the positions fairly.

## 7. Known quirks of the source

Not faults, and not to be "fixed":

- **`jr/` is not a Scribe volume.** `jr1.txt` and `jr2.txt` are *First Things and
  Other Ministry* by Jim Renton. `scribes.json` covers the `jt/` volumes 1–100
  only and does not apply to them.
- **Page numbers are at the start of a page**, as `{N}`; a volume title appears as
  `{#…}`.
- **Hymn references** are written with a backtick, number, colon, verse and a
  closing bracket: `` `272:4) ``. Verse 0 is the chorus. Seven references point
  above hymn 456 and cannot resolve; say they are outside the collection.
- **`@` lines** are the Scriptures read under an article title. 8,627 of 8,667
  resolve. The forty that do not are prose that happens to begin with `@`, or
  genuine misprints such as `@2 Cor 2:20-22` — 2 Corinthians has thirteen
  chapters. Report them with the file; do not invent a reference.
- **The article header volume is not the scribe volume.** `jt27` may show
  "Volume 87" in its header — that is the Ministry-series numbering. For speakers,
  use the filename number.

## 8. Troubleshooting

| Symptom | Cause | Remedy |
|---|---|---|
| `could not read the repository listing` | no network, or the branch name is wrong | check the branch; retry |
| `HTTP Error 404` on a `.py` file | that branch does not carry the scripts yet | copy the tool from `dev/rool/instructions/scripts/` by hand |
| `HTTP Error 403` after many runs | GitHub's unauthenticated limit of 60 listing requests an hour | wait an hour; normal refreshes use one |
| Downloads stall | connection dropped | run again; nothing partial was kept |
| Checks report a count mismatch | the repository changed | see section 5, then correct the total in this file |
| Space is short | a first build needs about 300 MB | `du -sh /rool-drive/*` shows where it went |

## 9. A different repository or branch

The defaults are `gtcraig/ministry` and `main`. Pass `--branch` for a branch, and
for a fork edit `REPO` at the top of `refresh.py`. Nothing else in the script is
repository-specific: the folder table `DIRS` and the tool table `FILES` are the
only places the layout appears.

## 10. Keeping this file true

This file is the contract. When the library changes — a new volume, a new
magazine series, a corrected tool — update the totals in section 1 and section 5
in the same commit, so that a build can be checked against what is written here
and the check means something.
