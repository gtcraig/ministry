#!/usr/bin/env python3
"""Rebuild text/ministry/index.json and Index.md from the ministry text files.

  python3 build_index.py                 # rebuild both files in place
  python3 build_index.py --check         # report what would change; write nothing
  python3 build_index.py --dir PATH      # a ministry folder other than ../../../text/ministry

Reads every <writer>/<file>.txt one level below the ministry folder (so
dm/symbols/notes.txt is not indexed), plus two small data files that live
beside the texts:

  authors.json        writer folder -> name (the Index.md headings and the
                      "author" field). Edit this to correct or add a writer.
  volume_titles.json  fallback titles for files with no {#...} line, taken
                      from mse_volume in the goodteaching database.

The rules are those of the goodteaching parser (software/MseBuilder,
Engine/MseParser.cs and Abstract/Paragraph.cs), so the index lists the
articles the site itself will find:

  * blank lines are ignored; {N} is a page; {#...} is the volume title;
  * $NAME starts an article group and the next two lines (| City | Date, and
    a summary) belong to it;
  * otherwise speaker initials are removed (MseParser.GetInitials), then a
    line beginning % is a sub-title, and a line that is more than 70%
    upper case (IsTitle: A-Z against a-z and full stops, no < or >) is an
    article title;
  * a line beginning @ straight after a title is that article's Scriptures;
  * an article belongs to a group when its title begins with the group name
    (ArticleGroupCollection.Add).

Stdlib only. Python 3.8 or later.
"""
import argparse, json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
DEFAULT_DIR = os.path.normpath(os.path.join(HERE, "..", "..", "..", "text", "ministry"))

CONST_INITS = ("Rem.", "Ques.", "*Rem*.", "*Ques*.")


def read_text(path):
    b = open(path, "rb").read()
    if b.startswith(b"\xef\xbb\xbf"):
        return b[3:].decode("utf-8")
    try:
        return b.decode("utf-8")
    except UnicodeDecodeError:
        return b.decode("cp1252")


def strip_title(text):
    """Article.GetTitle: drop <sup>..</sup> and broken-bar footnote markers."""
    text = re.sub(r"<sup>.*?</sup>", "", text)
    return text.replace("¦", "")


def is_title(text):
    text = strip_title(text).replace("...", "")
    up = lo = html = other = 0
    for ch in text:
        c = ord(ch)
        if 65 <= c <= 90:
            up += 1
        elif 97 <= c <= 122:
            lo += 1
        elif c in (60, 62):
            html += 1
        elif c == 46:
            other += 1
    return up + lo > 0 and html == 0 and up / (up + lo + other) > 0.7


def initials_end(text):
    """MseParser.GetInitials: index where the initials end, or 0."""
    if len(text) <= 3:
        return 0
    if len(text) <= 25 and text[-1] != ".":
        return 0
    start = 1 if text.startswith(".") else 0
    for s in CONST_INITS:
        if len(text) > len(s) and text[start:start + len(s)] == s:
            return len(s)
    halt = inits = upper = False
    dots = 0
    i = start
    while i < len(text) and not halt and i < 11:
        c = text[i]
        if c == ".":
            dots += 1
        elif c == " ":
            halt = True
            if dots > 1 or (dots == 1 and i == 2):
                inits = True
        elif "A" <= c <= "Z":
            upper = True
        elif ("a" <= c <= "z") or c in "'-":
            pass
        else:
            halt = True
        i += 1
    if inits and upper and i > 0 and not text[:i].strip().startswith(".."):
        return i
    return 0


def parse(path, rel):
    lines = read_text(path).replace("\r\n", "\n").replace("\r", "\n").split("\n")
    vol = {"volume_title": "", "pages": 0, "article_groups": [], "articles": []}
    groups = []
    prev_title = False
    i = 0
    while i < len(lines):
        raw = lines[i]
        row = i + 1
        i += 1
        buf = raw.strip()
        if prev_title and buf.startswith("@") and vol["articles"]:
            vol["articles"][-1]["scripture"] = buf
        if not buf:
            continue
        if buf.startswith("{#"):
            if not vol["volume_title"]:
                vol["volume_title"] = buf[2:].rstrip("}").strip()
            continue
        if buf.startswith("{"):
            m = re.match(r"\{(\d+)\}", buf)
            if m:
                vol["pages"] = max(vol["pages"], int(m.group(1)))
            continue
        if buf.startswith("$") and len(buf) > 1:
            name = buf[1:].strip()
            where = lines[i].strip() if i < len(lines) else ""
            summary = lines[i + 1].strip() if i + 1 < len(lines) else ""
            i += 2
            groups.append(name)
            g = {"name": name, "where": where, "file": rel, "line": row}
            if summary:
                g["summary"] = summary
            vol["article_groups"].append(g)
            prev_title = False
            continue
        e = initials_end(buf)
        text = buf[e:].strip() if e else buf
        prev_title = False
        if text.startswith("%"):
            continue                      # sub-title
        if is_title(text):
            title = strip_title(text).strip()
            group = ""
            for g in groups:              # last matching group wins, as in the parser
                if title.startswith(g):
                    group = g
            vol["articles"].append({"title": title, "file": rel, "group": group,
                                    "line": row, "scripture": ""})
            prev_title = True
    return vol


def build(base):
    authors = json.load(open(os.path.join(base, "authors.json"), encoding="utf-8"))
    vt_path = os.path.join(base, "volume_titles.json")
    fallback = json.load(open(vt_path, encoding="utf-8")) if os.path.exists(vt_path) else {}
    index = {}
    for folder in sorted(os.listdir(base)):
        d = os.path.join(base, folder)
        if not os.path.isdir(d) or folder.startswith("."):
            continue
        for fn in sorted(os.listdir(d)):
            if not fn.lower().endswith(".txt"):
                continue
            rel = folder + "/" + fn
            v = parse(os.path.join(d, fn), rel)
            if not v["volume_title"] and rel in fallback:
                v["volume_title"] = fallback[rel]
                v["volume_title_source"] = "database"
            a = authors.get(folder, {})
            out = {"volume_title": v["volume_title"]}
            if v.get("volume_title_source"):
                out["volume_title_source"] = v["volume_title_source"]
            out.update({"author": a.get("name", ""), "pages": v["pages"],
                        "article_groups": v["article_groups"], "articles": v["articles"]})
            index[rel] = out
    return dict(sorted(index.items())), authors


def index_md(index, authors):
    out = ["# Ministry Texts — Index", "",
           "Source: github.com/gtcraig/ministry, dev/text/ministry. Format per README.md:", "",
           "- `{N}` page numbers · `{#...}` volume title · `$GROUP NAME` article groups (next `| City | Date` line)",
           "- Uppercase lines (>70% upper) are article titles; next line = Scriptures read",
           "- `@` Bible refs · `*italic*` · `~` possessive apostrophe · `` ` `` hymn refs · `¦`/`<sup>` footnotes",
           "", "Generated by `rool/instructions/scripts/build_index.py`; writer names from `authors.json`.", ""]
    by = {}
    for rel, v in index.items():
        by.setdefault(rel.split("/")[0], []).append((rel, v))
    for folder in sorted(by):
        vols = by[folder]
        a = authors.get(folder, {})
        name = a.get("name") or (folder.upper() + " (?)")
        n = sum(len(v["articles"]) for _, v in vols)
        out += ["", "## %s — %s" % (folder, name), "", "%d files, %d articles" % (len(vols), n), ""]
        for rel, v in vols:
            title = v["volume_title"] or rel.split("/")[1]
            out.append("- **%s** (%d articles, ~%d pp.) — `%s`" % (title, len(v["articles"]), v["pages"], rel))
    return "\r\n".join(out) + "\r\n"


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--dir", default=DEFAULT_DIR)
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    base = args.dir
    index, authors = build(base)
    js = json.dumps(index, indent=1, ensure_ascii=False) + "\n"
    md = index_md(index, authors)
    old = {}
    p = os.path.join(base, "index.json")
    if os.path.exists(p):
        old = json.load(open(p, encoding="utf-8"))
    added = sorted(set(index) - set(old))
    removed = sorted(set(old) - set(index))
    changed = [k for k in index if k in old and
               [(a["title"], a["line"]) for a in index[k]["articles"]] !=
               [(a["title"], a["line"]) for a in old[k]["articles"]]]
    arts = sum(len(v["articles"]) for v in index.values())
    print("%d volumes, %d articles, %d groups" % (len(index), arts, sum(len(v["article_groups"]) for v in index.values())))
    print("added %d, removed %d, article list changed in %d" % (len(added), len(removed), len(changed)))
    for k in added:
        print("  + %s" % k)
    for k in removed:
        print("  - %s" % k)
    for k in changed:
        print("  ~ %s (%d -> %d articles)" % (k, len(old[k]["articles"]), len(index[k]["articles"])))
    missing = sorted({k.split("/")[0] for k in index} - set(authors))
    if missing:
        print("writers with no entry in authors.json: " + ", ".join(missing))
    untitled = [k for k, v in index.items() if not v["volume_title"]]
    if untitled:
        print("volumes with no title: " + ", ".join(untitled))
    if args.check:
        return
    with open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(js)
    with open(os.path.join(base, "Index.md"), "w", encoding="utf-8", newline="") as f:
        f.write(md)
    print("wrote index.json and Index.md")


if __name__ == "__main__":
    main()
