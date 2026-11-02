#!/usr/bin/env python3
"""Expand ministry-style scripture references ('@1 Corinthians 15: 45 - 49')
into verse text from the KJV and Darby JSON files sitting next to this script.

  ./expand.py "@1 Corinthians 15: 45 - 49; @John 3: 16"
  ./expand.py --trans Darby "@Genesis 1:1 - 2:3"
  ./expand.py --json "@Jude 3,4"          # structured output
"""
import argparse, json, pathlib, re, sys

HERE = pathlib.Path(__file__).resolve().parent


def resolve_data_dir(explicit, rel, marker):
    """Find the folder holding `marker` (e.g. KJV.json).

    Tries the conventional subfolder, then text/<subfolder>, then dev/text/...,
    then the folder itself, walking up from this script.  Works for the
    repository (dev/text/bible) and for a flat Rool drive (bible/)."""
    if explicit:
        return pathlib.Path(explicit)
    rel = pathlib.Path(rel)
    rels = [rel]
    name = rel.name
    rels += [pathlib.Path("text") / name, pathlib.Path("dev") / "text" / name,
             pathlib.Path(name), pathlib.Path(".")]
    for base in (HERE, *HERE.parents):
        for r in rels:
            if (base / r / marker).exists():
                return base / r
    return HERE


BOOKS = None  # canonical order, loaded from KJV.json


def normalise(name):
    n = name.strip().lower()
    n = re.sub(r"^([1-3])\s+", lambda m: m.group(1) + " ", n)
    n = re.sub(r"^(i{1,3})\s+", lambda m: str(len(m.group(1))) + " ", n)
    n = re.sub(r"\b(psalm|psalms|ps)\b\.?", "psalm", n)
    n = re.sub(r"song of (songs|solomon)|canticles", "song of songs", n)
    n = re.sub(r"revelation( of (st\.? )?john)?|rev\b\.?", "revelation", n)
    n = re.sub(r"\s+", " ", n).strip(" .")
    return n


_CACHE = {}


def load_books(trans, directory):
    global BOOKS
    key = (trans, str(directory))
    if key in _CACHE:
        b, idx = _CACHE[key]
        if BOOKS is None:
            BOOKS = list(b)
        return b, idx
    path = directory / f"{trans}.json"
    if not path.exists():
        sys.exit(f"missing {path}")
    data = json.loads(path.read_text())["books"]
    if BOOKS is None:
        BOOKS = list(data)
    idx = {normalise(b): b for b in data}
    _CACHE[key] = (data, idx)
    return data, idx


REF = re.compile(
    r"@?\s*(?P<book>(?:[1-3]\s)?[A-Z][A-Za-z]+(?:\s+of\s+[A-Z][A-Za-z]+)?"
    r"(?:\s+[A-Z][a-z]+)*)?\s*"
    r"(?P<spec>(?:\d+\s*)?(?::\s*[\d ,\-–—abv]*)?[,\-\s\d]*)?"
)


def parse(ref, books_by_norm, last_book=None, data=None):
    """Yield (book, chapter, [verses]) tuples from one ';'-delimited chunk."""
    ref = re.sub(r"\([^)]*\)", " ", ref)          # drop '(last clause)' etc.
    ref = re.sub(r"\bas\b", " ", ref)             # typo in some sources
    out = []
    for chunk in ref.split(";"):
        chunk = chunk.strip().rstrip(",")
        if not chunk:
            continue
        m = re.match(r"@?\s*(?P<book>[A-Za-z1-3][A-Za-z .]*?)\s*(?=\d|:|$)", chunk)
        book = None
        if m:
            cand = normalise(m.group("book"))
            if cand in books_by_norm:
                book = books_by_norm[cand]
                chunk = chunk[m.end():]
        if book is None:
            book = last_book
            chunk = re.sub(r"^@", "", chunk).strip()
        if book is None:
            continue
        last_book = book
        out.extend(_spec(book, chunk, data is not None and len(data.get(book, {})) == 1))
    return out, last_book


def _spec(book, spec, single_chapter=False):
    """'15: 45 - 49' | '7 - 16, 19 - 21' | '1: 13 - 2: 10' | '3' (whole chapter)."""
    spec = spec.replace("\u2013", "-").replace("\u2014", "-")
    spec = re.sub(r"\bto\b", "-", spec)                    # '11: 1 to 13: 32'
    spec = re.sub(r"\band\b", ",", spec)                   # 'Genesis 11 and 12'
    spec = re.sub(r"l(?=\d)|(?<=\d)l", "1", spec)            # OCR l for 1
    spec = re.sub(r"[^0-9:,.-]", "", spec)
    spec = re.sub(r"(\d)\.(?=\d)", r"\1:", spec)            # OCR '26. 26' for '26: 26'
    spec = spec.strip(":,. -")
    if not spec:
        return []
    results, chapter = [], None
    for part in spec.split(","):
        m = re.fullmatch(r"(\d+)?(?::(\d+))?(?:-(?:(\d+):)?(\d+))?", part)
        if not m:
            continue
        c1, v1, c2, v2 = m.groups()
        if c1 is not None and ":" not in part and (single_chapter or chapter is not None):
            c1, v1 = None, c1            # bare number = verse within current chapter
            if chapter is None:
                chapter = 1
        elif c1 is not None:
            chapter = int(c1)
        if chapter is None:
            continue
        if m.group(3) is None and m.group(4) is None:      # single verse / chapter
            results.append((book, chapter, [int(v1)] if v1 else None))
            continue
        if m.group(3) is None:                             # same-chapter range
            start = int(v1) if v1 else 1
            results.append((book, chapter, list(range(start, int(m.group(4)) + 1))))
        else:                                              # cross-chapter range
            start = int(v1) if v1 else 1
            c2, v2 = int(m.group(3)), int(m.group(4))
            results.append((book, chapter, list(range(start, 999))))   # clipped below
            for c in range(chapter + 1, c2):
                results.append((book, c, None))
            results.append((book, c2, list(range(1, v2 + 1))))
    return results


def find_refs(text):
    """All '@'-marked references inside a free-text scriptures line."""
    return re.findall(r"@[^;@]*", text)


def expand(text, translation="KJV", directory=HERE):
    data, by_norm = load_books(translation, directory)
    refs = find_refs(text) if "@" in text else [text]
    verses, last = [], None
    for r in refs:
        parsed, last = parse(r, by_norm, last, data)
        for book, chapter, sel in parsed:
            ch = data.get(book, {}).get(str(chapter))
            if not ch:
                continue
            if sel is None:
                sel = [int(v) for v in ch]
            elif isinstance(sel, tuple):
                sel = [int(v) for v in ch if int(v) >= sel[1]]
            for v in sel:
                t = ch.get(str(v))
                if t:
                    verses.append({"ref": f"{book} {chapter}:{v}",
                                   "book": book, "chapter": chapter,
                                   "verse": v, "text": t})
    return verses


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("ref")
    ap.add_argument("--trans", default="KJV", choices=["KJV", "Darby"])
    ap.add_argument("--json", action="store_true")
    ap.add_argument("--dir", default=None, help="folder holding KJV.json / Darby.json (default: ../text/bible)")
    a = ap.parse_args()
    d = resolve_data_dir(a.dir, pathlib.Path("text") / "bible", f"{a.trans}.json")
    vs = expand(a.ref, a.trans, d)
    if a.json:
        print(json.dumps(vs, ensure_ascii=False, indent=1))
    else:
        for v in vs:
            print(f"{v['ref']}  {v['text']}")
    sys.exit(0 if vs else 1)


if __name__ == "__main__":
    main()
