# Scripture Text

Verse-by-verse text of the King James Version and the Darby translation, and a
tool that turns the library's citation style into verses.

## Files

| File | Contents |
|---|---|
| `text/bible/KJV.json` | KJV, 66 books, 1,189 chapters, 31,102 verses |
| `text/bible/Darby.json` | J. N. Darby, *The Holy Scriptures* (1889), same structure, 31,102 verses |
| `rool/instructions/scripts/expand.py` | citation expander, stdlib only |

Both were taken from the `scrollmapper/bible_databases` project (public domain)
and keep its shape:

```json
{
  "translation": "KJV: King James Version",
  "source": "https://raw.githubusercontent.com/.../KJV.json",
  "books": {
    "Genesis": { "1": { "1": "In the beginning God created...", "2": "..." } }
  }
}
```

`books` → chapter number as a string → verse number as a string → verse text.

## Citation syntax in the library

Ministry articles carry their Scriptures on the line after the title, each
reference prefixed with `@` and separated by semicolons:

```
@1 Timothy 2:1-4; @1 Timothy 3:14-16; @1 Timothy 4: 4-10; @1 Timothy 6:11
```

`expand.py` accepts that exactly as written, plus:

- a chapter on its own — `@Psalm 23` means the whole chapter
- verse lists with commas — `@Jude 3,4`
- ranges `3 - 5`, `3-5`, `3: 1 to 5`, `11 and 12`
- cross-chapter ranges — `@1 Peter 1: 13 - 2: 10`
- single-chapter books, where `@Jude 3` is verse 3 and not chapter 3
- full names, numbered books, common abbreviations, `Ps`/`Psalm(s)`,
  `Song of Songs`/`Canticles`, `Revelation (of St John)`
- the corpus's own slips: `as` for `;`, `l` for `1` (`3:7-l1`), `26. 26` for
  `26: 26`, footnote markers

An unresolvable reference prints nothing rather than a guess.

## Commands

```bash
# one reference
python3 rool/instructions/scripts/expand.py "@1 Peter 1: 13 - 2: 10" --trans Darby

# structured output, for scripting
python3 rool/instructions/scripts/expand.py --json "@Jude 3,4"

# point at a different Bible folder
python3 rool/instructions/scripts/expand.py --dir text/bible "@Psalm 23"
```

The script finds `text/bible` by itself, whether it is run from the repository
root, from `rool/instructions`, or from anywhere else.

## What to expect

Across the 388 ministry files there are 9,169 `@` citation lines. Of these
**9,128 resolve**, producing 199,226 verses in the KJV. The forty-one that do not are
either prose that happens to begin with `@` or genuine misprints (for example
`@2 Cor 2:20-22`, where 2 Corinthians has thirteen chapters and no verses 20–22
in chapter 2). Those forty-one should be reported with their article file, never
silently dropped.

## Notes on use

- The KJV is the translation the earlier writers quoted; the Darby is closer to
  the wording in the later ministry. When quoting a verse *as it appears in an
  article*, quote the article, not the Bible file, and say which translation
  the article is using if it is clear.
- Verse numbers differ between translations in a few places (3 John, Revelation
  in some editions). The two files here agree in verse count, so a citation that
  resolves in one resolves in the other.
