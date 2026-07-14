# `client-30-day.html` → PDF Plan

First real application of `burn-guide/PAGE_FORMAT.md`. Decisions locked by interview:

| Decision | Choice |
|---|---|
| Generation path | **Paged.js + headless Chrome** (via `pagedjs-cli`) — the only Chrome-based path that honors the spec's `@page` margin boxes, `string-set`, and page counters |
| Page breaks | **One day per page** — every section starts a fresh sheet |
| Where the format lives | **`burn-guide/print.css` + a build script**, injected into a temp copy at conversion time; `client-30-day.html` stays untouched per the PAGE_FORMAT scope rule |
| Committed deliverables | **Tooling + the generated `client-30-day.pdf`** |

---

## 1. Deliverables

| File | What it is |
|---|---|
| `burn-guide/print.css` | The Burn print stylesheet — implements PAGE_FORMAT §3–§6, reads only existing tokens. Sheet-agnostic: reusable for `psmf-protocol.html` later. |
| `burn-guide/build-pdf.sh` | Conversion script: `./build-pdf.sh <sheet.html> <out.pdf>`. Copies the sheet to a temp dir, injects `<link rel="stylesheet" href="print.css">` before `</head>`, runs `npx pagedjs-cli` on the copy, writes the PDF. Never modifies the source HTML. |
| `client-30-day.pdf` | The committed output (repo root, next to its source). |

No edits to `client-30-day.html`, `tokens.css`, or any burn-guide doc.

## 2. Page geometry & furniture (PAGE_FORMAT §3–§4)

- `@page { size: letter; margin: 0.5in; }`, portrait, single column. The `.wrap` column fills the ~7.5in printable width naturally (its 860px cap only binds on wider screens).
- **Cover (page 1):** the first `<section>` (hero tag chip + H1 + statline) owns the page — flex-centered vertically, `break-after: page`, no header/footer (`@page :first` blanks all four margin boxes).
- **Running header:** mono, `--text-mute`, uppercase, wide-tracked. Left = `30-DAY FAT LOSS`. Right = the current section's **eyebrow text** via `string-set` (e.g. `Day 4 — Portion the meat`).
  - ⚠ **Deliberate deviation from §6's reference CSS**, which string-sets the H2. This sheet's H2s are full sentences ("Open today's day. Do it. Close the page.") — unusable as running furniture. The eyebrow is the short section name §4.2 intends. Flagged here so it's a decision, not a drift.
- **Running footer:** left = `30-DAY FAT LOSS · DAILY PROTOCOL` (echoes the sheet's footer line); right = `Page N` via the page counter. Target: first content page reads **Page 1** (counter reset after the cover); if Paged.js fights the reset, fall back to content starting at Page 2 — cosmetic either way.
- **Dark theme:** `print-color-adjust: exact` everywhere; page background = `var(--bg)`. The fixed dot-grid (`body::before`) won't tile across pages, so **disable it and reattach the same radial-gradient per page on Paged.js's `.pagedjs_page` boxes** — keeps the signature texture, uses the option §6's note explicitly allows. If it bands or bloats the file, drop to plain `var(--bg)`.

## 3. Break rules for this sheet (PAGE_FORMAT §5)

- `section { break-before: page; }` — one day per page: cover, 00 How-to, Day 0–7, Milestone, Weeks 2–4 ≈ **13 pages**. Sections that start a page drop their top border/padding (the page edge separates them).
- Long sections (00's five rules, Day 0's three tasks) may overflow to a second sheet — allowed; the keep-rules below govern where they cut.
- Component rules present in this sheet:
  - keep whole: `.statline`, `.callout`, `.compare-grid` (+ its `.arrow-note`), each `.tl-stage`, each `.chip`, each `.task` (a checkbox circle must never separate from its text);
  - `.eyebrow`, `h2`, `.lead` → `break-after: avoid` (no orphaned openers);
  - Day 4's table: breakable, `thead { display: table-header-group; }` so the header repeats (likely fits one page anyway);
  - the closing `<footer>` line sits on the last page; the running footer carries the per-page furniture.

## 4. Build mechanics & gotchas

- `pagedjs-cli` (Puppeteer + Paged.js polyfill) — no repo `package.json` needed; invoked via `npx`.
- `print.css` rules ship **unwrapped** (no `@media print` block): the file only ever exists in the injected temp copy, and Paged.js paginates in screen media, where an `@media print` wrapper would be skipped.
- Fonts load from Google Fonts via `@import` — the build needs network. Verify all three faces render in the PDF (missing webfonts fail silently to system fonts).

## 5. Order of work

1. Write `burn-guide/print.css` (geometry → furniture → break rules → dark-theme/dot-grid).
2. Write `burn-guide/build-pdf.sh`; run it on `client-30-day.html`.
3. Iterate against the PAGE_FORMAT §8 checklist (below), inspecting the PDF page by page.
4. Commit `print.css`, `build-pdf.sh`, `client-30-day.pdf`.

## 6. Validation (PAGE_FORMAT §8, made concrete)

- [ ] Cover: hero + statline alone, centered, zero furniture; content starts on the next page.
- [ ] Header shows `30-DAY FAT LOSS` + the correct eyebrow on every content page (spot-check Day 4 and Weeks 2–4).
- [ ] Footer shows the closing line + sequential page numbers from the first content page.
- [ ] Every section starts a fresh page; no eyebrow/H2 orphaned at a page bottom.
- [ ] No task circle, callout, compare pair, statline, timeline stage, or chip split across pages.
- [ ] Dark theme + dot grid survive on every page; all three fonts render.
- [ ] Letter size, 0.5in margins, ~13 pages.
