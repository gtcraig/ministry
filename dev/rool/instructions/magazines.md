# Magazines: A Word in its Season and Notes of Ministry

These instructions tell you how to use the magazine collection: what it holds,
how the files are laid out, and how to find, read and cite what is in them.
The full description of the file format is in
`dev/text/magazines/README.md`. This file covers how to use it.

## What the collection is

Two monthly magazines of ministry, one JSON file per issue, with the complete
text of every article:

| Magazine | In the file | Issues |
|---|---|---|
| A Word in its Season (AWIIS), 1st Series | `code: "awiis"`, `series: 1` | 408: Nos 1–407 (March 1973 – February 2007), plus a supplement to No. 48 |
| A Word in its Season (AWIIS), 2nd Series | `code: "awiis"`, `series: 2` | 236: Nos 1–236, from April 2007 |
| Notes of Ministry (NOM) | `code: "nom"`, `series: null` | 649: Nos 1–648, plus No. 512A, from December 1972 |

The articles are mostly addresses (one speaker), readings (a conversation
among several brothers, each marked by his initials), words at marriages and
burials, extracts from older ministry, poems and letters.

Treat these files as the text of the magazines. Do not go back to the PDF,
Word or EPUB copies. The files are generated from the calibre library and are
read-only: never change them. If you find an error in the text, report the
issue, the article and the error so it can be corrected at source.

## Where the files are

```
dev/text/magazines/awiis/awiis1-NNN.json   AWIIS 1st Series, issue NNN
dev/text/magazines/awiis/awiis2-NNN.json   AWIIS 2nd Series, issue NNN
dev/text/magazines/nom/nom-NNN.json        Notes of Ministry, issue NNN
```

`NNN` is the issue number padded to three digits (`awiis2-059.json` is
2nd Series No. 59). Two exceptions: `awiis1-048-sup.json` (the No. 48
supplement, March 1977) and `nom-512a.json` (No. 512A).

**AWIIS numbers are ambiguous.** Both series reuse the same numbers, so
"A Word in its Season No. 59" could mean either. If the series is not stated,
look in both. A date settles it: the 1st Series ran from March 1973 to
February 2007, and the 2nd Series started in April 2007. Otherwise give both,
or ask.

## The shape of one issue

```
issue
├── magazine, code, series, issue, number, title, date (YYYY-MM)
├── source            where it came from (calibre id, file) - not needed for answers
├── articles[]
│   ├── number        position in the issue (1, 2, 3 …)
│   ├── group         heading the article sits under, e.g. "AT TWO BURIALS - 1"
│   ├── title
│   ├── author        name printed under the title
│   ├── scriptures[]  scriptures read at the start
│   ├── notes[]       short header labels, e.g. "(Address)"
│   ├── meeting       type of meeting, e.g. "Reading", "Address"
│   ├── place         locality
│   ├── date          date of the meeting, as printed
│   ├── servant       brother named at the end
│   ├── speakers[]    initials of those who speak (readings)
│   ├── initials[]    key: {initials, name, place}
│   ├── initials_text the key exactly as printed
│   ├── footer[]      any other closing lines
│   └── paragraphs[]  {text, speaker?, source?}
└── back_matter[]     publisher / printer lines - ignore
```

Only `number`, `title` and `paragraphs` are always present. Every other
article field appears only when the issue printed it **and** the build
recognised it. If a field is missing, that does not mean the information is
not there: look in the first and last few `paragraphs` and in `footer`
before saying it is not given.

## Two dates: do not confuse them

- The issue's `date` (`"2012-02"`) is when the **magazine** was published.
- The article's `date` (`"4th October 2011"`) is when the **meeting** took
  place. That is usually some months earlier, and for extracts it can be
  decades earlier.

When someone asks "when was this said", give the article `date`. When they
ask "which issue", give the issue's number and month.

## Who said it

Work out who spoke an article in this order:

1. **Addresses and words:** `author` (the name under the title, common in
   AWIIS 2nd Series and NOM), otherwise `servant` (the name at the end).
2. **Readings:** no single speaker. Use each paragraph's `speaker` and the
   article's `initials` key (see below).
3. **Extracts:** each paragraph may have a `source`, e.g.
   `"J. Taylor (Vol. 47, p.11, 12)"`. That is the original author and
   reference: the magazine is quoting him.

Names are printed in several ways for the same man ("J. Renton",
"Jim Renton", "J T Brown", "Jim T.Brown"). Match on surname plus initials,
and say when a match is uncertain.

## Readings: speakers and initials

In a reading, each speaker's contribution begins with his initials. They have
been taken out of the text into `speaker`:

```json
{"speaker": "WSC", "text": "We are considering the subject of …"}
{"text": "The scripture in Ecclesiastes goes on to consider …"}
{"speaker": "APD", "text": "Would you say …"}
```

- A paragraph **without** a `speaker` continues the last speaker above it.
  In the example, the second paragraph is still WSC.
- `Rem.` (remark), `Ques.` / `Quest.` / `Q.` (question) and `A.` (answer)
  mark contributions from someone not named.
- Initials appear with dots (`E.C.B.`, mostly AWIIS 1st Series and NOM) or
  without (`ECB`, AWIIS 2nd Series). Always compare them with dots and spaces
  removed.

**The key.** Where the issue printed a "Key to Initials" or "List of
Initials", it is attached to the article it belongs to as `initials`:

```json
"initials": [
  {"initials": "JRB", "name": "J R Bellamy", "place": "Vancouver"},
  {"initials": "WSC", "name": "W S Chellberg", "place": "Wheaton"}
]
```

To name a speaker, look up his initials in **that article's** `initials`.
Rules:

- Use only the key on the same article. The same initials belong to
  different men in different places and years.
- Some keys give a default place in their heading, e.g. "(Birmingham unless
  otherwise stated)". Check `initials_text` for this, and use that place
  where an entry has none.
- Where the key did not print the initials, they were derived from the name
  (`"R M Brown"` → `RMB`). Some names are shortened differently in the text:
  "A McSeveney" may be `AMcS`, and "Steve W Drever" may be `SWD`. If the
  initials are not in the key exactly, check `initials_text`. Match on the
  name only when there is **one** clear candidate, and say you matched it
  that way.
- If there is no key, or no match, give the initials as printed and say the
  issue does not identify him. About 550 readings have a key; many older
  ones do not. **Never guess a name from initials**, from memory or from
  other issues. If you are asked to and do infer one, say it is an inference.

## Scriptures

`scriptures` holds the scriptures read at the start, one entry per line as
printed. A line may hold several references:

```
"John 4: 1-30; 9: 11, 12, 25 (from “one thing”), 35-38"
```

After a semicolon, a bare number continues the **same book**: `9: 11`
above means John 9: 11. References have a space after the colon. Ranges use
hyphens or en dashes (`1-30`, `1–30`, `1 - 6`). Book names may be abbreviated
(`1 Cor`, `Matt`, `Ps`).

When asked what has been said on a scripture:

1. First, articles whose `scriptures` include that passage. These are about
   it.
2. Then articles that quote or refer to it in their `paragraphs`. These
   touch on it. Say which kind each result is.

## Searching

- **By title:** match `title`, ignoring case and quotation marks. Titles
  are mostly stored in capitals.
- **By subject:** titles first, then `paragraphs[].text`. Give the article
  (title and issue) and the passage, not just the issue.
- **By person:** `author`, `servant`, the `name` field of `initials`, and
  speaker initials.
- **By place or year:** the article's `place` and `date`. Formats vary
  ("4th October 2011", "28 April 1981", "1933"). A missing `place` may
  still be printed in the closing paragraphs.
- **Related articles:** articles sharing a `group`, or with the same place
  and date in the same issue, come from the same occasion, such as a series
  of meetings or a marriage. Give the `group` along with the title.

## Citing

Cite every quotation or summary so the reader can find it in print. The
pattern is: magazine (series), issue number, issue month and year. Then the
article title in title case, followed by whichever of author/servant,
meeting, place and meeting date are present:

> *A Word in its Season* (2nd Series) No. 59, February 2012 — "A Cloth Wholly
> of Blue", George A Coull, Aberdeen, 4th October 2011.

> *Notes of Ministry* No. 108, November 1981 — "Devotion and Committal",
> J. Renton, Word in meeting for ministry, Grangemouth, 28 April 1981.

For a reading, add the speaker: "… Calgary, 2nd July 2011 (W S Chellberg,
WSC)".

Quote the text exactly as it is in `paragraphs`. Do not tidy the wording.

## Limits

- The text is complete: checked against calibre's index, every issue is
  97–100 % of its source's words. The cover and contents pages were left
  out. The fields (author, meeting, place, date, servant) were picked out by
  pattern-matching and can occasionally be missing or, rarely, wrong. When a
  field matters to the answer, check it against the opening and closing
  paragraphs.
- About a third of AWIIS 1st Series articles have no `place`/`date`, mostly
  because the issue does not give them (extracts, letters, poems).
- Spelling and punctuation follow each issue. Older issues have occasional
  scanning errors, e.g. "1 have" for "I have". Read past them, quote them as
  they are, and do not correct them silently.
- This collection is the magazines only. The volumes of ministry (JND, JT,
  CAC, etc.), the Bible and the hymns are separate sources. Where an article
  refers to a hymn ("(Hymn 199)") or a volume ("Vol. 47, p.11"), the full
  text is in those sources, not here.
