#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Build JSON versions of the magazines "A Word in its Season" (AWIIS, 1st and
2nd Series) and "Notes of Ministry" (NOM) from the calibre library.

Reads calibre's metadata.db directly (read-only) to find every issue in the
three magazine series, opens each issue's EPUB (or DOCX where there is no
EPUB), splits it into articles and writes one JSON file per issue to
dev/text/magazines (relative to this script in dev/scripts):

    awiis/awiis1-296.json      A Word in its Season, 1st Series, No. 296
    awiis/awiis2-059.json      A Word in its Season, 2nd Series, No. 59
    nom/nom-108.json           Notes of Ministry, No. 108

"Key to Initials" / "List of Initials" sections, which in the EPUBs are
separate headings, are parsed and merged into the article before them.

Only the Python standard library is used.  See README.md for the JSON format.

Usage:
    python build_magazines.py                 # build issues with no JSON yet
    python build_magazines.py --all           # rebuild every issue
    python build_magazines.py --changed       # also rebuild issues whose source file is newer
    python build_magazines.py --ids 458 2537  # rebuild specific calibre book ids
    python build_magazines.py --library "D:\\Calibre Library"
"""

import argparse
import datetime
import html
import json
import os
import posixpath
import re
import sqlite3
import sys
import zipfile
import xml.etree.ElementTree as ET
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote

SCHEMA_VERSION = 1

# calibre series id -> (folder/code, series number within magazine, magazine name)
SERIES = {
    1: ('awiis', 1, 'A Word in its Season'),
    4: ('awiis', 2, 'A Word in its Season'),
    2: ('nom', None, 'Notes of Ministry'),
}

DEFAULT_LIBRARY = Path.home() / 'Calibre Library'
# this script lives in dev/scripts; the JSON goes to dev/text/magazines
OUT_DIR = Path(__file__).resolve().parent.parent / 'text' / 'magazines'

# --------------------------------------------------------------------------
# Text helpers
# --------------------------------------------------------------------------

def clean(s):
    """Normalise whitespace within lines; keep explicit line breaks."""
    s = s.replace('\xa0', ' ').replace('\u200b', '').replace('\r', '')
    lines = [re.sub(r'[ \t\f\v]+', ' ', ln).strip() for ln in s.split('\n')]
    return '\n'.join(ln for ln in lines if ln)


def flat(s):
    return re.sub(r'\s+', ' ', s or '').strip()


def letters(s):
    return re.sub(r'[^a-z0-9]', '', (s or '').lower())


INITIALS_TITLE = re.compile(r'^\W*(key\s*to\s*)?(list\s*of\s*)?initials\b', re.I)
CONTENTS_TITLE = re.compile(r'^\W*(table\s+of\s+)?contents\W*$', re.I)

MONTHS = ('January|February|March|April|May|June|July|August|September|'
          'October|November|December|Jan|Feb|Mar|Apr|Jun|Jul|Aug|Sept|Sep|Oct|Nov|Dec')
DATE_RE = re.compile(
    r'^(?:(?:\d{1,2}(?:st|nd|rd|th)?\s+)?(?:' + MONTHS + r')\.?,?\s+\d{4}'
    r'|\d{1,2}[/.-]\d{1,2}[/.-]\d{2,4}|(?:19|20)\d{2})\.?$', re.I)

BOOKS = """Genesis Gen Exodus Exod Ex Leviticus Lev Numbers Num Deuteronomy Deut
Joshua Josh Judges Judg Ruth Samuel Sam Kings Kgs Chronicles Chron Ezra Nehemiah Neh
Esther Esth Job Psalm Psalms Ps Psa Proverbs Prov Ecclesiastes Eccl Eccles Song Isaiah Isa
Jeremiah Jer Lamentations Lam Ezekiel Ezek Daniel Dan Hosea Hos Joel Amos Obadiah Obad
Jonah Micah Mic Nahum Nah Habakkuk Hab Zephaniah Zeph Haggai Hag Zechariah Zech Malachi Mal
Matthew Matt Mark Luke John Acts Romans Rom Corinthians Cor Galatians Gal Ephesians Eph
Philippians Phil Colossians Col Thessalonians Thess Timothy Tim Titus Philemon Philem
Hebrews Heb James Jas Peter Pet Jude Revelation Rev""".split()
SCRIPTURE_RE = re.compile(
    r'^(?:[123I]{1,3}\s*)?(?:' + '|'.join(sorted(BOOKS, key=len, reverse=True)) +
    r')(?:\s+of\s+Songs|\s+of\s+Solomon)?\.?\s*\d', re.I)

COMMON_CAPS = {'I', 'A', 'O', 'GOD', 'LORD', 'THE', 'AND', 'OF', 'TO', 'IN', 'IS',
               'HE', 'HIS', 'HIM', 'WE', 'US', 'MY', 'ME', 'BE', 'SO', 'NO', 'AN',
               'AS', 'AT', 'BY', 'IF', 'IT', 'OR', 'ON', 'OH', 'YE', 'ALL', 'NOT',
               'BUT', 'FOR', 'YOU', 'JESUS', 'CHRIST', 'NOTE', 'NB', 'AV', 'JND',
               'KJV', 'OK', 'UK', 'USA'}
SPEAKER_LABELS = ('Rem.', 'Ques.', 'Quest.', 'Q.', 'A.')
SPEAKER_RE = re.compile(r'^((?:[A-Z][a-z]{0,2}\.?\s?){1,5}?[A-Z][a-z]{0,2}\.?|(?:[A-Z]\.){1,5})(?=\s+\S|$)')


def speaker_token(text, known):
    """Return (speaker, rest) if the paragraph starts with speaker initials."""
    for lab in SPEAKER_LABELS:
        if text.startswith(lab + ' ') or text == lab:
            return lab, text[len(lab):].strip()
    m = SPEAKER_RE.match(text)
    if not m:
        return None, text
    tok = m.group(1).strip()
    key = tok.replace('.', '').replace(' ', '')
    if not (2 <= len(key) <= 6) or key.upper() in COMMON_CAPS:
        return None, text
    has_dots = '.' in tok
    rest = text[m.end():].strip()
    first = rest.split()[0] if rest else ''
    # the next word must start a sentence, and must not itself be in capitals
    # (that would be a heading such as "WITH CHRIST")
    if rest and not (rest[0].isupper() or rest[0] in '“"‘\'(….0123456789-–—'):
        return None, text
    if re.fullmatch(r'[A-Z][A-Z’\'-]+[,.;:]?', first):
        return None, text
    if known and not has_dots and key not in known:
        return None, text
    if key in known or (has_dots and re.fullmatch(r'(?:[A-Z][a-z]{0,2}\.\s?)+', tok)) \
            or (key.isupper() and not has_dots and ' ' not in tok):
        return tok.rstrip(), rest
    return None, text


def derive_initials(name):
    parts = re.findall(r"[A-Za-z][A-Za-z'’-]*", name)
    out = ''
    for p in parts:
        if p[0].isupper():
            out += p[0]
    return out


def parse_initials_key(lines):
    """Parse 'R M Brown, East Finchley; D A Burr, London; ...' into entries."""
    text = ' '.join(lines)
    text = re.sub(r'\s+', ' ', text).strip()
    chunks = [c.strip(' .') for c in re.split(r';|\n', text) if c.strip(' .')]
    if len(chunks) <= 1:
        chunks = [c.strip(' .') for c in lines if c.strip(' .')]
    entries = []
    for ch in chunks:
        ini = None
        m = re.match(r'^((?:[A-Z]\.?\s?){1,6})\s*[-–—:=]\s*(.+)$', ch)
        if m and len(m.group(1).replace('.', '').replace(' ', '')) <= 6 and ' ' in m.group(2):
            ini = m.group(1).replace('.', '').replace(' ', '')
            ch = m.group(2).strip()
        name, _, place = ch.partition(',')
        e = {'initials': ini or derive_initials(name), 'name': name.strip()}
        if place.strip():
            e['place'] = place.strip()
        entries.append(e)
    return entries

# --------------------------------------------------------------------------
# EPUB / DOCX to a flat list of blocks
# --------------------------------------------------------------------------

BLOCK_TAGS = {'p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'li', 'div', 'blockquote',
              'pre', 'td', 'th', 'dt', 'dd', 'table', 'tr', 'ul', 'ol', 'body', 'section'}
SKIP_TAGS = {'head', 'script', 'style', 'title'}


class Flattener(HTMLParser):
    def __init__(self, fname, blocks, anchors):
        super().__init__(convert_charrefs=True)
        self.fname, self.blocks, self.anchors = fname, blocks, anchors
        self.buf, self.skip, self.stack = [], 0, []

    def flush(self):
        t = clean(''.join(self.buf))
        self.buf = []
        if t:
            tag = next((x for x in reversed(self.stack) if re.fullmatch(r'h[1-6]', x)), None) \
                or (self.stack[-1] if self.stack else 'p')
            self.blocks.append({'tag': tag, 'text': t, 'file': self.fname})

    def handle_starttag(self, tag, attrs):
        if tag in SKIP_TAGS:
            self.skip += 1
            return
        a = dict(attrs)
        for k in ('id', 'name'):
            if a.get(k):
                self.anchors.setdefault((self.fname, a[k]), len(self.blocks) + (1 if self.buf and clean(''.join(self.buf)) else 0))
        if tag == 'br':
            self.buf.append('\n')
        elif tag in BLOCK_TAGS:
            self.flush()
            self.stack.append(tag)

    def handle_startendtag(self, tag, attrs):
        self.handle_starttag(tag, attrs)
        if tag in BLOCK_TAGS and tag != 'br':
            self.handle_endtag(tag)

    def handle_endtag(self, tag):
        if tag in SKIP_TAGS:
            self.skip = max(0, self.skip - 1)
            return
        if tag in BLOCK_TAGS:
            self.flush()
            if tag in self.stack:
                while self.stack and self.stack.pop() != tag:
                    pass

    def handle_data(self, data):
        if not self.skip:
            self.buf.append(data.replace('\n', ' '))

    def close(self):
        super().close()
        self.flush()


def read_epub(path):
    z = zipfile.ZipFile(path)
    names = z.namelist()
    cont = z.read('META-INF/container.xml').decode('utf-8', 'replace')
    opf_path = re.search(r'full-path="([^"]+)"', cont).group(1)
    opf_dir = posixpath.dirname(opf_path)
    opf = ET.fromstring(z.read(opf_path))
    ns = {'o': 'http://www.idpf.org/2007/opf'}
    manifest = {}
    nav_href = ncx_href = None
    for it in opf.iterfind('.//o:manifest/o:item', ns):
        href = posixpath.normpath(posixpath.join(opf_dir, unquote(it.get('href'))))
        manifest[it.get('id')] = href
        if 'nav' in (it.get('properties') or '').split():
            nav_href = href
        if it.get('media-type') == 'application/x-dtbncx+xml':
            ncx_href = href
    spine = [manifest[r.get('idref')] for r in opf.iterfind('.//o:spine/o:itemref', ns)
             if r.get('idref') in manifest]
    blocks, anchors, file_start = [], {}, {}
    for f in spine:
        if f not in names or 'titlepage' in f.lower() or (nav_href and f == nav_href):
            continue
        file_start[f] = len(blocks)
        p = Flattener(f, blocks, anchors)
        p.feed(z.read(f).decode('utf-8', 'replace'))
        p.close()

    toc = []
    if ncx_href and ncx_href in names:
        N = '{http://www.daisy.org/z3986/2005/ncx/}'
        root = ET.fromstring(z.read(ncx_href))
        base = posixpath.dirname(ncx_href)
        for np_ in root.iter(N + 'navPoint'):
            if np_.find(N + 'navPoint') is not None:
                continue  # parent entry (e.g. the issue title) - use its children
            lab = flat(''.join(np_.find(N + 'navLabel').itertext()))
            toc.append((lab, base, np_.find(N + 'content').get('src')))
    elif nav_href and nav_href in names:
        X = '{http://www.w3.org/1999/xhtml}'
        root = ET.fromstring(z.read(nav_href))
        base = posixpath.dirname(nav_href)
        navs = [n for n in root.iter(X + 'nav')
                if 'toc' in (n.get('{http://www.idpf.org/2007/ops}type') or '')] or list(root.iter(X + 'nav'))
        if navs:
            for li in navs[0].iter(X + 'li'):
                if li.find('.//' + X + 'li') is not None:
                    continue
                a = li.find('.//' + X + 'a')
                if a is not None and a.get('href'):
                    toc.append((flat(''.join(a.itertext())), base, a.get('href')))

    entries = []
    for lab, base, src in toc:
        f, _, frag = unquote(src).partition('#')
        f = posixpath.normpath(posixpath.join(base, f))
        if f not in file_start:
            continue
        idx = anchors.get((f, frag), file_start[f]) if frag else file_start[f]
        entries.append((idx, lab))
    return blocks, entries


def read_docx(path):
    z = zipfile.ZipFile(path)
    W = '{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'
    root = ET.fromstring(z.read('word/document.xml'))
    blocks, entries = [], []
    for p in root.iter(W + 'p'):
        style = p.find(f'{W}pPr/{W}pStyle')
        style = style.get(W + 'val') if style is not None else ''
        parts = []
        for el in p.iter():
            if el.tag == W + 't':
                parts.append(el.text or '')
            elif el.tag == W + 'tab':
                parts.append(' ')
            elif el.tag in (W + 'br', W + 'cr'):
                parts.append('\n')
        t = clean(''.join(parts))
        if not t:
            continue
        heading = re.fullmatch(r'(?i)heading\s*1|title', style or '')
        if heading:
            entries.append((len(blocks), flat(t)))
        blocks.append({'tag': 'h1' if heading else 'p', 'text': t, 'file': 'document.xml', 'style': style})
    return blocks, entries

# --------------------------------------------------------------------------
# Blocks to articles
# --------------------------------------------------------------------------

def split_articles(blocks, entries):
    entries = [(i, lab) for i, lab in entries if not CONTENTS_TITLE.match(lab) and i < len(blocks)]
    method = 'toc'
    if len(entries) < 1 or (len(entries) == 1 and sum(b['tag'] == 'h1' for b in blocks) > 1):
        entries = [(i, flat(b['text'])) for i, b in enumerate(blocks)
                   if b['tag'] == 'h1' and not CONTENTS_TITLE.match(b['text'])]
        method = 'h1'
    if not entries:
        return [], 'none'
    # Some TOCs miss the first article(s).  If there is real text before the
    # first TOC entry, start articles there too: at any h1 headings, or else
    # at the title line just above the first substantial paragraph.
    first = min(i for i, _ in entries)
    if sum(len(b['text'].split()) for b in blocks[:first]) > 300:
        extra = [(i, flat(b['text'])) for i, b in enumerate(blocks[:first])
                 if b['tag'] == 'h1' and not CONTENTS_TITLE.match(b['text'])]
        if not extra:
            body = next((i for i, b in enumerate(blocks[:first]) if len(b['text'].split()) > 40), None)
            if body is not None:
                # walk back over author / scripture lines to the title (all caps)
                start = body
                for k in range(body - 1, max(-1, body - 6), -1):
                    t = flat(blocks[k]['text'])
                    if t and t.upper() == t and re.search(r'[A-Z]{3}', t) and not CONTENTS_TITLE.match(t):
                        start = k
                        break
                extra = [(start, flat(blocks[start]['text']))]
        entries = extra + entries
        method += '+front'
    # one entry per start position, in document order
    seen, uniq = set(), []
    for i, lab in sorted(entries, key=lambda e: e[0]):
        if i in seen:
            continue
        seen.add(i)
        uniq.append((i, lab))
    arts = []
    for k, (i, lab) in enumerate(uniq):
        j = uniq[k + 1][0] if k + 1 < len(uniq) else len(blocks)
        arts.append({'title': lab, 'blocks': blocks[i:j]})
    return arts, method


def strip_title(title, blks):
    """Remove the title line(s) from the start of an article's blocks."""
    target = letters(title)
    acc, n = '', 0
    for b in blks[:4]:
        acc += letters(b['text'])
        n += 1
        if acc == target or (b['tag'].startswith('h') and target.startswith(acc) and len(acc) > 2):
            if acc == target:
                return blks[n:]
            continue
        break
    if blks and blks[0]['tag'].startswith('h') and letters(blks[0]['text']) and \
            (letters(blks[0]['text']) in target or target in letters(blks[0]['text'])):
        return blks[1:]
    return blks


def looks_like_name(s):
    s = s.strip()
    if len(s) > 60 or len(s) < 3 or SCRIPTURE_RE.match(s) or DATE_RE.match(s):
        return False
    if re.search(r'[:;!?“”"]', s) or s.endswith('.') and not re.search(r'\b[A-Z]\.$', s):
        return False
    words = s.replace('.', '. ').split()
    if not (1 <= len(words) <= 7):
        return False
    caps = sum(1 for w in words if w[0].isupper() or w in ('de', 'van', 'von', 'of'))
    return caps == len(words)


SCRIPTURE_CONT = re.compile(r'^[\d(][\d\s;:,.–—\-()a-z‘’“”\'"]*$|^\(.*\)$')
LABEL_LINE = re.compile(r'^\(?(?:address|reading|word|extracts?|notes?|poem|hymn|letter|'
                        r'gospel|preaching|meeting)\b.{0,50}\)?$', re.I)
BACK_RE = re.compile(r'(?i)^(?:edited|published|printed|copies|obtainable|available|price|'
                     r'subscriptions?|tel\b|telephone|e-?mail|www\.)|'
                     r'\b[A-Z]{1,2}\d[A-Z\d]?\s*\d[A-Z]{2}\b|\b\d+\s+\w+\s+(?:road|street|avenue|lane|drive)\b')
ATTRIB_RE = re.compile(r'^[-–—]?\s*(?:(?:[A-Z]\.\s?){1,4}\s*)?(?:[A-Z][\w’\'-]+\s*){1,3}'
                       r'\((?=.*(?i:vol|p\.|pp\.|page|coll|letters|notes|ministry|\d)).*\)\.?$')
# "Address at Redbridge 2 September 1988", "Word in meeting for ministry, Grangemouth 28 April 1981"
TRAIL_DATE_RE = re.compile(
    r'^(?P<loc>.*?)[,.]?\s+(?P<date>(?:\d{1,2}(?:st|nd|rd|th)?\s+)?(?:' + MONTHS +
    r')\.?,?\s+\d{4})\.?$', re.I)


LOC_ONLY_RE = re.compile(r'^(?:address|addresses|lecture|word|words|reading|readings|ministry|'
                         r'gospel|preaching|meeting|remarks|notes)\b[^.!?]{0,60}\b(?:at|in)\s+[A-Z][^.!?]*$',
                         re.I)


def is_servant(s):
    """'J. Renton', 'J.C.Evershed', 'Jim T Brown (Edinburgh)'."""
    bare = re.sub(r'\s*\(.*?\)\s*$', '', s)
    if re.search(r'(?i)hymn|sake|amen', bare):
        return False
    return looks_like_name(bare) and len([w for w in re.split(r'[.\s]+', bare) if w]) >= 2


def split_lines(texts):
    out = []
    for t in texts:
        out.extend(x for x in t.split('\n') if x.strip())
    return out


def set_location(art, loc):
    """'Reading, Glasgow' / 'Address at Redbridge' / 'Aberdeen' -> meeting + place."""
    loc = loc.strip(' ,')
    if not loc or loc.startswith('('):
        return
    loc2 = re.sub(r'(?<=[a-z])\.\s+(?=[A-Z])', ', ', loc)   # "Ministry. Redbridge"
    at_in = re.match(r'^(?P<m>.*?)\s+(?:at|in)\s+(?P<p>[A-Z].*)$', loc2)
    meeting, sep, place = loc2.rpartition(',')
    if sep and len(place.strip(' .')) <= 4:
        # "Address in Auckland, N.Z." - the country belongs to the place
        if at_in:
            art['meeting'], art['place'] = at_in.group('m').strip(' ,'), at_in.group('p').strip()
        else:
            art['place'] = loc2
    elif sep and meeting.strip():
        art['meeting'], art['place'] = meeting.strip(), place.strip()
    elif at_in and at_in.group('m'):
        art['meeting'], art['place'] = at_in.group('m').strip(' ,'), at_in.group('p').strip()
    else:
        art['place'] = loc2


def build_article(title, blks):
    blks = strip_title(title, blks)
    lines = [b['text'] for b in blks]
    art = {'title': title}

    # --- in-body "Key to initials:" (not a separate heading) ---------------
    for k, t in enumerate(lines):
        if INITIALS_TITLE.match(flat(t)) and len(flat(t)) < 40:
            key_lines = lines[k + 1:]
            # stop the key at anything that is clearly not part of it
            stop = next((n for n, x in enumerate(key_lines) if len(flat(x)) > 60 and ';' not in x
                         and ',' not in x), len(key_lines))
            art['initials'] = parse_initials_key(key_lines[:stop])
            art['initials_heading'] = flat(t)
            art['initials_text'] = key_lines[:stop]
            lines = lines[:k] + key_lines[stop:]
            break

    # --- preamble: author / scriptures / short notes before the body --------
    # split only the first few blocks on line breaks (scriptures are often
    # several lines in one paragraph)
    head = []
    while lines and len(head) < 12 and len(flat(lines[0])) <= 160:
        head.append(lines.pop(0))
    head = split_lines(head)
    author, scriptures, notes, used = None, [], [], 0
    for s in map(flat, head):
        bare = re.sub(r'\s*\(.*?\)\s*$', '', s)
        if SCRIPTURE_RE.match(s):
            scriptures.append(s)
        elif scriptures and SCRIPTURE_CONT.match(s) and len(s) < 80:
            scriptures[-1] += ' ' + s
        elif scriptures and scriptures[-1].rstrip().endswith((':', ';', ',', '–', '-')) and len(s) < 60:
            scriptures[-1] += ' ' + s
        elif author is None and not scriptures and is_servant(s):
            author = s
        elif LABEL_LINE.match(s) and len(s) < 60:
            notes.append(s)
        else:
            break
        used += 1
    lines = head[used:] + lines
    if author:
        art['author'] = author
    if scriptures:
        art['scriptures'] = [re.sub(r'\s+', ' ', s).strip() for s in scriptures]
    if notes:
        art['notes'] = notes

    # --- footer -------------------------------------------------------------
    # Usual form at the end of an article:
    #     <type of meeting>, Locality      e.g. "Reading, Glasgow" / "Aberdeen"
    #     Date                             e.g. "4th October 2011"
    #     Brother (Servant)                e.g. "J Renton" (sometimes absent)
    # the last couple of blocks may hold several footer lines joined by <br>
    tail_src = []
    while lines and len(tail_src) < 3 and len(flat(lines[-1])) <= 200:
        tail_src.insert(0, lines.pop())
    tail_lines = split_lines(tail_src)
    tail = []
    while tail_lines and len(tail) < 5 and len(flat(tail_lines[-1])) <= 90:
        tail.insert(0, flat(tail_lines.pop()))
    lines += tail_lines
    def core(s):  # "1 January 1987 (Our beloved brother is now laid aside)"
        return re.sub(r'\s*\([^)]*\)\.?\s*$', '', s)
    date_i = next((k for k in range(len(tail) - 1, -1, -1)
                   if DATE_RE.match(core(tail[k])) or TRAIL_DATE_RE.match(core(tail[k]))), None)
    if date_i is not None:
        before, after = tail[:date_i], tail[date_i + 1:]
        dl = core(tail[date_i])
        if dl != tail[date_i]:
            after.insert(0, tail[date_i][len(dl):].strip())
        m = TRAIL_DATE_RE.match(dl) if not DATE_RE.match(dl) else None
        if m:
            art['date'] = m.group('date').rstrip('.')
            set_location(art, m.group('loc'))
        else:
            art['date'] = dl.rstrip('.')
            if before and len(before[-1]) <= 70 and not re.search(r'[!?”"]$', before[-1]) \
                    and not before[-1].startswith('(') \
                    and not re.search(r'(?i)name.?s sake|amen', before[-1]):
                set_location(art, before.pop())
        lines += before
        if after:
            if not ATTRIB_RE.match(after[0]) and is_servant(after[0]):
                art['servant'] = after.pop(0)
            if after:
                art['footer'] = after
    else:
        # no date: a trailing name line is still the servant ...
        if tail and not ATTRIB_RE.match(tail[-1]) and is_servant(tail[-1]):
            art['servant'] = tail.pop()
        # ... and "Lecture at Exeter" is still the meeting and place
        if tail and LOC_ONLY_RE.match(tail[-1]):
            set_location(art, tail.pop())
        lines += tail

    art['_lines'] = lines
    return art


def finalise_paragraphs(art):
    known = {e['initials'] for e in art.get('initials', [])}
    paras, pending = [], None
    for t in art.pop('_lines'):
        one = flat(t)
        if ATTRIB_RE.match(one):
            # "J. Taylor (Vol. 47, p.11, 12)" - source of the extract before it
            if paras:
                paras[-1]['source'] = one.lstrip('-–— ')
            else:
                paras.append({'text': t})
            pending = None
            continue
        sp, rest = speaker_token(one, known)
        if sp and not rest:
            pending = sp
            continue
        p = {}
        if sp:
            p['speaker'] = sp
            t = rest if '\n' not in t else t[t.find(sp) + len(sp):].strip()
        elif pending:
            p['speaker'] = pending
        pending = None
        p['text'] = t
        paras.append(p)
    # a capitalised word seen only once ("LONDON", "DIVINE") is not a speaker:
    # real speakers in a reading speak more than once
    counts = {}
    for p in paras:
        if 'speaker' in p:
            counts[p['speaker']] = counts.get(p['speaker'], 0) + 1
    for p in paras:
        s = p.get('speaker')
        if s and counts[s] == 1 and '.' not in s and s not in known \
                and s not in SPEAKER_LABELS and len(s) >= 4:
            p['text'] = s + ' ' + p['text'] if p['text'] else s
            del p['speaker']
    art['paragraphs'] = paras
    speakers = []
    for p in paras:
        s = p.get('speaker')
        if s and s not in speakers:
            speakers.append(s)
    if speakers:
        art['speakers'] = speakers


def strip_back_matter(blks):
    """Remove the issue's closing matter (repeated contents, publisher/printer)."""
    back = []
    for k, b in enumerate(blks):
        if k > 0 and CONTENTS_TITLE.match(b['text']):
            back = blks[k:]
            blks = blks[:k]
            break
    while blks and len(flat(blks[-1]['text'])) < 300 and \
            any(BACK_RE.search(x) for x in blks[-1]['text'].split('\n')):
        back.insert(0, blks.pop())
    # a lone publisher name line just above the address
    return blks, split_lines(b['text'] for b in back)


def convert(blocks, entries):
    arts, method = split_articles(blocks, entries)
    back = []
    if arts:
        arts[-1]['blocks'], back = strip_back_matter(arts[-1]['blocks'])
    # a TOC entry that points at the author line ("E.E.Hoyte") of an otherwise
    # empty article belongs to that article
    k = 1
    while k < len(arts):
        lab = flat(arts[k]['title'])
        if re.search(r'[a-z]', lab) and len(lab) < 40 and is_servant(lab) \
                and not strip_title(arts[k - 1]['title'], arts[k - 1]['blocks']):
            arts[k - 1]['blocks'] += arts.pop(k)['blocks']
            continue
        k += 1
    out = []
    for a in arts:
        title = flat(a['title'])
        if INITIALS_TITLE.match(title):
            body = strip_title(title, a['blocks'])
            lines = [b['text'] for b in body]
            key = parse_initials_key(lines)
            target = out[-1] if out else None
            if target is None:
                # key before any article: hold it for the next one
                out.append({'title': None, '_pending_initials': key, '_initials_title': title,
                            '_initials_raw': lines})
            else:
                target.setdefault('initials', []).extend(key)
                target['initials_heading'] = title
                target.setdefault('initials_text', []).extend(lines)
            continue
        art = build_article(title, a['blocks'])
        if out and out[-1].get('title') is None and '_pending_initials' in out[-1]:
            p = out.pop()
            art['initials'] = p['_pending_initials']
            art['initials_heading'] = p['_initials_title']
            art['initials_text'] = p['_initials_raw']
        out.append(art)
    out = [a for a in out if a.get('title') is not None]
    for a in out:
        finalise_paragraphs(a)
    # Article groups: a heading with no text of its own ("AT TWO BURIALS - 1",
    # "SOME FUNDAMENTALS -") introduces the article(s) after it.  It becomes the
    # 'group' of the next article and of any following "(ii)", "iii)", "[2]"
    # sub-articles, rather than an empty article.
    SUB = re.compile(r'^[(\[]?(?:[ivx]+|\d+)[)\].]\s', re.I)
    grouped, group, gmeta, first = [], None, {}, False
    for a in out:
        if not a['paragraphs'] and not a.get('initials'):
            group = re.sub(r'[\s\-–—:]+$', '', a['title'])
            gmeta = {k: a[k] for k in ('author', 'scriptures', 'meeting', 'place', 'date', 'servant') if k in a}
            first = True
            continue
        if group and (first or SUB.match(a['title'])):
            a['group'] = group
            for k, v in gmeta.items():
                a.setdefault(k, v)
            first = False
        else:
            group = None
        grouped.append(a)
    out = grouped
    for n, a in enumerate(out, 1):
        a['number'] = n
        # put keys in a stable, readable order
        order = ['number', 'group', 'title', 'author', 'scriptures', 'notes', 'meeting', 'place', 'date', 'servant',
                 'speakers', 'initials', 'initials_heading', 'initials_text', 'footer', 'paragraphs']
        out[n - 1] = {k: a[k] for k in order if k in a}
    return out, method, back

# --------------------------------------------------------------------------
# Library access and output
# --------------------------------------------------------------------------

def issue_label(series_id, title, index):
    """'048', '048-sup', '512a' etc. from the calibre title and series index."""
    num = int(index)
    m = re.search(r'\b0*(\d+)([A-Za-z]?)\s*-\s*(\w+)', title)
    suffix = ''
    if m and int(m.group(1)) == num:
        if m.group(2):
            suffix = m.group(2).lower()
        if m.group(3).lower().startswith('sup'):
            suffix += '-sup'
    elif index != num:
        suffix = chr(ord('a') + round((index - num) * 10) - 1)
    return f'{num:03d}{suffix}'


def set_out_dir(p):
    global OUT_DIR
    OUT_DIR = Path(p).resolve()


def out_path(series_id, label):
    code, sno, _ = SERIES[series_id]
    name = f'{code}{sno or ""}-{label}.json'
    return OUT_DIR / code / name


def library_issues(lib):
    db = sqlite3.connect(f'file:{(lib / "metadata.db").as_posix()}?mode=ro', uri=True)
    q = f"""
    select b.id, b.title, b.series_index, b.pubdate, b.path, b.last_modified, l.series,
           (select group_concat(name, '|') from publishers p join books_publishers_link pl
               on pl.publisher = p.id where pl.book = b.id),
           (select group_concat(format || ':' || name, '|') from data d where d.book = b.id)
    from books b join books_series_link l on l.book = b.id
    where l.series in ({','.join(map(str, SERIES))})
    order by l.series, b.series_index, b.id"""
    rows = []
    for bid, title, idx, pub, path, mod, sid, publ, data in db.execute(q):
        fmts = dict(x.split(':', 1) for x in (data or '').split('|') if ':' in x)
        rows.append(dict(id=bid, title=title, index=idx, pubdate=pub, path=path,
                         modified=mod, series=sid, publisher=publ, formats=fmts))
    db.close()
    return rows


def build_issue(lib, row):
    if 'EPUB' in row['formats']:
        fmt = 'EPUB'
        src = lib / row['path'] / (row['formats']['EPUB'] + '.epub')
        blocks, entries = read_epub(src)
    elif 'DOCX' in row['formats']:
        fmt = 'DOCX'
        src = lib / row['path'] / (row['formats']['DOCX'] + '.docx')
        blocks, entries = read_docx(src)
    else:
        raise RuntimeError('no EPUB or DOCX format')
    articles, method, back = convert(blocks, entries)
    code, sno, mag = SERIES[row['series']]
    label = issue_label(row['series'], row['title'], row['index'])
    pub = (row['pubdate'] or '')[:10]
    doc = {
        'schema': SCHEMA_VERSION,
        'magazine': mag,
        'code': code,
        'series': sno,
        'issue': label.upper().replace('-SUP', ' Supplement').lstrip('0') or '0',
        'number': int(row['index']),
        'title': row['title'],
        'date': pub[:7] if pub and not pub.startswith('0101') else None,
        'publisher': row['publisher'],
        'source': {
            'calibre_id': row['id'],
            'format': fmt,
            'file': (Path(row['path']) / src.name).as_posix(),
            'modified': datetime.datetime.fromtimestamp(src.stat().st_mtime, datetime.timezone.utc)
                        .strftime('%Y-%m-%dT%H:%M:%SZ'),
            'split_by': method,
        },
        'article_count': len(articles),
        'articles': articles,
    }
    if back:
        doc['back_matter'] = back
    return doc, label, src


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--library', type=Path, default=Path(os.environ.get('CALIBRE_LIBRARY', DEFAULT_LIBRARY)))
    ap.add_argument('--all', action='store_true', help='rebuild every issue')
    ap.add_argument('--changed', action='store_true', help='also rebuild issues whose source file changed')
    ap.add_argument('--ids', type=int, nargs='*', help='only these calibre book ids (always rebuilt)')
    ap.add_argument('--out', type=Path, default=OUT_DIR, help='output folder (default: dev/text/magazines)')
    ap.add_argument('--quiet', action='store_true')
    a = ap.parse_args(argv)
    set_out_dir(a.out)

    lib = a.library
    if not (lib / 'metadata.db').exists():
        sys.exit(f'calibre library not found: {lib}')
    rows = library_issues(lib)
    if a.ids:
        rows = [r for r in rows if r['id'] in set(a.ids)]

    built, skipped, problems = [], 0, []
    for r in rows:
        label = issue_label(r['series'], r['title'], r['index'])
        dest = out_path(r['series'], label)
        if dest.exists() and not (a.all or a.ids):
            if not a.changed:
                skipped += 1
                continue
            try:
                old = json.loads(dest.read_text(encoding='utf-8'))['source']['modified']
                fmt = 'EPUB' if 'EPUB' in r['formats'] else 'DOCX'
                src = lib / r['path'] / (r['formats'][fmt] + '.' + fmt.lower())
                now = datetime.datetime.fromtimestamp(src.stat().st_mtime, datetime.timezone.utc) \
                    .strftime('%Y-%m-%dT%H:%M:%SZ')
                if now <= old:
                    skipped += 1
                    continue
            except Exception:
                pass
        try:
            doc, label, src = build_issue(lib, r)
        except Exception as e:  # keep going; report at the end
            problems.append(f"{r['id']} {r['title']}: {e}")
            continue
        if not doc['articles']:
            problems.append(f"{r['id']} {r['title']}: no articles found")
        dest.parent.mkdir(parents=True, exist_ok=True)
        text = json.dumps(doc, ensure_ascii=False, indent=1) + '\n'
        with open(dest, 'w', encoding='utf-8', newline='\n') as fh:
            fh.write(text)
        built.append(dest)
        if not a.quiet:
            print(f"built {dest.relative_to(OUT_DIR)}  ({doc['article_count']} articles, {doc['source']['split_by']})")

    print(f'{len(built)} built, {skipped} already present, {len(problems)} problems')
    for p in problems:
        print('  PROBLEM', p)
    return 0 if not problems else 1


if __name__ == '__main__':
    sys.exit(main())
