#!/usr/bin/env python3
"""
pdf_to_tiff.py - extract the scanned page images from a PDF as TIFFs,
without re-sampling, re-scaling, or re-compressing the picture data.

Why this differs from most "PDF to image" tools
-----------------------------------------------
A scanned PDF is just a container: each page holds one embedded raster image
(JPEG, CCITT G4, JBIG2, JPEG2000, or Flate). Tools like Nitro often *render*
the page to a bitmap at some chosen DPI, which resamples the original pixels
and usually re-encodes them lossily. This script instead pulls the embedded
image stream out byte-for-byte and rewrites it into a TIFF container with
lossless compression, so the pixel grid is exactly the scanner's original.

DPI is not stored in the image itself inside a PDF - it is implied by how big
the image is drawn on the page. This script computes it:

    dpi_x = pixel_width  / (drawn_width_in_points  / 72)

and writes that into the TIFF's XResolution/YResolution tags.

Usage
-----
    python pdf_to_tiff.py scan.pdf -o out/
    python pdf_to_tiff.py scan.pdf -o out/ --multipage        # one .tif, many pages
    python pdf_to_tiff.py scan.pdf -o out/ --native           # keep original bytes (.jpg/.jp2/...)
    python pdf_to_tiff.py scan.pdf -o out/ --compression none
    python pdf_to_tiff.py scan.pdf -o out/ --render --dpi 600 # fallback: rasterise pages
    python pdf_to_tiff.py scan.pdf --report                   # inspect only, write nothing

Requires: pip install pymupdf pillow
"""

from __future__ import annotations

import argparse
import io
import os
import sys
from dataclasses import dataclass, field

try:
    import pymupdf as fitz
except ImportError:  # older wheels
    import fitz

from PIL import Image, features

Image.MAX_IMAGE_PIXELS = None  # scans of large formats are legitimately huge


# --------------------------------------------------------------------------
# data model
# --------------------------------------------------------------------------

@dataclass
class PageImage:
    page_index: int          # 0-based
    seq: int                 # nth image on that page
    xref: int
    image: Image.Image
    dpi: tuple[float, float]
    src_format: str          # what the PDF actually stored
    raw: bytes | None        # original stream bytes, if extractable
    notes: list[str] = field(default_factory=list)

    @property
    def label(self) -> str:
        return f"p{self.page_index + 1:04d}" + (f"_{self.seq}" if self.seq else "")


# --------------------------------------------------------------------------
# extraction
# --------------------------------------------------------------------------

def _dpi_for(page: fitz.Page, xref: int, px_w: int, px_h: int,
             fallback: float) -> tuple[tuple[float, float], list[str]]:
    """Work out the effective DPI from how large the image is drawn."""
    notes: list[str] = []
    try:
        rects = page.get_image_rects(xref)
    except Exception:
        rects = []

    if not rects:
        notes.append(f"image not placed on page; assuming {fallback} dpi")
        return (fallback, fallback), notes

    if len(rects) > 1:
        notes.append(f"drawn {len(rects)} times; using the largest placement")
    rect = max(rects, key=lambda r: abs(r.width * r.height))

    w_in = abs(rect.width) / 72.0
    h_in = abs(rect.height) / 72.0
    if w_in <= 0 or h_in <= 0:
        return (fallback, fallback), notes + ["degenerate placement rectangle"]

    dpi_x, dpi_y = px_w / w_in, px_h / h_in

    # Scanners produce integer DPI; snap to it when we're within rounding noise
    # of a whole number so we don't write 299.97.
    dpi_x, dpi_y = _snap(dpi_x), _snap(dpi_y)

    if abs(dpi_x - dpi_y) / max(dpi_x, dpi_y) > 0.01:
        notes.append(f"non-square pixels: {dpi_x:g}x{dpi_y:g} dpi")
    return (dpi_x, dpi_y), notes


def _snap(v: float, tol: float = 0.02) -> float:
    r = round(v)
    return float(r) if r and abs(v - r) / r < tol else round(v, 2)


def _decode(doc: fitz.Document, xref: int, info: dict) -> tuple[Image.Image, list[str]]:
    """Decode an embedded image to a PIL image without resampling it."""
    notes: list[str] = []
    raw, ext = info.get("image"), (info.get("ext") or "").lower()

    if raw:
        try:
            im = Image.open(io.BytesIO(raw))
            im.load()
            return im, notes
        except Exception as exc:
            notes.append(f"Pillow could not read embedded {ext or '?'} ({exc}); "
                         "decoded via PyMuPDF instead")

    # JBIG2 / JPX / exotic colourspaces: let MuPDF decode to raw samples.
    pix = fitz.Pixmap(doc, xref)
    try:
        if pix.alpha:                       # drop alpha, scans don't need it
            pix = fitz.Pixmap(pix, 0)
        if pix.colorspace is None:
            mode = "L"
        elif pix.colorspace.n == 1:
            mode = "L"
        elif pix.colorspace.n == 3:
            mode = "RGB"
        elif pix.colorspace.n == 4:
            mode = "CMYK"
        else:
            pix = fitz.Pixmap(fitz.csRGB, pix)
            mode = "RGB"
            notes.append("converted unusual colourspace to RGB")
        im = Image.frombytes(mode, (pix.width, pix.height), pix.samples)
    finally:
        pix = None

    # A 1-bit original decoded to 8-bit grey is still lossless; put it back to
    # 1-bit so the TIFF is small and Group 4 compressible.
    if info.get("bpc") == 1 and im.mode == "L":
        im = im.convert("1", dither=Image.NONE)
    return im, notes


def extract(doc: fitz.Document, pages: range | list[int],
            fallback_dpi: float, smallest_px: int) -> list[PageImage]:
    out: list[PageImage] = []
    for pno in pages:
        page = doc[pno]
        seq = 0
        for entry in page.get_images(full=True):
            xref = entry[0]
            try:
                info = doc.extract_image(xref)
            except Exception as exc:
                print(f"  ! page {pno+1}: xref {xref} unreadable ({exc})",
                      file=sys.stderr)
                continue

            if min(info.get("width", 0), info.get("height", 0)) < smallest_px:
                continue  # logo, signature stamp, scanner artefact

            try:
                im, notes = _decode(doc, xref, info)
            except Exception as exc:
                print(f"  ! page {pno+1}: could not decode xref {xref} ({exc})",
                      file=sys.stderr)
                continue

            dpi, dnotes = _dpi_for(page, xref, im.width, im.height, fallback_dpi)
            out.append(PageImage(pno, seq, xref, im, dpi,
                                 (info.get("ext") or "?").lower(),
                                 info.get("image"), notes + dnotes))
            seq += 1

        if seq == 0:
            print(f"  ! page {pno+1}: no embedded image found "
                  "(vector or text page?) - use --render for this one",
                  file=sys.stderr)
    return out


def render(doc: fitz.Document, pages: range | list[int], dpi: float) -> list[PageImage]:
    """Fallback: rasterise whole pages. Lossless only in the sense that nothing
    is JPEG-ed; the pixel grid is synthesised, not the scanner's."""
    out = []
    for pno in pages:
        pix = doc[pno].get_pixmap(dpi=int(dpi), alpha=False)
        mode = "RGB" if pix.n >= 3 else "L"
        im = Image.frombytes(mode, (pix.width, pix.height), pix.samples)
        out.append(PageImage(pno, 0, -1, im, (dpi, dpi), "rendered", None,
                             ["rasterised page, not the embedded scan"]))
    return out


# --------------------------------------------------------------------------
# writing
# --------------------------------------------------------------------------

def _tiff_opts(im: Image.Image, want: str) -> dict:
    """Pick a lossless TIFF compressor appropriate to the bit depth."""
    if want == "auto":
        comp = "group4" if im.mode == "1" else "tiff_lzw"
    elif want == "none":
        comp = "raw"
    else:
        comp = want

    if comp == "group4" and im.mode != "1":
        comp = "tiff_lzw"                       # G4 is bilevel-only
    if comp == "tiff_adobe_deflate" and not features.check("zlib"):
        comp = "tiff_lzw"
    return {"compression": comp}


def write_singles(imgs: list[PageImage], outdir: str, stem: str,
                  compression: str, native: bool,
                  jpeg_quality: int | None = None,
                  max_dim: int | None = None) -> list[str]:
    os.makedirs(outdir, exist_ok=True)
    written = []
    for pi in imgs:
        if native and pi.raw:
            path = os.path.join(outdir, f"{stem}_{pi.label}.{pi.src_format}")
            with open(path, "wb") as fh:
                fh.write(pi.raw)
        elif jpeg_quality is not None:
            im = pi.image
            if im.mode not in ("RGB", "L"):
                im = im.convert("L" if im.mode in ("1", "I;16") else "RGB")
            if max_dim and max(im.size) > max_dim:
                s = max_dim / max(im.size)
                im = im.resize((round(im.width * s), round(im.height * s)),
                               Image.LANCZOS)
                pi.dpi = (pi.dpi[0] * s, pi.dpi[1] * s)
            path = os.path.join(outdir, f"{stem}_{pi.label}.jpg")
            im.save(path, format="JPEG", quality=jpeg_quality,
                    subsampling=0,           # no chroma loss on fine text
                    optimize=True, dpi=tuple(round(d) for d in pi.dpi))
        else:
            path = os.path.join(outdir, f"{stem}_{pi.label}.tif")
            pi.image.save(path, format="TIFF", dpi=pi.dpi,
                          **_tiff_opts(pi.image, compression))
        written.append(path)
    return written


def write_multipage(imgs: list[PageImage], outdir: str, stem: str,
                    compression: str) -> str:
    os.makedirs(outdir, exist_ok=True)
    path = os.path.join(outdir, f"{stem}.tif")
    first, rest = imgs[0], [p.image for p in imgs[1:]]

    # Give each frame its own resolution tags rather than inheriting page 1's.
    for pi in imgs:
        pi.image.encoderinfo = {"dpi": pi.dpi, **_tiff_opts(pi.image, compression)}
        pi.image.encoderconfig = ()

    first.image.save(path, format="TIFF", save_all=True, append_images=rest,
                     dpi=first.dpi, **_tiff_opts(first.image, compression))
    return path


# --------------------------------------------------------------------------
# cli
# --------------------------------------------------------------------------

def parse_pages(spec: str | None, n: int) -> list[int]:
    if not spec:
        return list(range(n))
    out: list[int] = []
    for part in spec.split(","):
        part = part.strip()
        if "-" in part:
            a, b = part.split("-", 1)
            out.extend(range(int(a) - 1, int(b)))
        elif part:
            out.append(int(part) - 1)
    return [p for p in out if 0 <= p < n]


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        description="Extract scanned page images from a PDF as TIFF, preserving "
                    "the original resolution, pixel data and DPI.")
    ap.add_argument("pdf")
    ap.add_argument("-o", "--outdir", default=".", help="output directory")
    ap.add_argument("-p", "--pages", help="e.g. 1-10,15,20-  (1-based)")
    ap.add_argument("--password", help="password for an encrypted PDF")
    ap.add_argument("--multipage", action="store_true",
                    help="write one multi-page TIFF instead of one file per page")
    ap.add_argument("--native", action="store_true",
                    help="write the untouched embedded stream (.jpg/.jp2/.png) "
                         "instead of a TIFF - the only truly byte-identical option")
    ap.add_argument("--compression", default="auto",
                    choices=["auto", "group4", "tiff_lzw",
                             "tiff_adobe_deflate", "none"],
                    help="TIFF compressor; all choices are lossless (default: "
                         "auto = G4 for bilevel, LZW otherwise)")
    ap.add_argument("--jpeg", nargs="?", type=int, const=92, default=None,
                    metavar="QUALITY",
                    help="write JPEGs at this quality (default 92, 4:4:4 chroma) "
                         "instead of TIFF. Note: if the PDF already stores JPEGs, "
                         "--native is both smaller and completely lossless - "
                         "prefer it. Use --jpeg only to shrink Flate/TIFF-sourced "
                         "scans or alongside --max-dim.")
    ap.add_argument("--max-dim", type=int, default=None,
                    help="with --jpeg, downscale so the long edge is at most this "
                         "many pixels (DPI tag is adjusted to match)")
    ap.add_argument("--render", action="store_true",
                    help="rasterise pages instead of extracting embedded images")
    ap.add_argument("--dpi", type=float, default=300.0,
                    help="DPI for --render, and the assumed DPI when an image's "
                         "placement on the page cannot be determined")
    ap.add_argument("--min-size", type=int, default=100,
                    help="ignore embedded images smaller than this many pixels "
                         "on their short side (default: 100)")
    ap.add_argument("--report", action="store_true",
                    help="print what was found and exit without writing files")
    a = ap.parse_args(argv)

    doc = fitz.open(a.pdf)
    if doc.needs_pass and not doc.authenticate(a.password or ""):
        print("error: PDF is password protected; pass --password", file=sys.stderr)
        return 2

    pages = parse_pages(a.pages, doc.page_count)
    print(f"{os.path.basename(a.pdf)}: {doc.page_count} pages, processing {len(pages)}")

    imgs = render(doc, pages, a.dpi) if a.render \
        else extract(doc, pages, a.dpi, a.min_size)
    if not imgs:
        print("nothing extracted - try --render", file=sys.stderr)
        return 1

    for pi in imgs:
        mp = pi.image.width * pi.image.height / 1e6
        print(f"  page {pi.page_index+1:>4}  {pi.image.width}x{pi.image.height}"
              f" ({mp:.1f} MP)  {pi.dpi[0]:g}x{pi.dpi[1]:g} dpi"
              f"  {pi.image.mode:<4} from {pi.src_format}")
        for n in pi.notes:
            print(f"           - {n}")

    if a.report:
        return 0

    stem = os.path.splitext(os.path.basename(a.pdf))[0]
    if a.native and any(p.raw and p.src_format == "jpeg" for p in imgs):
        print("note: pages are stored as JPEG - writing the original streams "
              "untouched (no decode, no re-encode)")

    if a.multipage and not a.native and a.jpeg is None:
        print(f"\nwrote {write_multipage(imgs, a.outdir, stem, a.compression)}"
              f" ({len(imgs)} pages)")
    else:
        if a.multipage:
            print("note: --native/--jpeg override --multipage", file=sys.stderr)
        files = write_singles(imgs, a.outdir, stem, a.compression, a.native,
                              a.jpeg, a.max_dim)
        total = sum(os.path.getsize(f) for f in files)
        print(f"\nwrote {len(files)} files to {os.path.abspath(a.outdir)}"
              f"  ({total/1e6:.1f} MB)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
