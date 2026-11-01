import os
import sys
from pypdf import PdfWriter

src_dir = r"E:\Nexucentri_Extract_Temp"
out_path = r"E:\Nexucentri_Mailers_Combined.pdf"

pdfs = []
for root, _, files in os.walk(src_dir):
    for f in files:
        if f.lower().endswith(".pdf"):
            pdfs.append(os.path.join(root, f))

pdfs.sort(key=lambda p: os.path.basename(p).lower())
print(f"Merging {len(pdfs)} PDFs in alphabetical order...")

writer = PdfWriter()
for i, p in enumerate(pdfs, 1):
    try:
        writer.append(p)
    except Exception as e:
        print(f"  WARN: failed on {os.path.basename(p)}: {e}", file=sys.stderr)
    if i % 50 == 0:
        print(f"  ...added {i}/{len(pdfs)}")

with open(out_path, "wb") as f:
    writer.write(f)
writer.close()

size_mb = os.path.getsize(out_path) / (1024 * 1024)
print(f"\nDone! Output: {out_path}")
print(f"Size: {size_mb:.2f} MB")
