#!/usr/bin/env bash
# Field Manual sheet → paginated US-Letter PDF.
#
#   Usage: ./build-pdf.sh <sheet.html> <out.pdf>
#
# Copies the sheet to a temp dir, injects print.css (which the screen
# HTML must never carry — same scope rule as burn-guide), and paginates
# via Paged.js (pagedjs-cli: Paged.js + headless Chrome). Requires
# network for the sheet's Google Fonts @import.
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "usage: $0 <sheet.html> <out.pdf>" >&2
  exit 1
fi

sheet="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
out="$(cd "$(dirname "$2")" && pwd)/$(basename "$2")"
guide_dir="$(cd "$(dirname "$0")" && pwd)"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

cp "$sheet" "$tmp/sheet.html"
cp "$guide_dir/print.css" "$tmp/print.css"
perl -i -pe 's|</head>|<link rel="stylesheet" href="print.css">\n</head>|' "$tmp/sheet.html"

npx -y pagedjs-cli "$tmp/sheet.html" -o "$out"
echo "wrote $out"
