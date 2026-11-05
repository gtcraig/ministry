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

SCHEMA_VERSION = 2

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


NAME_SUFFIX_RE = re.compile(r'(?i)^(?:snr|sr|sen|senior|jnr|jr|jun|junior)$')


def suffix_tag(sfx):
    return '(Jr)' if sfx.lower().startswith('j') else '(Snr)'


NAME_TITLE_RE = re.compile(r'^(?:Dr|Mr|Mrs|Miss|Prof)$')


def derive_initials(name):
    parts = [p for p in re.findall(r"[A-Za-z][A-Za-z'’-]*", name)
             if not NAME_SUFFIX_RE.match(p) and not NAME_TITLE_RE.match(p)]
    out = ''
    for p in parts:
        if p[0].isupper():
            out += p[0]
    return out


NAME_PARTICLES = {'de', 'van', 'von', 'der', 'den', 'du', 'la', 'le', 'st', 'st.'}
INI_WORD = re.compile(r'^[A-Z]\.?$')
KEY_HEAD_RE = re.compile(r'^\W*(?:key\s*to\s*)?(?:list\s*of\s*)?initials\b[^:;]{0,40}?(?::-?|[-–—])\s*', re.I)
KEY_REF_RE = re.compile(r'(?i)^\(?\s*(as\s+(?:in|for|per|before|last|previous)\b.*?)\)?'
                        r'(?:[,;]?\s*plus\b\s*[-–—:]*\s*|[.;]?\s*$)')


def name_words(s):
    """'J.A.Petersen' -> ['J.', 'A.', 'Petersen']"""
    return re.sub(r'\b([A-Z])\.(?=[A-Z])', r'\1. ', s).split()


def default_name_len(words):
    """Words in 'C J Brien Aberdeen ID' that make the name: a first word, any
    single-letter initials, any particles, then the surname."""
    i = 1
    while i < len(words) and INI_WORD.match(words[i]):
        i += 1
    while i < len(words) and words[i].lower() in NAME_PARTICLES:
        i += 1
    i += 1
    while i < len(words) and NAME_SUFFIX_RE.match(words[i].strip('.')):
        i += 1
    return min(i, len(words))


def name_end_ok(words, k):
    """words[:k] is a whole name: it ends with a surname and leaves no jnr/snr behind."""
    return 0 < k <= len(words) and not INI_WORD.match(words[k - 1]) \
        and not (k < len(words) and NAME_SUFFIX_RE.match(words[k].strip('.')))


def is_junk_name(name):
    words = name_words(name)
    if not words or re.search(r'\d', name) or not words[0][0].isupper():
        return True
    head = words[:default_name_len(words)]
    return any(w[0].islower() and w.lower() not in NAME_PARTICLES and not NAME_SUFFIX_RE.match(w.strip('.'))
               for w in head)


DOTTED_PREFIX_RE = re.compile(r'^((?:[A-Z][A-Za-z]{0,3}\.|[a-z]{1,2}\.|-)+[A-Z]?(?:(?:jnr|snr|jr|sr|sen|jun)\.?)?)'
                              r'\s*[-–—:=,]?\s+(?=[A-Z])(.+)$')
PLAIN_PREFIX_RE = re.compile(r'^([A-Z][A-Za-z]{1,6})\s+(?=[A-Z])(.+)$')
KEY_NOTE_RE = re.compile(r'\(\s*(?:all|local|visitors?)\b[^)]*\)\s*:?|\([^)]*\b(?:unless|otherwise|except)\b[^)]*\)\s*:?'
                         r'|[-–—]?\s*(?:[A-Z][\w’\']*\s+){0,3}(?:unless|if\s+not|except\s+where)\b[^,;)]*?'
                         r'\b(?:stated|shown|indicated|listed|given)\b(?:\s+otherwise)?[,;:.]?', re.I)


def prefix_fits(prefix, rest):
    """Printed initials before a name: 'A.A.B. A.A.Bellamy', and also where the
    man is known by a later name - 'G.B.G. Bruce Grant', 'D.S.B. Stuart Bodman':
    the name's first letter is among the initials and its surname letter is last."""
    up = upper_initials(re.sub(r'(jnr|snr|jr|sr|sen|jun)\.?$', '', prefix))
    rest = re.sub(r'^(?:Dr|Mr|Mrs|Miss|Prof)\.?\s*', '', rest)
    if not rest or not up:
        return False
    if prefix[0] == rest[0]:
        return True
    words = name_words(rest.split(',')[0])
    k = default_name_len(words)
    while k > 1 and NAME_SUFFIX_RE.match(words[k - 1].strip('.')):
        k -= 1
    surname = words[k - 1] if words else ''
    return rest[0] in up and upper_initials(surname)[:1] == up[-1]


def upper_initials(s):
    return re.sub(r'[^A-Z]', '', s)


def looks_new_name(part, cands):
    """After a comma inside one key entry: is this another person rather than a place?
    'S W Selman' yes (two or more initials); 'R Taylor' only if RT speaks in the
    article; 'E Finchley', 'Buckhurst Hill' no."""
    words = name_words(part)
    if not (2 <= len(words) <= 5) or is_junk_name(part) or INI_WORD.match(words[-1]):
        return False
    lead = words[:-1]
    if len(lead) >= 2 and all(INI_WORD.match(w) for w in lead):
        return True
    return derive_initials(part) in cands


PUBLISHER_RE = re.compile(r'(?i)\b(?:edited|published|printed)\s+(?:and\s+\w+\s+)?by\b|@|\bwww\.')


def is_key_comment(part):
    """'Other speakers not identified in original notes' - a remark, not a name or place."""
    words = part.split()
    low = [w for w in words if w[0].islower() and w.lower() not in NAME_PARTICLES]
    return len(words) >= 5 and len(low) >= 3 and not re.search(r'\d', part)


def parse_initials_key(lines, cands=None, notes=None, comments=None):
    """Parse 'R M Brown, East Finchley; D A Burr, London; ...' into entries.

    cands: {initials: count} of speaker-like openers in the article, used to
    settle ambiguous cases.  notes: list that receives {'kind', 'detail'} for
    every irregularity handled.  Returns (entries, reference) where reference
    is the text of an "as in the January issue" key, or None."""
    cands = cands or {}

    def note(kind, detail):
        if notes is not None:
            notes.append({'kind': kind, 'detail': detail})

    lines = [flat(l) for l in lines if flat(l)]
    if not lines:
        return [], None
    m = KEY_HEAD_RE.match(lines[0])
    if m and lines[0][m.end():].strip():
        note('heading_in_key', f'heading "{lines[0][:m.end()].strip()}" removed from the first name')
        lines[0] = lines[0][m.end():]
    text = ' '.join(lines)
    ref = None
    m = KEY_REF_RE.match(text)
    if m:
        ref = m.group(1).strip(' ,')
        text = text[m.end():]
        lines = [text] if text else []
    if comments is None:
        comments = []
    for m in KEY_NOTE_RE.finditer(text):
        c = m.group(0).strip(' ()-–—:,;')
        if c:
            comments.append(c)
    if KEY_NOTE_RE.search(text):
        text = flat(KEY_NOTE_RE.sub(' ', text))
        lines = [flat(KEY_NOTE_RE.sub(' ', l)) for l in lines]
    if ';' in text or len(re.findall(r'(?<=[a-z]):\s+(?=[A-Z])', text)) >= 2:
        text = re.sub(r'(?<=[a-z]):\s+(?=[A-Z])', '; ', text)
    chunks = text.split(';') if ';' in text else lines
    # Brackets are not stored: "D.McFarlane (New York)" is name + place, and
    # "W. Lovie (Jr)" keeps Jr with the name.  "...(New York). L.McFarlane (New
    # York)" is two people joined by a full stop.
    RUN_ON = re.compile(r'(?<=[a-z,])\s+(?=(?:[A-Z][a-z-]{0,3}\.){2,}\s*[-–—]?\s+[A-Z])')
    split_run = []
    for ch in chunks:
        n_run = len(RUN_ON.findall(ch))
        if n_run >= 2 or (n_run == 1 and re.match(r'(?:[A-Z][a-z-]{0,3}\.){2,}\s*[-–—]?\s+[A-Z]', ch.strip())):
            note('run_on_key', f'one line holds {len(RUN_ON.findall(ch)) + 1} entries; split at each set of initials')
            split_run.extend(RUN_ON.split(ch))
        else:
            split_run.append(ch)
    chunks = split_run
    pre = []
    for ch in chunks:
        ch = re.sub(r'\s*\(\s*(snr|sr|senior|jnr|jr|junior)\.?\s*\)', lambda m: ' ' + m.group(1), ch, flags=re.I)
        ch = re.sub(r'\s*\(([^()]*)\)?', lambda m: ', ' + m.group(1).strip() if m.group(1).strip() else '', ch)
        ch = ch.replace(')', '').strip(' ,')
        while True:
            m = re.search(r'(?<=[a-z]{2})\.\s+(?=(?:[A-Z]\.\s?){1,4}\s*(?:Ma?c)?[A-Z][a-z])', ch)
            if not (m and ',' in ch[:m.start()]):
                break
            note('comma_for_semicolon', f'"{ch}" read as two people (full stop between them)')
            pre.append(ch[:m.start()])
            ch = ch[m.end():]
        pre.append(ch)
    chunks = pre
    no_comma_key = ',' not in ' '.join(chunks) and len(chunks) > 1
    entries, ini_first = [], []

    def new_entry(name, ini):
        e = {}
        words = name_words(name)
        whole = derive_initials(name)
        if ini and len(words) > 2 and upper_initials(whole) != upper_initials(ini):
            k = next((k for k in range(2, len(words)) if name_end_ok(words, k)
                      and upper_initials(derive_initials(' '.join(words[:k]))) == upper_initials(ini)), None)
            if k is None:   # known by a later name: A.G.S. Grahame Smith Sidcup
                k = next((k for k in range(2, len(words)) if name_end_ok(words, k)
                          and is_subseq(upper_initials(derive_initials(' '.join(words[:k]))), upper_initials(ini))
                          and upper_initials(derive_initials(' '.join(words[:k])))[-1:] == upper_initials(ini)[-1:]), None)
            if k is None and no_comma_key:
                k = default_name_len(words)
                k = k if k < len(words) and name_end_ok(words, k) else None
            if k:
                note('no_comma_before_place', f'"{name}" read as {" ".join(words[:k])}, {" ".join(words[k:])}')
                e['place'] = ' '.join(words[k:])
                name = ' '.join(words[:k])
        elif not ini and len(words) > 2 and whole not in cands:
            k = next((k for k in range(2, len(words)) if name_end_ok(words, k)
                      and derive_initials(' '.join(words[:k])) in cands), None)
            if k is None and no_comma_key:
                k = default_name_len(words)
                k = k if k < len(words) else None
            if k:
                note('no_comma_before_place', f'"{name}" read as {" ".join(words[:k])}, {" ".join(words[k:])}')
                e['place'] = ' '.join(words[k:])
                name = ' '.join(words[:k])
        name = re.sub(r'(?i)\b(jnr|snr|jr|sr|sen|jun)\b', lambda m: m.group(1).capitalize(), name)
        e = {'initials': ini or derive_initials(name), 'name': name.strip(), **e}
        return e

    for ch in chunks:
        ch = ch.strip(' .')
        # editor / publisher lines end the key: "Edited and Published by ..."
        m = PUBLISHER_RE.search(ch)
        if m:
            if ch[:m.start()].strip(' .,'):
                note('publisher_in_key', f'"{ch[m.start():][:60]}..." ignored')
            ch = ch[:m.start()].strip(' .,')
            stop_key = True
        else:
            stop_key = False
        # "Dr.S.D.K.Roberts" -> "Dr. S.D.K.Roberts"; "E.T.Maynard - New York"
        ch = re.sub(r'\b(Dr|Mr|Mrs|Miss|Prof)\.?\s*(?=[A-Z])', r'\1. ', ch)
        ch = re.sub(r'(?<=[a-z])\s+-\s+(?=[A-Z])', ', ', ch)

        # "H A Hutson. London" - a full stop where the comma should be, but not
        # after an abbreviated first name ("Doug. Matthews", "Jas. Webster")
        def stop_to_comma(m):
            before = re.split(r',', ch[:m.start() + 1])[-1].split()
            return ', ' if len(before) >= 2 else m.group(0)
        ch2 = re.sub(r'(?<=[a-z]{2})\.\s+(?=[A-Z][a-z])', stop_to_comma, ch)
        if ch2 != ch:
            note('full_stop_for_comma', f'"{ch}"')
            ch = ch2
        ch = re.sub(r'(?<=[a-z])\s*[—–]\s*(?=[A-Z])', ', ', ch).lstrip(':;-–—., ')
        if not ch:
            if stop_key:
                break
            continue
        ini = None
        m = re.match(r'^[a-z]{1,2}\.?\s+(?=[A-Z])', ch)
        if m:
            note('stray_text_in_key', f'"{ch}": "{m.group(0).strip()}" ignored')
            ch = ch[m.end():]
        m = DOTTED_PREFIX_RE.match(ch)
        pm = PLAIN_PREFIX_RE.match(ch) if not m else None
        if m and '.' in m.group(1) and len(upper_initials(m.group(1))) >= 2 \
                and prefix_fits(m.group(1), m.group(2)):
            ini = re.sub(r'[.\s-]', '', m.group(1))
            sx = re.search(r'(jnr|snr|jr|sr|sen|jun)$', ini)
            if sx:
                ini = ini[:sx.start()] + suffix_tag(sx.group(1))
            ch = m.group(2).strip()
            ini_first.append(ini)
            m = None
        else:
            m = re.match(r'^((?:[A-Z]\.?\s?){1,6})\s*[-–—:=]\s*(.+)$', ch)
        if m and len(m.group(1).replace('.', '').replace(' ', '')) <= 6 and ' ' in m.group(2):
            ini = m.group(1).replace('.', '').replace(' ', '')
            ch = m.group(2).strip()
        elif ini is None and pm and len(upper_initials(pm.group(1))) >= 2:
            # "WTA W. T. Abbott", "JSp J.Spinks", "GCMcK Gordon C. McKay", "AMcK Sandy McKay"
            tok, rest = pm.group(1), pm.group(2)
            last = name_words(rest.split(',')[0])
            last = last[min(default_name_len(last), len(last)) - 1] if last else ''
            if tok[0] == rest[0] or (last and set(upper_initials(last)) <= set(tok)):
                ini, ch = tok, rest.strip()
                ini_first.append(ini)
        parts = [p.strip(' .') for p in ch.split(',') if p.strip(' .')]
        keep = []
        for part in parts:
            if is_key_comment(part):
                comments.append(part)
            else:
                keep.append(part)
        parts = keep
        cur = None
        for part in parts:
            if cur is None or looks_new_name(part, cands):
                if cur is not None:
                    note('comma_for_semicolon', f'"{cur["name"]}{", " + cur["place"] if "place" in cur else ""}, '
                                                f'{part}" read as two people')
                if is_junk_name(part) and cur is None:
                    note('not_a_name', f'"{part}" left out of the key')
                    break
                cur = new_entry(part, ini if cur is None else None)
                entries.append(cur)
                # "T W Lock D H Marshall" - the separator is missing altogether
                if 'place' in cur and looks_new_name(cur['place'], cands):
                    note('comma_for_semicolon', f'"{cur["name"]} {cur["place"]}" read as two people')
                    cur = new_entry(cur.pop('place'), None)
                    entries.append(cur)
                continue
            if NAME_SUFFIX_RE.match(part.strip('.')):
                cur['name'] += ' ' + part.strip('.').capitalize()
                continue
            both = re.match(r'(?i)^both\s+(.+)', part)
            place = both.group(1) if both else part
            cur['place'] = cur['place'] + ', ' + place if 'place' in cur else place
            if both and len(entries) > 1 and 'place' not in entries[-2]:
                entries[-2]['place'] = place
        if stop_key:
            break
    if ini_first:
        note('initials_before_name', f'{len(ini_first)} entries written as initials then name ("{ini_first[0]} ...")')
    return entries, ref

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
            art['initials'] = []
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


OPENER_RE = re.compile(r'^((?:[A-Z]\.?\s?){2,6}?)(?=\s+[A-Z“"‘(\'])')


def speaker_candidates(lines):
    """{initials: count} of paragraph openers that look like speaker initials."""
    c = {}
    for t in lines:
        m = OPENER_RE.match(flat(t))
        if m:
            k = m.group(1).replace('.', '').replace(' ', '')
            if 2 <= len(k) <= 6 and k not in COMMON_CAPS:
                c[k] = c.get(k, 0) + 1
    return c


def is_subseq(a, b):
    it = iter(b)
    return all(ch in it for ch in a)


def reconcile_speakers(art, cands, notes):
    """Speakers who open two or more paragraphs but are not in the key: match
    them loosely to a key entry (TAO -> T A S Oberg, WMP -> W Patterson), or
    add them to the key as not_in_key, so their paragraphs are split."""
    entries = art['initials']
    known = {e['initials'] for e in entries}
    for tok, n in sorted(cands.items()):
        if tok in known:
            continue
        # known by his second name: AGS in the text, "Graeme Smith" (GS) in the key
        second = [e for e in entries if len(tok) >= 3 and e['initials'] == tok[1:]
                  and e['initials'] not in cands and not e.get('not_in_key')]
        if len(second) == 1:
            e = second[0]
            notes.append({'kind': 'speaker_second_name',
                          'detail': f'{tok} used in the text for {e["name"]} (key gives {e["initials"]})'})
            e['key_initials'], e['initials'] = e['initials'], tok
            known.add(tok)
            continue
        ambiguous = ' or '.join(e['name'] for e in second) if len(second) > 1 else ''
        loose = [e for e in entries if e['initials'] not in cands and e['initials'][:1] == tok[:1]
                 and e['initials'][-1:] == tok[-1:]
                 and (is_subseq(tok, e['initials']) or is_subseq(e['initials'], tok))]
        if len(loose) == 1:
            e = loose[0]
            note = f'{tok} used in the text for {e["name"]} (key gives {e["initials"]})'
            e['key_initials'], e['initials'] = e['initials'], tok
            notes.append({'kind': 'speaker_matched_loosely', 'detail': note})
        elif n == 1:
            notes.append({'kind': 'possible_speaker', 'detail': f'{tok} opens one paragraph; not in the key, so not split'
                          + (f' (could be {ambiguous})' if ambiguous else '')})
            continue
        else:
            entries.append({'initials': tok, 'not_in_key': True})
            notes.append({'kind': 'speaker_not_in_key', 'detail': f'{tok} ({n} paragraphs)'
                          + (f'; could be {ambiguous}, known by a second name' if ambiguous else '')})
        known.add(tok)


def initials_fit_name(tok, name):
    """Does 'DMcF' fit 'D.McFarlane', 'JSp' fit 'J. Spinks', 'JasM' fit 'Jas.Marshall'?
    Each part of the initials must begin the matching word of the name."""
    mc = lambda x: re.sub(r'^Mac(?=[A-Z])', 'Mc', x)
    segs = [mc(x) for x in re.findall(r'Ma?c[A-Z][a-z]*|[A-Z][a-z]*', tok)]
    words = [mc(w.strip('.')) for w in name_words(name or '')]
    words = [w for w in words if w and not NAME_SUFFIX_RE.match(w)]
    return bool(segs) and len(segs) == len(words) and all(w.startswith(s) for s, w in zip(segs, words))


def align_key_to_speakers(art, notes):
    """Store each key entry's initials as the text writes them: a speaker who
    is not in the key ('DMcF') takes over the one entry whose name he fits
    ('D.McFarlane', key DM) (the change is logged in EXCEPTIONS.md)."""
    entries = art.get('initials') or []
    used = [s for s in art.get('speakers', []) if s not in SPEAKER_LABELS]
    count = {}
    for p in art.get('paragraphs', []):
        if p.get('speaker'):
            count[p['speaker']] = count.get(p['speaker'], 0) + 1
    known = {e['initials'] for e in entries}
    # "Jas.W." once where the text otherwise has JW for Jas. Webster: same man
    for tok in list(used):
        if tok in known:
            continue
        fit = [e for e in entries if not e.get('not_in_key') and e['initials'] in count
               and e['initials'] != tok and initials_fit_name(tok, e.get('name'))
               and count.get(tok, 0) * 3 <= count[e['initials']]]
        if len(fit) == 1:
            main = fit[0]['initials']
            for p in art.get('paragraphs', []):
                if p.get('speaker') == tok:
                    p['speaker'] = main
            notes.append({'kind': 'speaker_variant',
                          'detail': f'{tok} ({count.get(tok, 0)}x) read as {main} ({count[main]}x), {fit[0]["name"]}'})
            used.remove(tok)
            art['speakers'] = [x for x in art['speakers'] if x != tok]
    for tok in used:
        if tok in known:
            continue
        if '(' in tok:
            base, qual = tok[:-1].split('(')
            fit = [e for e in entries if not e.get('not_in_key') and e['initials'] == base
                   and (e.get('place') or '').lower().startswith(qual.lower())]
        else:
            # an entry is free unless a speaker already uses its initials and no
            # other entry shares them (J. Spinks and J. Strachan are both JS)
            dup = {i for i in (e['initials'] for e in entries) if sum(x['initials'] == i for x in entries) > 1}
            fit = [e for e in entries if not e.get('not_in_key')
                   and (e['initials'] not in used or e['initials'] in dup)
                   and initials_fit_name(tok, e.get('name'))]
        if len(fit) == 1:
            e = fit[0]
            notes.append({'kind': 'speaker_matched_loosely',
                          'detail': f'{tok} used in the text for {e["name"]} (key gives {e["initials"]})'})
            e['key_initials'], e['initials'] = e['initials'], tok
            known.add(tok)
        else:
            many = [e['name'] for e in entries if not e.get('not_in_key') and initials_fit_name(tok, e.get('name'))]
            entries.append({'initials': tok, 'not_in_key': True})
            notes.append({'kind': 'speaker_not_in_key', 'detail': f'{tok} (in the text)'
                          + (f'; could be {" or ".join(many)}' if len(many) > 1 else '')})
            known.add(tok)


# Speaker initials that the plain capitals pattern does not catch:
#   "L.McF.", "GCMcK", "JSp", "RGr"  - Mc/Mac or a shortened surname
#   "JTB(Gr)", "JTB(Ed)", "JTB.Ed)"   - a qualifier telling two men apart
EXT_SPK_RE = re.compile(r'^((?:(?:Ma?c[A-Z][a-z]?|[A-Z][a-z]{0,2})\.?){2,5})(?=\s)')
QUAL_SPK_RE = re.compile(r'^((?:[A-Z]\.?){1,5})\s?[.(]\s?([A-Z][a-z]{0,2})\.?\)')


def ext_speaker_counts(lines):
    c = {}
    for t in lines:
        sp, _, _ = ext_speaker_raw(flat(t))
        if sp:
            c[sp] = c.get(sp, 0) + 1
    return c


def ext_speaker_raw(text):
    """(normalised initials, rest, matched text) for the extended forms, unchecked."""
    m = QUAL_SPK_RE.match(text)
    if m:
        return f"{m.group(1).replace('.', '')}({m.group(2)})", text[m.end():].strip(), m.group(0)
    m = EXT_SPK_RE.match(text)
    if m and re.search(r'[a-z]', m.group(1)):
        return m.group(1).replace('.', ''), text[m.end():].strip(), m.group(0)
    return None, text, None


def ext_speaker(text, known, entries, counts):
    """Accept an extended form when the key has it, when it fits exactly one
    name in the key (LMcF -> L.McFarlane, JSp -> J. Spinks), when its
    qualifier picks out one entry (JTB(Gr) -> J. T. Brown, Gr), or when a
    Mc/Mac form opens two or more paragraphs."""
    sp, rest, raw = ext_speaker_raw(text)
    if not sp:
        return None, text, None
    if rest and not (rest[0].isupper() or rest[0] in '“"‘\'(….0123456789-–—'):
        return None, text, None
    named = [e for e in entries if not e.get('not_in_key')]
    ok = sp in known
    if not ok and '(' in sp:
        base, qual = sp[:-1].split('(')
        ok = base in known or any(e['initials'] == base for e in named)
    if not ok:
        ok = len([e for e in named if initials_fit_name(sp, e.get('name'))]) == 1
    if not ok:
        ok = bool(re.search(r'Ma?c[A-Z]', sp)) and counts.get(sp, 0) >= 2
    return (sp, rest, raw) if ok else (None, text, None)


_TOWN = r"[A-Z][\w’'.-]*(?:\s+[A-Z][\w’'.-]*)*"
DEFAULT_PLACE_RE = re.compile(r'(?:\b[Aa]ll\s+|\b[Ff]rom\s+)?(?:(?P<local>[Ll]ocal)(?:\s+in\s+(?P<in>' + _TOWN + r'))?|'
                              r'(?P<town>' + _TOWN + r'))\s+(?:unless|if\s+not|except)\b')
ALL_LOCAL_RE = re.compile(r'\b[Aa]ll\s+(?P<local>local)(?:\s+in\s+(?P<in>' + _TOWN + r'))?\s*\)?\s*$')


def apply_default_place(art, notes):
    """'(local unless otherwise stated)', 'London unless otherwise stated',
    'all local in Aberdeen': give that place to entries that have none."""
    texts = (art.get('initials_comment') or '').split('; ') + [art.get('initials_heading') or '']
    for t in texts:
        m = DEFAULT_PLACE_RE.search(t) or ALL_LOCAL_RE.search(t)
        if not m:
            continue
        place = m.group('in') or (art.get('place') if m.group('local') else m.groupdict().get('town'))
        if not place or place.lower() in ('all', 'list', 'key', 'initials'):
            continue
        n = 0
        for e in art.get('initials', []):
            if not e.get('place') and not e.get('not_in_key'):
                e['place'] = place
                n += 1
        if n:
            notes.append({'kind': 'default_place', 'detail': f'{place} given to {n} names ("{t.strip()}")'})
        return


PEOPLE_FILE = Path(__file__).resolve().parent / 'magazine_people.json'
_PEOPLE = None


def people():
    global _PEOPLE
    if _PEOPLE is None:
        try:
            _PEOPLE = json.loads(PEOPLE_FILE.read_text(encoding='utf-8')).get('people', [])
        except FileNotFoundError:
            _PEOPLE = []
    return _PEOPLE


def apply_people(art, notes):
    """Known people (magazine_people.json): fixed initials and missing places."""
    for who in people():
        for al in who.get('aliases', []):
            hit = [p for p in art.get('paragraphs', []) if p.get('speaker') == al]
            if hit and who.get('initials'):
                for p in hit:
                    p['speaker'] = who['initials']
                art['speakers'] = list(dict.fromkeys(who['initials'] if x == al else x
                                                     for x in art.get('speakers', [])))
                for e in art.get('initials', []):
                    if e['initials'] == al:
                        e['initials'] = who['initials']
                notes.append({'kind': 'person_fixed', 'detail': f'{al} in the text -> {who["initials"]} ({who["name"]})'})
    for e in art.get('initials', []):
        if e.get('not_in_key'):
            continue
        words = [w.strip('.') for w in name_words(e.get('name') or '')]
        words = [w for w in words if w and not NAME_SUFFIX_RE.match(w) and not NAME_TITLE_RE.match(w)]
        if len(words) < 2:
            continue
        for who in people():
            if words[-1] != who['surname'] or words[0] not in who.get('forenames', []) \
                    or (e.get('place') or '') in who.get('not_places', []):
                continue
            new = who.get('initials')
            if new and e['initials'] != new:
                old = e['initials']
                for p in art.get('paragraphs', []):
                    if p.get('speaker') == old:
                        p['speaker'] = new
                if old in art.get('speakers', []):
                    art['speakers'] = [new if x == old else x for x in art['speakers']]
                    art['speakers'] = list(dict.fromkeys(art['speakers']))
                notes.append({'kind': 'person_fixed', 'detail': f'{e["name"]}: {old} -> {new} ({who["name"]})'})
                e['initials'] = new
            if who.get('place') and not e.get('place'):
                e['place'] = who['place']
                notes.append({'kind': 'person_fixed', 'detail': f'{e["name"]}: place {who["place"]} ({who["name"]})'})
            break


def finalise_paragraphs(art, prior_key=None):
    notes = art.setdefault('_notes', [])
    cands = speaker_candidates(art['_lines'])
    if art.get('initials_text'):
        comments = []
        entries, ref = parse_initials_key(art['initials_text'], cands, notes, comments)
        if comments:
            art['initials_comment'] = '; '.join(dict.fromkeys(comments))
        if ref:
            prior, where = prior_key() if prior_key else ([], None)
            have = {e['initials'] for e in entries}
            add = [dict(e) for e in prior if e['initials'] not in have]
            entries = add + entries
            notes.append({'kind': 'key_from_earlier_issue',
                          'detail': f'"{ref}": {len(add)} names taken from {where}' if where
                          else f'"{ref}": no earlier key found'})
        art['initials'] = entries
        apply_default_place(art, notes)
    if art.get('initials'):
        reconcile_speakers(art, cands, notes)
    known = {e['initials'] for e in art.get('initials', [])}
    ext_counts = ext_speaker_counts(art['_lines'])
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
        sp, rest, raw = ext_speaker(one, known, art.get('initials') or [], ext_counts)
        if not sp:
            sp, rest = speaker_token(one, known)
            raw = sp
        if sp and not rest:
            pending = sp
            continue
        p = {}
        if sp:
            p['speaker'] = sp
            t = rest if '\n' not in t else t[t.find(raw) + len(raw):].strip()
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
                and s not in SPEAKER_LABELS and len(s) >= 4 \
                and not any(initials_fit_name(s, e.get('name')) for e in art.get('initials', [])):
            p['text'] = s + ' ' + p['text'] if p['text'] else s
            del p['speaker']
    for p in paras:
        s = p.get('speaker')
        if s and s not in SPEAKER_LABELS:
            p['speaker'] = re.sub(r'[.\s]', '', s)
    art['paragraphs'] = paras
    speakers = []
    for p in paras:
        s = p.get('speaker')
        if s and s not in speakers:
            speakers.append(s)
    if speakers:
        art['speakers'] = speakers
    if art.get('initials'):
        align_key_to_speakers(art, notes)
    apply_people(art, notes)
    if speakers:
        art['paragraphs'] = group_turns(art['paragraphs'])


def group_turns(paras):
    """In a reading, a paragraph with no speaker continues the speaker above it.
    Each speaker's contribution becomes one item whose 'text' is a list of his
    paragraphs.  Paragraphs before the first speaker are left as they are; a
    continuation with its own 'source' repeats the speaker."""
    out, turn = [], None
    for p in paras:
        if 'speaker' in p:
            turn = {k: v for k, v in p.items() if k != 'text'}
            turn['text'] = [p['text']] if p.get('text') else []
            out.append(turn)
        elif turn is not None and set(p) == {'text'}:
            turn['text'].append(p['text'])
        elif turn is not None:
            q = {'speaker': turn['speaker'], **{k: v for k, v in p.items() if k != 'text'}}
            q['text'] = [p['text']]
            out.append(q)
            turn = q
        else:
            out.append(p)
    # keep 'speaker' first, then 'text', then anything else
    return [{'speaker': t['speaker'], 'text': t['text'], **{k: v for k, v in t.items() if k not in ('speaker', 'text')}}
            if 'speaker' in t else t for t in out]


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


def convert(blocks, entries, prior_key=None):
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
            key = []
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
        finalise_paragraphs(a, prior_key)
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
    notes = []
    for n, a in enumerate(out, 1):
        a['number'] = n
        for e in a.get('initials', []):
            e.pop('key_initials', None)   # working value only; EXCEPTIONS.md records it
        for x in a.pop('_notes', []):
            notes.append({'article': n, 'title': a['title'], **x})
        # put keys in a stable, readable order
        order = ['number', 'group', 'title', 'author', 'scriptures', 'notes', 'meeting', 'place', 'date', 'servant',
                 'speakers', 'initials', 'initials_heading', 'initials_comment', 'initials_text', 'footer',
                 'paragraphs']
        out[n - 1] = {k: a[k] for k in order if k in a}
    return out, method, back, notes

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


def prior_key_finder(series_id, number):
    """For a key that says "as in the January issue": the key of the nearest
    earlier issue of the same series that has one (read from its JSON)."""
    def find():
        code, sno, _ = SERIES[series_id]
        found = []
        for f in (OUT_DIR / code).glob(f'{code}{sno or ""}-*.json'):
            try:
                d = json.loads(f.read_text(encoding='utf-8'))
            except Exception:
                continue
            if d.get('number', 0) < number:
                found.append((d['number'], f.stem, d))
        for _, stem, d in sorted(found, key=lambda x: x[0], reverse=True)[:6]:
            ents, seen = [], set()
            for a in d['articles']:
                for e in a.get('initials', []):
                    if e['initials'] not in seen and not e.get('not_in_key'):
                        seen.add(e['initials'])
                        ents.append({k: v for k, v in e.items() if k != 'key_initials'})
            if ents:
                return ents, stem
        return [], None
    return find


NOTE_KINDS = [
    ('comma_for_semicolon', 'Two people separated by a comma',
     'The key has a comma where a semicolon belongs ("L E Oliver, S W Selman"). '
     'Read as two people when the second has two or more initials, or when their initials speak in the text.'),
    ('full_stop_for_comma', 'Full stop before a place',
     '"H A Hutson. London" read as "H A Hutson, London".'),
    ('no_comma_before_place', 'No comma between name and place',
     '"C J Brien Aberdeen ID": the name is taken as first name or initials plus surname, '
     'checked against the initials used in the text; the rest is the place.'),
    ('initials_before_name', 'Initials written before each name',
     '"WTA W. T. Abbott, London": the leading initials are used and dropped from the name.'),
    ('stray_text_in_key', 'Stray characters before a name',
     'OCR fragments such as "n. J.Thomson" before a name are ignored.'),
    ('publisher_in_key', 'Editor / publisher lines in the key',
     '"Edited and Published by ..." and the address after it are not part of the key: the key stops there.'),
    ('default_place', 'Default place from the key',
     '"(local unless otherwise stated)", "London unless otherwise stated", "all local in Aberdeen": that place is '
     'given to every name with none of its own. "Local" is the place of the meeting.'),
    ('speaker_variant', 'Same speaker written two ways',
     'A rare form ("Jas.W.", once) of a speaker who is in the key under the form the text normally uses (JW): '
     'the rare form is changed to the usual one. Only done when the usual form is used at least three times as often.'),
    ('person_fixed', 'Known people (magazine_people.json)',
     'Initials or a missing place set from dev/scripts/magazine_people.json, e.g. Bill W. Lovie is always WWL.'),
    ('run_on_key', 'Key printed as one line',
     'All the entries run together ("David Brown Grangemouth R.H.B. Roland Brown East Finchley ..."): split before each set of initials.'),
    ('heading_in_key', 'Heading joined to the first name',
     '"Key to List of Initials:- A M Brown" - the heading is removed.'),
    ('not_a_name', 'Non-name lines in the key',
     'Lines such as "Reading at Glasgow 29 November 2003" that ended up in the key are left out.'),
    ('key_from_earlier_issue', 'Key refers to an earlier issue',
     '"As in the January issue, plus ...": the names are copied from the nearest earlier issue with a key.'),
    ('speaker_second_name', 'Speaker known by a second name',
     'The text uses an extra first initial (AGS) where the key gives the name he is known by '
     '("Graeme Smith", GS). Matched only when one key entry fits. '
     'Where two entries fit, nothing is matched and the case is listed under the speaker sections below.'),
    ('speaker_matched_loosely', 'Speaker initials differ from the key',
     'The key\'s initials are replaced by the ones the text actually uses for that man: '
     'DMcF for "D.McFarlane", JSp for "J. Spinks", JTB(Gr) for "J. T. Brown (Gr.)", TAO for "T A S Oberg". '
     'The entry\'s initials are set to the ones used in the text.'),
    ('possible_speaker', 'Possible speaker, left unsplit',
     'Capital letters that open a single paragraph and match nothing in the key (a speaker missing '
     'from the key, or just a word in capitals). Left as text: check these by hand.'),
    ('speaker_not_in_key', 'Speaker not in the key',
     'Initials that open two or more paragraphs but are not in the key. They are added to the key '
     'with "not_in_key": true and no name, so their paragraphs are still split.'),
]


def write_exceptions(out_dir):
    """Regenerate EXCEPTIONS.md from the build_notes of every issue JSON."""
    by_kind, docx, split = {}, [], {}
    files = sorted(out_dir.glob('*/*.json'))
    for f in files:
        try:
            d = json.loads(f.read_text(encoding='utf-8'))
        except Exception:
            continue
        for n in d.get('build_notes', []):
            by_kind.setdefault(n['kind'], []).append((f.stem, n))
        if d['source'].get('format') == 'DOCX':
            docx.append(f.stem)
        if d['source'].get('split_by') != 'toc':
            split.setdefault(d['source'].get('split_by'), []).append(f.stem)
    md = ['# Magazine build exceptions', '',
          'Generated by `dev/scripts/build_magazines.py` on every run, from the `build_notes` '
          'in each issue\'s JSON. Do not edit by hand: correct the EPUB in calibre and rebuild, '
          'and the entry disappears once the source is clean.', '',
          f'{len(files)} issues. Summary:', '',
          '| Exception | Issues | Cases |', '|---|---:|---:|']
    for kind, head, _ in NOTE_KINDS:
        rows = by_kind.get(kind, [])
        if rows:
            md.append(f'| [{head}](#{kind.replace("_", "-")}) | {len({r[0] for r in rows})} | {len(rows)} |')
    for kind, head, expl in NOTE_KINDS:
        rows = by_kind.get(kind, [])
        if not rows:
            continue
        md += ['', f'<a id="{kind.replace("_", "-")}"></a>', f'## {head}', '', expl, '',
               '| Issue | Article | Detail |', '|---|---|---|']
        for stem, n in rows:
            t = (n.get('title') or '').replace('|', '\\|')
            md.append(f'| {stem} | {n.get("article")}. {t[:50]} | {n["detail"].replace("|", chr(92) + "|")} |')
    if docx:
        md += ['', '## Issues read from DOCX (no EPUB)', '', ', '.join(docx)]
    for how, stems in sorted(split.items(), key=lambda x: str(x[0])):
        md += ['', f'## Split by `{how}` rather than the EPUB table of contents', '', ', '.join(stems)]
    (out_dir / 'EXCEPTIONS.md').write_text('\n'.join(md) + '\n', encoding='utf-8', newline='\n')


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
    articles, method, back, notes = convert(blocks, entries,
                                            prior_key_finder(row['series'], int(row['index'])))
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
    if notes:
        doc['build_notes'] = notes
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

    write_exceptions(OUT_DIR)
    print(f'{len(built)} built, {skipped} already present, {len(problems)} problems')
    for p in problems:
        print('  PROBLEM', p)
    return 0 if not problems else 1


if __name__ == '__main__':
    sys.exit(main())
