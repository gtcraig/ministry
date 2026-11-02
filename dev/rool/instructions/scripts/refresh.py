#!/usr/bin/env python3
"""Build or refresh the Good Teaching library from the GitHub repository.

  python3 refresh.py                      # build, or bring an existing build up to date
  python3 refresh.py --check              # say what would change; write nothing
  python3 refresh.py --branch change/69   # use a branch other than main
  python3 refresh.py --dest /tmp/gt       # build somewhere other than /rool-drive

How it works, in three steps:

  1. One request to the GitHub API lists every file in the repository with its
     git blob id. This is the only thing that touches the network on a refresh
     that has nothing to do.
  2. The list is compared with the manifest written by the previous run. Files
     whose blob id is unchanged are skipped entirely — they are never downloaded.
  3. New and changed files are fetched from raw.githubusercontent.com in
     parallel and written through a temporary file, so an interrupted run
     leaves no half-written text. Files deleted from the repository are deleted
     here too.

The first build downloads the whole data set once (roughly 300 MB); later
refreshes download only what has actually changed — a new magazine, a corrected
text file — and typically cost one API call and a few seconds.

Stdlib only. Python 3.8 or later.
"""
import argparse, concurrent.futures as cf, json, os, sys, time, urllib.parse, urllib.request

REPO = "gtcraig/ministry"
API = "https://api.github.com/repos/{repo}/git/trees/{branch}?recursive=1"
RAW = "https://raw.githubusercontent.com/{repo}/{branch}/{path}"
UA = {"User-Agent": "good-teaching-refresh/1.0"}

# repository folder -> folder under --dest
DIRS = [
    ("dev/text/ministry", "ministry"),
    ("dev/text/hymns", "hymns"),
    ("dev/text/bible", "bible"),
    ("dev/text/magazines", "magazines"),
]

# repository file -> destination path relative to --dest
FILES = [
    ("dev/rool/instructions/scripts/expand.py", "bible/expand.py"),
    ("dev/rool/instructions/scripts/hymns.py", "hymns/hymns.py"),
]

STATE_DIR, STATE_FILE = "Good Teaching", "manifest.json"


def get_json(url):
    req = urllib.request.Request(url, headers=UA)
    with urllib.request.urlopen(req, timeout=120) as r:
        return json.load(r)


def get_bytes(url):
    req = urllib.request.Request(url, headers=UA)
    with urllib.request.urlopen(req, timeout=120) as r:
        return r.read()


def listing(branch):
    """destination-relative path -> git blob id, straight from the tree API."""
    data = get_json(API.format(repo=REPO, branch=branch))
    if data.get("truncated"):
        sys.exit("the repository listing was truncated by GitHub; nothing was changed")
    out = {}
    for item in data["tree"]:
        if item["type"] != "blob":
            continue
        p = item["path"]
        for prefix, folder in DIRS:
            if p.startswith(prefix + "/"):
                out[folder + "/" + p[len(prefix) + 1:]] = item["sha"]
                break
        else:
            for src, dest in FILES:
                if p == src:
                    out[dest] = item["sha"]
    return out


def write(path, data):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    tmp = path + ".part"
    with open(tmp, "wb") as f:
        f.write(data)
    os.replace(tmp, path)


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--dest", default="/rool-drive", help="library root (default /rool-drive)")
    ap.add_argument("--branch", default="main", help="repository branch (default main)")
    ap.add_argument("--check", action="store_true", help="report only; write nothing")
    ap.add_argument("--quiet", action="store_true", help="totals only")
    args = ap.parse_args()

    dest = os.path.abspath(args.dest)
    state_path = os.path.join(dest, STATE_DIR, STATE_FILE)
    os.makedirs(os.path.dirname(state_path), exist_ok=True)

    previous = {}
    if os.path.exists(state_path):
        with open(state_path) as f:
            previous = json.load(f).get("files", {})

    try:
        current = listing(args.branch)
    except Exception as e:
        sys.exit(f"could not read the repository listing\n  {e}")

    def missing(rel):
        return not os.path.exists(os.path.join(dest, rel))

    new = sorted(p for p in current if p not in previous)
    changed = sorted(p for p in current
                     if p in previous and (previous[p] != current[p] or missing(p)))
    removed = sorted(p for p in previous if p not in current)
    todo = new + changed

    if args.check or not todo:
        summarise(new, changed, removed, len(current) - len(todo), args.check)
        if not args.check:
            return 0
        return 0

    print(f"downloading {len(todo)} of {len(current)} files from {REPO} @ {args.branch} ...")
    done, failed = 0, []
    t0 = time.time()

    def grab(rel):
        url = RAW.format(repo=REPO, branch=args.branch,
                         path=urllib.parse.quote(source_path(rel)))
        return rel, get_bytes(url)

    with cf.ThreadPoolExecutor(max_workers=16) as pool:
        futures = {pool.submit(grab, rel): rel for rel in todo}
        for fut in cf.as_completed(futures):
            rel = futures[fut]
            try:
                _, data = fut.result()
                write(os.path.join(dest, rel), data)
                done += 1
                if not args.quiet and done % 50 == 0:
                    print(f"  {done}/{len(todo)}", flush=True)
            except Exception as e:
                failed.append((rel, str(e)))

    for rel in removed:
        target = os.path.join(dest, rel)
        if os.path.exists(target):
            os.unlink(target)
            d = os.path.dirname(target)
            while os.path.abspath(d) != dest and os.path.isdir(d) and not os.listdir(d):
                os.rmdir(d)
                d = os.path.dirname(d)

    for rel, _ in failed:
        current.pop(rel, None)
    manifest = {"repo": REPO, "branch": args.branch, "files": current,
                "updated": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())}
    with open(state_path, "w") as f:
        json.dump(manifest, f, indent=1, sort_keys=True)

    if not args.quiet:
        print(f"  written in {time.time() - t0:.0f}s")
    summarise(new, changed, removed, len(current) - len(todo), False)

    if failed:
        optional = [f for f in failed if f[0] in (d for _, d in FILES)]
        for rel, err in optional:
            print(f"  note: {rel} could not be fetched ({err}); the data is "
                  f"installed but that tool must be copied by hand")
        failed = [f for f in failed if f not in optional]
    if failed:
        print(f"{len(failed)} file(s) could not be downloaded:")
        for rel, err in failed[:10]:
            print(f"  {rel}: {err}")
        print("run again to retry — the manifest was not updated")
        return 1
    return 0 if checks(dest) else 1


def source_path(rel):
    for src, d in FILES:          # exact files first: bible/expand.py is not
        if d == rel:              # dev/text/bible/expand.py
            return src
    for prefix, folder in DIRS:
        if rel.startswith(folder + "/"):
            return prefix + "/" + rel[len(folder) + 1:]
    raise KeyError(rel)


def summarise(new, changed, removed, same, check_only):
    if not new and not changed and not removed:
        print(f"already up to date — {same} files, nothing to do")
        return
    for label, group in (("new", new), ("changed", changed)):
        if not group:
            continue
        print(f"  {len(group)} {label}:")
        shown = [g for g in group if g.endswith((".txt", ".json"))] or group
        for rel in shown[:10]:
            print(f"    {'+' if label == 'new' else '~'} {rel}")
        if len(group) > 10:
            print(f"      ... and {len(group) - 10} more")
    for rel in removed[:10]:
        print(f"  - {rel} (gone from the repository)")
    if len(removed) > 10:
        print(f"      ... and {len(removed) - 10} more")
    print(("would write" if check_only else "wrote")
          + f" {len(new) + len(changed)}, deleted {len(removed)}; {same} unchanged")


def checks(dest):
    ok = True
    idx = os.path.join(dest, "ministry", "index.json")
    if os.path.exists(idx):
        with open(idx) as f:
            index = json.load(f)
        vols = len(index)
        arts = sum(len(v.get("articles", [])) for v in index.values())
        txt = sum(1 for root, _, fs in os.walk(os.path.join(dest, "ministry"))
                  for f in fs if f.endswith(".txt"))
        print(f"  ministry: {txt} text files, {vols} volumes, {arts} articles")
        if arts != 13448:
            print("    ! expected 13,448 articles; if new text has been added, "
                  "index.json needs regenerating in the repository")
            ok = False
        if vols and txt and txt - 1 != vols:
            print(f"    ! {txt} text files against {vols} volumes in index.json")
            ok = False
    script = os.path.join(dest, "hymns", "hymns.py")
    if os.path.exists(script):
        import subprocess
        r = subprocess.run([sys.executable, script, "--hymn", "272"],
                           capture_output=True, text=True)
        good = "When I survey" in r.stdout
        print("  hymns:", "272 resolves" if good else f"lookup failed ({r.stderr.strip()[:80]})")
        ok = ok and good
    exp = os.path.join(dest, "bible", "expand.py")
    if os.path.exists(exp):
        import subprocess
        r = subprocess.run([sys.executable, exp, "--trans", "Darby", "@John 3: 16"],
                           capture_output=True, text=True)
        good = "For God so loved" in r.stdout or "loved the world" in r.stdout
        print("  bible:", "John 3:16 resolves" if good else "expander failed")
        ok = ok and good
    return ok


if __name__ == "__main__":
    sys.exit(main())
