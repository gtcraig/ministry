#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Update the magazine JSON on the "magazine" branch.

  1. checks there are no uncommitted changes to tracked files
  2. switches to the "magazine" branch (creating it from the current branch if
     it does not exist yet, or tracking origin/magazine if that exists)
  3. runs build_magazines.py, which builds any issue that has no JSON yet
  4. commits the new/changed files in dev/text/magazines
  5. switches back to the branch you started on (unless --stay)

Usage (from anywhere):
    python dev\\scripts\\update_magazines.py
    python dev\\scripts\\update_magazines.py --push
    python dev\\scripts\\update_magazines.py --changed      # also rebuild issues whose EPUB changed
    python dev\\scripts\\update_magazines.py --issue 67     # prefix the commit message with #67

Any options not listed below are passed on to build_magazines.py
(e.g. --library "D:\\Calibre Library", --all, --ids 458).
"""

import argparse
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parent.parent
MAG_DIR = 'dev/text/magazines'


def git(*args, check=True, capture=True):
    r = subprocess.run(['git', *args], cwd=REPO, text=True,
                       stdout=subprocess.PIPE if capture else None,
                       stderr=subprocess.PIPE if capture else None)
    if check and r.returncode != 0:
        sys.exit(f"git {' '.join(args)} failed:\n{(r.stderr or '').strip()}")
    return (r.stdout or '').strip()


def branch_exists(ref):
    return subprocess.run(['git', 'rev-parse', '--verify', '--quiet', ref], cwd=REPO,
                          stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL).returncode == 0


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--branch', default='magazine', help='branch to build on (default: magazine)')
    ap.add_argument('--issue', help='GitHub issue number to prefix the commit message with')
    ap.add_argument('--push', action='store_true', help='push the branch after committing')
    ap.add_argument('--stay', action='store_true', help='stay on the magazine branch afterwards')
    a, build_args = ap.parse_known_args()

    start = git('rev-parse', '--abbrev-ref', 'HEAD')
    if git('status', '--porcelain', '--untracked-files=no'):
        sys.exit('You have uncommitted changes to tracked files - commit or stash them first.')

    # fetch quietly; carry on if offline
    subprocess.run(['git', 'fetch', '--quiet', 'origin'], cwd=REPO)

    b = a.branch
    if start != b:
        if branch_exists(b):
            git('checkout', '--quiet', b)
        elif branch_exists(f'origin/{b}'):
            git('checkout', '--quiet', '--track', f'origin/{b}')
        else:
            print(f"Creating branch '{b}' from '{start}'")
            git('checkout', '--quiet', '-b', b)
    if branch_exists(f'origin/{b}'):
        subprocess.run(['git', 'merge', '--ff-only', '--quiet', f'origin/{b}'], cwd=REPO)
    print(f'On branch {b}')

    builder = REPO / 'dev' / 'scripts' / 'build_magazines.py'
    if not builder.exists():
        if start != b:
            git('checkout', '--quiet', start)
        sys.exit(f"{builder} is not on branch '{b}' - merge the branch that adds it first.")
    rc = subprocess.run([sys.executable, str(builder), '--quiet', *build_args], cwd=REPO).returncode

    git('add', '--all', MAG_DIR)
    staged = [f for f in git('diff', '--cached', '--name-only', '--', MAG_DIR).splitlines() if f]
    if staged:
        jsons = [Path(f).stem for f in staged if f.endswith('.json')]
        title = f"Add/update {len(jsons)} magazine JSON file{'s' if len(jsons) != 1 else ''} from calibre"
        if a.issue:
            title = f'#{a.issue.lstrip("#")} {title}'
        body = ', '.join(sorted(jsons)) if jsons else ''
        msg = title + ('\n\n' + body if body else '')
        git('commit', '--quiet', '-m', msg)
        print(f'Committed: {title}')
        if a.push:
            git('push', '--quiet', '-u', 'origin', b, capture=False)
            print(f'Pushed {b} to origin')
    else:
        print('Nothing new to commit.')

    if start != b and not a.stay:
        git('checkout', '--quiet', start)
        print(f'Back on {start}')
    if rc:
        print('The build reported problems (see above); whatever did build was committed.')
    return rc


if __name__ == '__main__':
    sys.exit(main())
