# Page Format — PDF Addendum

> **Addendum to `STYLE_GUIDE.md`.** This document adds one output target to the
> Burn system: a **paginated US-Letter PDF**. It does *not* change Burn's theme,
> tokens, fonts, or components — it defines how the existing screen HTML
> **migrates to fixed pages**, borrowing *page mechanics only* from
> `Sample_C_Field_Manual.pdf` (extracted in the sibling `field-manual-guide`).
>
> **Status:** spec only. No `tokens.css` edits and no print stylesheet ship in
> this phase. CSS shown below is *reference* the future workflow implements —
> the same convention `STYLE_GUIDE.md` uses for component skeletons.
>
> **Scope — read this first.** This format is **opt-in and applied only when a
> PDF is explicitly requested.** The screen HTML (`psmf-protocol.html`,
> `client-30-day.html`, `components.html`) stays a single scrolling page and
> must carry **none** of this — no `@page`, no `@media print`, no `break-*`
> rules baked into a sheet. Everything here activates only at HTML→PDF
> conversion time, on request. If you are not converting to PDF, this document
> does not apply.

---

## 1. Purpose & scope

The Burn system was extracted from `psmf-protocol.html` as a **single-page,
scrolling** deliverable. Its origin plan (`IMPLEMENTATION_PLAN.md` §8) listed
*"Print/PDF export"* as out of scope, with a note to decide later whether PDF
output matters. It does now — sheets need to be handed off, printed, and read as
discrete **pages**, not an infinite scroll.

**This addendum changes exactly one thing:** it adds a **page format** — the
rules that turn a continuous Burn sheet into fixed US-Letter pages with a cover,
running header/footer, page numbers, and controlled breaks.

**It changes nothing else.** The following stay *exactly* as `STYLE_GUIDE.md`
defines them:

- the **theme** (dark surfaces, the three accents, the dot-grid);
- the **three-font trio** (Space Grotesk / IBM Plex Mono / Source Serif 4);
- every **component** and the **eyebrow → H2 → lead** section rhythm;
- the **860px content column** (`.wrap`) — it maps onto the page's content area,
  it is not redesigned.

We borrow the *paged-manual feel* of the field manual — its cover, its running
furniture, its page discipline — **not** its skin (no navy bands, no amber, no
single-accent rule). Burn stays Burn; it just paginates.

---

## 2. What we borrow vs. what stays Burn

| Borrowed page mechanics (from the field-manual PDF) | Locked Burn identity (unchanged) |
|---|---|
| Fixed **US-Letter** page geometry + print safe-margins | Dark surface ramp (`--bg` → `--line`) |
| A **cover page** (title sheet before the content) | The three accents & their semantic roles |
| **Running header** (doc title / current section) | Space Grotesk / Plex-Mono / Serif trio |
| **Running footer** + **page numbers** | Dot-grid background, 860px `.wrap` column |
| **Section page-breaks** (new section ⇒ new page, when it fits the rhythm) | Every component's markup & the section rhythm |
| The **"manual" reading discipline** — discrete, numbered pages | Effort/recover/warn meaning; serif-once-per-section |

**Rule of thumb:** if it's about *where the paper cuts and what repeats on every
sheet*, we take it from the manual. If it's about *color, type, or component
shape*, it stays Burn.

---

## 3. Page geometry (US Letter)

- **Page size:** US Letter — **8.5 × 11 in** (`@page { size: letter; }`).
- **Orientation:** portrait (single-column, matching Burn).
- **Print margins:** **0.5 in** on all four physical edges — the browser/`@page`
  margin box. This is where running header/footer live.
- **Content safe-area:** the Burn `.wrap` column (max 860px) centers inside the
  margin box. On Letter, the printable width (~7.5in ≈ 720px at 96dpi) is *below*
  860px, so the column **fills the page width** minus a small inner gutter rather
  than reserving 860px — the 860px cap only matters on wider screens.
- **Vertical rhythm:** Burn's ~56px section padding and 1px `--line` separators
  carry over; a section that starts a new page drops its top border (the page
  edge already separates it).

> **⚠ Reassess — dark ink on paper.**
> Burn is a dark theme. On screen and in a *screen-read* PDF this is the intended
> look and needs `print-color-adjust: exact` so browsers don't strip the dark
> fills. On a **physical printer** a full-bleed dark page is heavy on toner and
> can band. Per the locked decision we keep the dark theme; treat this format as
> **screen-PDF-first**. A future light "print" theme, if ever needed, is a
> `tokens.css` theme-block swap (see `STYLE_GUIDE.md` §2.2) — out of scope here.

---

## 4. Page furniture

Three repeating elements frame every content page. Each is Burn-skinned (mono,
muted) but positioned by the manual's conventions.

### 4.1 Cover page
A dedicated first sheet, no running furniture, that carries the **Hero**
(component 01) alone — tag chip, H1 with its `<em>` accent, serif subhead, and
the statline — vertically centered on the page. The content proper starts on
page 2. This mirrors the field manual opening on its wordmark hero before any
section.

### 4.2 Running header
Top margin box, **mono, `--text-mute`, uppercase, wide-tracked** (matching Burn
eyebrows). Left = the sheet's short title; right = the **current section name**
(the H2 of the section in view). Suppressed on the cover.

### 4.3 Running footer + page number
Bottom margin box, mono `--text-mute`, echoing Burn's existing **Footer**
(component 13). Left = the muted closing/attribution line; right = **`Page N`**
via CSS page counters. Suppressed on the cover; page numbering starts at the
first content page.

---

## 5. Pagination behavior, per component

The core of the format: how each of Burn's 13 components behaves at a page edge.
Default is *keep the component whole*; only long, list-like blocks may split.

| # | Component | Break rule |
|---|---|---|
| 01 | Hero | **Cover only.** Never mid-content; owns the cover page. |
| 02 | Statline | **Keep together** — never split the metric strip. |
| 03 | Section Header | `break-after: avoid` — never orphan an eyebrow/H2 at a page bottom; pull it to the next page with its lead. Optionally `break-before: page` to start major sections on a fresh sheet. |
| 04 | Macro Cards | **Keep the grid together**; if it can't fit, break *between* card rows, never through a card. |
| 05 | Calc Box | **Keep together** — the value and its derivation must stay on one page. |
| 06 | Data Table | **Breakable** — the one component allowed to span pages. Repeat `<thead>` on each page (`display: table-header-group`); keep `tr.totals` with the rows above it (`break-before: avoid`). |
| 07 | Table Tag | Inline; never a break subject. |
| 08 | Two-Card Compare | **Keep the pair together** so the contrast reads at a glance; keep the `.arrow-note` with them. |
| 09 | Schedule Strip | **Keep together** with its legend — the signature grid must never split across a page. |
| 10 | Timeline | **Breakable between stages** (`break-inside: avoid` on each `tl-stage`), never through a stage's node. |
| 11 | Callout | **Keep together** — a warning split across pages loses its force. |
| 12 | Chip List | **Breakable between chips**; never split a single chip. |
| 13 | Footer | Runs as the **running footer** (§4.3); the standalone closing line sits on the last page. |

**One governing rule:** a component only splits if it is *inherently a list*
(Data Table rows, Timeline stages, Chip List items). Everything that reads as a
single unit — hero, statline, cards, calc, compare, schedule, callout — stays
whole, even if that pushes it to the next page.

---

## 6. Reference print CSS *(illustrative — not shipped this phase)*

The future workflow implements roughly this. It reads only through existing Burn
variables; no new theme tokens are introduced.

```css
@media print {
  @page {
    size: letter;              /* 8.5 x 11 in, portrait */
    margin: 0.5in;
    /* running header */
    @top-left    { content: "PSMF PROTOCOL"; }
    @top-right   { content: string(section); }
    /* running footer + page number */
    @bottom-left  { content: "BURN · CONFIDENTIAL"; }
    @bottom-right { content: "Page " counter(page); }
  }
  @page :first {                /* cover: no furniture */
    @top-left { content: ""; } @top-right { content: ""; }
    @bottom-left { content: ""; } @bottom-right { content: ""; }
  }

  html, body { background: var(--bg); }
  * { -webkit-print-color-adjust: exact; print-color-adjust: exact; }

  h2 { string-set: section content(); }   /* feeds the running header */

  /* Cover owns the hero */
  .hero { break-after: page; }

  /* Keep-together units */
  .statline, .macro-grid, .calc-box, .compare-grid,
  .schedule, .callout { break-inside: avoid; }

  /* Section openers never orphaned */
  .eyebrow, h2, .lead { break-after: avoid; }
  section { break-before: page; }          /* major sections start fresh */

  /* The breakable list-like blocks */
  table { break-inside: auto; }
  thead { display: table-header-group; }   /* repeat header each page */
  tr.totals { break-before: avoid; }
  .tl-stage, .chip { break-inside: avoid; }

  /* Screen-only chrome off in print */
  body::before { display: none; }          /* fixed dot-grid → static or off */
}
```

> Notes: the fixed 48px dot-grid (`body::before`) is a *fixed* background and
> won't tile across printed pages — either disable it in print (shown) or
> reattach it per-page if the texture is wanted. `string-set` / margin-box
> `content()` are the mechanism that puts the live section name in the header.

---

## 7. Generation path

The reference method is **browser print-to-PDF**: open the Burn sheet in Chrome →
Print → *Save as PDF*, with **Letter** size, **Default** margins overridden by
the `@page` rule, and **Background graphics ON** (required — otherwise the dark
theme prints white). Chrome honors `@page size`, `break-*`, `thead` repetition,
and page counters. Headless Chrome (`--print-to-pdf`) is the automatable form of
the same path for the future workflow.

---

## 8. Validation checklist

A Burn sheet is correctly paginated when:

- [ ] **Cover** renders alone — hero centered, no header/footer, content starts p.2.
- [ ] **Running header** shows the doc title + the correct *current* section on every content page.
- [ ] **Running footer** shows the closing line + `Page N`, numbering from the first content page.
- [ ] **No keep-together component is split** — statline, macro cards, calc box, compare pair, schedule strip, callout each sit whole on one page.
- [ ] **Data tables that span pages repeat their header row**, and totals stay attached to their rows.
- [ ] **No orphaned section openers** — an eyebrow/H2 never sits alone at a page bottom.
- [ ] **Dark theme survives print** (backgrounds on; `print-color-adjust: exact`).
- [ ] Page size is **Letter**, margins ~0.5in, single column.

---

## 9. Out of scope (this phase)

- Building the actual print stylesheet or editing `tokens.css`.
- Converting a specific sheet (`psmf-protocol.html`, `client-30-day.html`) to PDF.
- **A4** or configurable page sizing — Letter only.
- A dedicated **light "print" theme** (would be a `tokens.css` theme-block swap).
- The generation pipeline / any LLM-driven code.
- Reskinning Burn toward the field-manual "Recon" look — we borrow *mechanics,
  not skin*.

**See also:** `STYLE_GUIDE.md` (the system this extends) and the sibling
`../field-manual-guide/STYLE_GUIDE.md` (source of the borrowed page mechanics —
its bands/banner/footer conventions informed §4, rendered here in Burn's skin).
