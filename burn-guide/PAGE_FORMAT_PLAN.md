# Page-Format Addendum — Implementation Plan

> **Status:** Draft for review · 2026-07-13
> **Purpose:** Extend the Burn design system with a **paginated US-Letter PDF
> page format**, borrowing *page mechanics only* from `Sample_C_Field_Manual.pdf`
> while keeping Burn's dark theme, tokens, and three-font identity locked.

---

## 1. What we're building (and why)

The Burn system (`burn-guide/`) currently targets **single-page, scrolling
HTML** — extracted from `psmf-protocol.html`. Its own implementation plan (§8)
explicitly deferred *"Print/PDF export"* as out of scope, with a note to flag
whether PDF output matters later. It does now.

This phase adds a **new documentation addendum** that specifies how a Burn sheet
migrates from screen HTML into a **paginated US-Letter PDF** — the "page format."
The high-level *paged-manual* conventions come from `Sample_C_Field_Manual.pdf`
(already extracted into the sibling `field-manual-guide` "Recon" system); Burn's
visual identity is untouched.

**This is a spec/prose deliverable only.** No `tokens.css` edits, no print
stylesheet, no converted sheet this phase. Where CSS appears, it is *illustrative
reference* the future workflow implements — consistent with how `STYLE_GUIDE.md`
shows component skeletons without building a pipeline.

---

## 2. Decisions locked (from alignment interview)

| Decision | Choice | Consequence for the plan |
|---|---|---|
| **Deliverable** | **Spec doc only** | One new markdown file; no working artifact yet. CSS shown is reference, not shipped. |
| **Visual borrowing** | **Page mechanics only** | Take cover / running header-footer / page numbers / section breaks / print margins from the PDF. Keep Burn's dark theme, tokens, and 3-font identity. |
| **Page size** | **US Letter** (8.5 × 11 in) | Geometry, margins, and `@page` model are Letter-specific. A4/configurable is out of scope. |
| **Content target** | **Generic format spec** | Content-agnostic. Validated abstractly against the 13-component catalog, not by converting a specific sheet. |

---

## 3. Deliverable & file structure

**New file:** `burn-guide/PAGE_FORMAT.md` — an addendum *beside*
`STYLE_GUIDE.md`, not a replacement.

```
burn-guide/
  IMPLEMENTATION_PLAN.md     # existing — the system's origin plan
  STYLE_GUIDE.md             # existing — the written spec (gets a 1-line pointer added)
  components.html            # existing — live gallery
  tokens.css                 # existing — variable system (UNCHANGED this phase)
  PAGE_FORMAT.md             # NEW — the paginated-PDF page-format addendum
```

> **Filename open call:** proposing `PAGE_FORMAT.md`. Alternatives if preferred:
> `PDF_ADDENDUM.md` or `PRINT.md`.

---

## 4. Proposed sections of `PAGE_FORMAT.md`

1. **Purpose & scope** — why this exists (Burn plan §8 deferral); what changes
   (add a paged output target) and what does *not* (theme, fonts, components, the
   860px `.wrap` → page-column mapping).
2. **What we borrow vs. what stays Burn** — an explicit table:
   - *Borrowed page mechanics:* cover page, running header/footer, page numbers,
     section page-breaks, print safe-margins, the "manual" paged feel.
   - *Locked Burn identity:* dark surfaces, effort/recover/warn accents, the
     Grotesk / Plex-Mono / Serif trio, dot-grid, single-column rhythm.
3. **Page geometry** — US Letter (8.5 × 11 in), margin/safe-area spec, single
   content column mapped from the existing 860px `.wrap`, and the `@page` model.
   Includes one **callout** flagging the ink/toner caveat of a dark full-bleed
   print (honoring the "keep dark theme" call; noting it is screen-PDF-first).
4. **Page furniture** — cover page, running header (doc title / current section),
   running footer (muted mono + page number, echoing Burn's existing footer), and
   how each maps onto the field-manual's banner/footer conventions *rendered in
   Burn's skin*.
5. **Pagination behavior, per component** — a table mapping each of Burn's 13
   components to a break rule:
   - *keep-together:* statline, macro-grid, calc-box, schedule strip, compare cards;
   - *breakable with repeated header:* data table;
   - *avoid orphaned openers:* section header via `break-after: avoid`.
6. **Reference print CSS** — illustrative `@page` / `@media print` snippets (page
   size, margins, `break-inside`, running elements, page counters), clearly
   marked as reference, not shipped code.
7. **Generation path** — browser print-to-PDF (Chrome) named as the reference
   method the format targets.
8. **Validation checklist** — how to confirm a Burn sheet paginates correctly:
   no split components, header/footer on every page, cover renders, section
   starts fall on breaks.
9. **Out of scope** — building the print stylesheet, converting a specific sheet,
   A4/configurable sizing, the generation pipeline. Cross-links to
   `STYLE_GUIDE.md` and the sibling `field-manual-guide` (source of the borrowed
   mechanics).

---

## 5. Execution steps

1. Isolate work in a worktree *(done)*.
2. Write `burn-guide/PAGE_FORMAT.md` per §4.
3. Add a one-line pointer to it from `STYLE_GUIDE.md`'s "Files in this system"
   table so the addendum is discoverable.
4. Commit, push the branch, open a draft PR.

---

## 6. Explicitly out of scope (this phase)

- Building the actual print stylesheet or editing `tokens.css`.
- Converting `psmf-protocol.html` / `client-30-day.html` into a real PDF.
- A4 or configurable page sizing (Letter only).
- The generation pipeline / any LLM-driven code.
- Reskinning Burn toward the field-manual "Recon" look (we borrow mechanics, not the skin).

---

## 7. What I need from you to proceed

- Sign-off on this plan (deliverable §3 + sections §4).
- The filename call (§3): `PAGE_FORMAT.md` as proposed, or an alternative.

On approval, I write `PAGE_FORMAT.md` and wire the pointer into `STYLE_GUIDE.md`.
