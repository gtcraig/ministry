#!/usr/bin/env python3
"""Search and cite the hymn collection (456 hymns, EN/DE/IT/NL).

The hymns are referenced in the ministry text with a backtick and
`number:verse)` — e.g. (`272:4).  This tool resolves those references
and searches the full text.

  ./hymns.py --hymn 272                 full hymn, every language
  ./hymns.py --hymn 272 --lang en       full hymn, English only
  ./hymns.py --ref '`272:4)'            one verse (ref syntax accepted as-is)
  ./hymns.py --search 'love so amazing' verses containing every word
  ./hymns.py --search 'Vater' --lang de --json
  ./hymns.py --first-line 'of all the gifts'   find a hymn by opening line
  ./hymns.py --scan FILE...             list every `N:V reference in ministry text
  ./hymns.py --index [FILE]             write the markdown index
"""
import argparse, json, pathlib, re, sys, unicodedata

HERE = pathlib.Path(__file__).resolve().parent


def resolve_data_dir(explicit):
    """Find hymns.json: beside this script, in hymns/, text/hymns/, or up the tree.

    Handles both layouts: the repository (dev/text/hymns/hymns.json) and a
    flat Rool drive (/rool-drive/hymns/hymns.json)."""
    if explicit:
        return pathlib.Path(explicit)
    rel = (pathlib.Path("hymns"), pathlib.Path("text") / "hymns",
           pathlib.Path("dev") / "text" / "hymns", pathlib.Path("."))
    for base in (HERE, *HERE.parents):
        for r in rel:
            if (base / r / "hymns.json").exists():
                return base / r
    return HERE
LANGS = {"en": "", "de": "_de", "it": "_it", "nl": "_nl"}
LANG_NAMES = {"en": "English", "de": "German", "it": "Italian", "nl": "Dutch"}
_REF = re.compile(r"`\s*(\d{1,3})\s*:\s*(\d{1,2})")

_CACHE = {}


def load(directory=HERE):
    key = str(directory)
    if key in _CACHE:
        return _CACHE[key]
    path = pathlib.Path(directory) / "hymns.json"
    if not path.exists():
        sys.exit(f"missing {path}\n"
                 "Put hymns.json in hymns/ or text/hymns/ relative to this "
                 "script, or pass --data DIR.")
    blocks = json.loads(path.read_text(encoding="utf-8"))
    tables = {b["name"]: b.get("data", []) for b in blocks if b.get("type") == "table"}
    langs = sorted(
        {k[5:] for k in tables if k == "hymn" or re.fullmatch(r"hymn_[a-z]{2}", k)},
        key=lambda s: (s != "", s),
    )
    langs = ["" if x == "" else x.lstrip("_") for x in langs]
    langs = [("en" if l == "" else l) for l in langs]
    hymns = {l: {int(r["hymn_no"]): r for r in tables[f"hymn{LANGS[l]}"]} for l in langs}
    lines = {l: {} for l in langs}
    for l in langs:
        for r in tables[f"hymn_line{LANGS[l]}"]:
            lines[l].setdefault(int(r["hymn_no"]), {}).setdefault(
                int(r["vers_no"]), {}
            )[int(r["line_no"])] = r["line_text"]
    authors = {int(r["id"]): r for r in tables.get("authors", [])}
    scheme_cats = {int(r["id"]): r for r in tables.get("hymn_scheme_categories", [])}
    meters = {int(r["id"]): r for r in tables.get("hymn_meter", [])}
    usage = {}
    for r in tables.get("hymn_categories", []):
        c = scheme_cats.get(int(r["category_id"]))
        if not c:
            continue
        usage.setdefault(int(r["hymn_no"]), []).append(c)
    data = dict(langs=langs, hymns=hymns, lines=lines, authors=authors,
                scheme_cats=scheme_cats, meters=meters, usage=usage)
    _CACHE[key] = data
    return data


def norm(s):
    s = unicodedata.normalize("NFKD", s)
    s = "".join(c for c in s if not unicodedata.combining(c))
    s = s.replace("’", "'").replace("‘", "'").lower()
    return re.sub(r"[^a-z0-9' ]+", " ", s)


def verses(d, no, lang):
    raw = d["lines"].get(lang, {}).get(no, {})
    return [(v, [raw[v][k] for k in sorted(raw[v])]) for v in sorted(raw)]


def author_name(d, no, lang="en"):
    h = d["hymns"].get(lang, {}).get(no)
    if not h:
        return None
    a = d["authors"].get(int(h["author_id"])) if h.get("author_id") else None
    if not a:
        return None
    return a.get("fullname") or " ".join(
        x for x in (a.get("firstnames"), a.get("surname")) if x
    )


def usage(d, no):
    return [c["name"] for c in d["usage"].get(no, [])]


def hymn_obj(d, no, langs=None):
    langs = langs or d["langs"]
    out = {"hymn_no": no, "author": author_name(d, no), "categories": usage(d, no),
           "languages": {}}
    for l in langs:
        h = d["hymns"].get(l, {}).get(no)
        if not h:
            continue
        vs = verses(d, no, l)
        out["languages"][l] = {
            "language": LANG_NAMES.get(l, l),
            "meter": h.get("meter"),
            "verses": [{"vers_no": v, "lines": ls} for v, ls in vs],
            "first_line": vs[0][1][0] if vs else None,
        }
    return out


def print_hymn(d, no, langs):
    o = hymn_obj(d, no, langs)
    if not o["languages"]:
        sys.exit(f"no hymn {no}")
    print(f"Hymn {no}  —  {o['author'] or 'author unknown'}")
    if o["categories"]:
        print("  " + "; ".join(o["categories"]))
    for l, h in o["languages"].items():
        print(f"\n[{h['language']}]  {h['meter'] or ''}")
        for v in h["verses"]:
            for i, line in enumerate(v["lines"]):
                head = "Chorus  " if v["vers_no"] == 0 else f"{v['vers_no']}.  "
                print(head + line if i == 0 else f"    {line}")


def print_ref(d, no, vers, langs):
    found = False
    for l in langs:
        h = d["lines"].get(l, {}).get(no, {}).get(vers)
        if not h:
            continue
        found = True
        print(f"{no}:{vers} [{LANG_NAMES.get(l, l)}]")
        for i in sorted(h):
            print(f"  {h[i]}")
    if not found:
        sys.exit(f"no verse {vers} of hymn {no}")


def search(d, query, langs, limit, regex=False):
    words = [norm(w) for w in query.split()]
    words = [w for w in words if w]
    hits = []
    for l in langs:
        for no in sorted(d["lines"].get(l, {})):
            for v, ls in verses(d, no, l):
                text = " ".join(ls)
                hay = norm(text)
                if regex:
                    ok = bool(re.search(query, text, re.I))
                else:
                    ok = all(w in hay for w in words)
                if ok:
                    hits.append({"hymn_no": no, "vers_no": v, "lang": l,
                                 "lang_name": LANG_NAMES.get(l, l), "lines": ls,
                                 "author": author_name(d, no),
                                 "first_line": verses(d, no, l)[0][1][0]})
                    if limit and len(hits) >= limit:
                        return hits
    return hits


def scan(paths):
    refs = []
    for p in paths:
        text = pathlib.Path(p).read_text(encoding="utf-8", errors="replace")
        for m in _REF.finditer(text):
            refs.append((p, int(m.group(1)), int(m.group(2)), m.group(0)))
    return refs


def index_md(d):
    out = ["# Hymns Index", "",
           "456 hymns (English text), with German, Italian and Dutch translations.",
           "Generated from `hymns.json` by `hymns.py --index`. Reference format in the",
           "ministry text is a backtick then `number:verse)`, e.g. (`272:4).", "",
           "| No. | First line | Author | Metre | Categories |", "|---:|---|---|---|---|"]
    for no in sorted(d["hymns"]["en"]):
        h = hymn_obj(d, no, ["en"])["languages"].get("en", {})
        fl = (h.get("first_line") or "").replace("|", "\\|")
        cats = "; ".join(usage(d, no)).replace("|", "\\|")
        out.append(f"| {no} | {fl} | {author_name(d, no) or ''} | {h.get('meter') or ''} | {cats} |")
    return "\n".join(out) + "\n"


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    g = ap.add_mutually_exclusive_group(required=True)
    g.add_argument("--hymn", type=int)
    g.add_argument("--ref", help="'`272:4)' or '272:4'")
    g.add_argument("--search")
    g.add_argument("--first-line")
    g.add_argument("--scan", nargs="+", metavar="FILE")
    g.add_argument("--index", nargs="?", const="-", metavar="FILE")
    ap.add_argument("--lang", default="all", help="all, en, de, it, nl (comma separated)")
    ap.add_argument("--regex", action="store_true", help="treat --search as a regex")
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--json", action="store_true")
    ap.add_argument("--dir", default=None, help="folder holding hymns.json (default: ../hymns)")
    a = ap.parse_args()
    a.dir = str(resolve_data_dir(a.dir))

    d = load(a.dir)
    langs = d["langs"] if a.lang == "all" else [l.strip() for l in a.lang.split(",")]

    if a.hymn is not None:
        if a.json:
            print(json.dumps(hymn_obj(d, a.hymn, langs), ensure_ascii=False, indent=1))
        else:
            print_hymn(d, a.hymn, langs)
        return

    if a.ref:
        m = _REF.search(a.ref) or re.fullmatch(r"\s*(\d{1,3})\s*:\s*(\d{1,2})\s*", a.ref)
        if not m:
            sys.exit("expected a reference like 272:4")
        no, v = int(m.group(1)), int(m.group(2))
        if a.json:
            print(json.dumps({"hymn_no": no, "vers_no": v, "texts": {
                l: d["lines"].get(l, {}).get(no, {}).get(v) for l in langs}}))
        else:
            print_ref(d, no, v, langs)
        return

    if a.search:
        hits = search(d, a.search, langs, a.limit, a.regex)
        if a.json:
            print(json.dumps(hits, ensure_ascii=False, indent=1))
        else:
            for h in hits:
                print(f"{h['hymn_no']}:{h['vers_no']}  [{h['lang_name']}]  {h['first_line']}")
                for line in h["lines"]:
                    print(f"    {line}")
                print()
            if not a.json:
                print(f"{len(hits)} verse(s)", file=sys.stderr)
        return

    if a.first_line:
        q = norm(a.first_line)
        hits = [no for no in sorted(d["lines"]["en"])
                if q in norm(verses(d, no, "en")[0][1][0] if verses(d, no, "en") else "")]
        for no in hits:
            print(f"{no}  {verses(d, no, 'en')[0][1][0]}  —  {author_name(d, no)}")
        if not hits:
            sys.exit("no match")

    if a.scan:
        refs = scan(a.scan)
        bad = []
        for p, no, v, raw in refs:
            ok = any(v in d["lines"].get(l, {}).get(no, {}) for l in d["langs"])
            print(f"{p}: hymn {no}:{v}" + ("" if ok else "   [UNRESOLVED]"))
            if not ok:
                bad.append((p, no, v))
        print(f"{len(refs)} reference(s), {len(bad)} unresolved", file=sys.stderr)
        sys.exit(1 if bad else 0)

    if a.index:
        md = index_md(d)
        if a.index == "-":
            print(md)
        else:
            pathlib.Path(a.index).write_text(md, encoding="utf-8")
            print(f"wrote {a.index}", file=sys.stderr)


if __name__ == "__main__":
    main()
