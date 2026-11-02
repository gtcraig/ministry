# Prompt: add KJV + Darby verse text to a ministry library

Paste this into a Rool machine that already holds the ministry texts at
`/rool-drive/ministry` (with `index.json`):

---

Set up public-domain Bible text alongside my ministry library.

1. Create `/rool-drive/bible/` and download the KJV and Darby JSON from
   `https://raw.githubusercontent.com/scrollmapper/bible_databases/master/formats/json/KJV.json`
   and `.../Darby.json`. Both are public domain. Keep the filenames `KJV.json` and `Darby.json`.

2. Write `/rool-drive/bible/expand.py` — one self-contained, stdlib-only script that turns
   ministry-style citations into verse text, e.g.
   `./expand.py --trans Darby "@1 Peter 1: 13 - 2: 10; @Jude 3,4"`.
   It must cope with the citation style actually used in the library:
   - several refs separated by `;`, each starting `@`
   - full book names, numbered books (`1 Kings`), common abbreviations, `Ps`/`Psalm(s)`,
     `Song of Songs`/`Canticles`, `Revelation of St John`
   - chapter only (`@Psalm 23`) = whole chapter; verse lists with `,`; `3 - 5`, `3-5`,
     `3: 1 to 5`, `11 and 12`; cross-chapter ranges `1: 13 - 2: 10`
   - single-chapter books (`@Jude 3` means verse 3)
   - stray prose after a ref, brackets, and the typos in the corpus: `as` for `;`,
     `l` for `1` (`3:7-l1`), `26. 26` for `26: 26`, footnote markers
   - options: `--trans KJV|Darby` (default KJV), `--json` for structured output,
     several refs as arguments or on stdin; print `Book C:V  text` per line.
   Keep the parser readable and print nothing for a ref it cannot resolve rather than guessing.

3. Verify against the library: read every article's `scripture` field in
   `/rool-drive/ministry/index.json`, expand each with Darby, and report
   - how many `@` lines resolved and how many verses that produced
   - the `@` lines that resolved to nothing, with the article file, so I can check each
     one (some are prose that merely starts with `@`, some are genuine misprints).

---

Expected order of magnitude: ~8,200 citation lines, ~170,000 verses, and a dozen or so
unresolved lines, all prose or misprints.
