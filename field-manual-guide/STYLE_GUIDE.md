# Field Manual — Style Guide

> The **"Recon"** design system, extracted from `Sample_C_Field_Manual.pdf`.
> **Structure is locked; the palette is themeable.** This document is the source
> of truth for both humans building manuals by hand and the future
> text-to-product workflow. It is a **standalone** system — a sibling to the PSMF
> "Burn" guide, sharing philosophy but no files.

**Files in this system**

| File | What it is |
|---|---|
| `tokens.css` | The variable system. Locked block + "Recon" theme block. Dual band/page surfaces. |
| `components.html` | Live gallery — every component rendered on its correct surface and labeled. Open it in a browser. |
| `STYLE_GUIDE.md` | This document. Rules + component reference + the content→component mapping. |

---

## 1. Design philosophy

Four ideas define the look:

1. **One loud accent.** There is exactly **one** accent — amber
   (`--accent-command`). It does structure, emphasis, *and* warning. A manual
   never introduces a second hue "to look nice." The single-accent discipline
   *is* the brand's confidence.
2. **Two surfaces, both first-class.** Dark navy **bands** (banner, hero, section
   headers) alternate with a light **page** body. Every component knows which
   surface it lives on and uses that surface's text ramp.
3. **Mono is the meta-voice.** Every label, eyebrow, banner, pill, and tactical
   tagline is monospace, uppercase, wide-tracked. There is **no serif** — the
   "human" register is terse command language ("HUNTER > PREY"), not editorial
   prose. This two-family (sans + mono) split is the deliberate contrast with the
   PSMF three-font system.
4. **Directive, not descriptive.** Content is imperative and step-shaped. Bordered
   -square markers, numbered protocols, and safety checks make it read like an
   instrument you *operate*, not an article you read.

---

## 2. Design tokens

All tokens live in `tokens.css`, split into two blocks.

### 2.1 Locked (never swap per product)

- **Fonts** — the brand pair (§3).
- **Spacing scale** — `--space-1` (4px) → `--space-20` (80px).
- **Radii** — `--radius-marker`/`--radius-pill` 7px, `--radius-card` 10px.
- **Layout** — `--maxw` 880px, `--gutter` 28px, `--banner-h` 80px, `--marker-size` 34px.
- **Type scale** — `--fs-wordmark`, `--fs-h2`, `--fs-body`, `--fs-meta`, etc.

### 2.2 Theme (swappable — one theme ships today: "Recon")

**Dark "band" surface**

| Token | Value | Role |
|---|---|---|
| `--band-bg` | `#0D2133` | deep navy backdrop |
| `--band-line` | `#1C3446` | hairline borders on navy |
| `--band-text` / `--band-dim` / `--band-mute` | `#E9F1F6` → `#5C7589` | text ramp on navy (bright → meta) |

**Light "page" surface**

| Token | Value | Role |
|---|---|---|
| `--page-bg` / `--page-card` | `#F5F6F9` / `#FFFFFF` | body + raised cards |
| `--page-line` | `#E1E6EC` | hairline borders on light |
| `--page-text` / `--page-dim` / `--page-mute` | `#22384A` → `#8A98A8` | text ramp on light |

**Accent (single command accent + tints)**

| Token | Value | Role |
|---|---|---|
| `--accent-command` | `#F4A531` | **THE amber** — banner, wordmark, pills, eyebrows, callout outline |
| `--accent-command-ink` | `#0D2133` | dark text placed ON amber |
| `--accent-command-deep` | `#997131` | readable amber-brown for text on cream |
| `--accent-command-tint` | `#FFF6EB` | cream fill for the safety callout |
| `--marker-line` | `#E9FAF3` | optional faint cool tint for markers |
| `--accent-confirm` *(reserved)* | `#6be3c4` | unused; a future do/don't "positive" state |

**To add a theme later:** copy the whole THEME block in `tokens.css`, change only
the color values, keep every variable name. Components read exclusively through
these variables, so nothing else moves.

---

## 3. Typography — two families, distinct jobs

| Font | Token | Role | Used for |
|---|---|---|---|
| **Inter** *(substitute for the PDF's display face)* | `--font-display` | Display **and** body | wordmark (900), section titles (800), index/list titles (600), body copy (400) |
| **Space Mono** *(substitute for the PDF's mono face)* | `--font-mono` | Meta / labels | banner, eyebrows, `SEC 0X`, pill text, safety label, footer meta, spec-line keys |

**Rules**
- Anything meta, label, or tactical → **mono, uppercase, wide tracking**. No exceptions.
- Display and body are the **same family** at different weights — that single sans
  gives the modern-manual feel. Do not add a third text family.
- **No serif.** The editorial register is mono command language, used sparingly.
- The **split-color wordmark** (`Eye` + `<span class="hl">maxxing</span>`) is a
  signature: stress the key term by coloring it `--accent-command`, everything
  else `--band-text`.
- Fonts are **locked** — they do not change per product.

---

## 4. Accent rule (single-accent brand)

There is **one** accent, `--accent-command` (amber), with a fixed *meaning* that
survives any re-theme (the hue may change; the role does not):

- **`--accent-command`** — *directive / action / attention.* Used for the banner,
  the wordmark highlight, eyebrows, `SEC 0X` labels, label pills, and the safety
  callout outline. It is the one loud voice.
- Warnings are **not** a separate color — the safety callout is `--accent-command`
  outlined on a `--accent-command-tint` cream fill. Emphasis and caution share the
  one accent by design.

**Do not** introduce a second accent hue. If a future do/don't state genuinely
needs a "positive" color, the reserved `--accent-confirm` slot exists — but the
source never uses it, and neither should a manual without cause.

---

## 5. Layout & structure rules

- **Container:** content sits in a `--maxw` 880px column with `--gutter` 28px padding.
- **Bands are full-bleed:** `.fm-banner`, `.fm-hero`, `.fm-sechead`, and `.fm-footer`
  span the full viewport width; their *content* stays within the column. In the
  single-page scroll, sections alternate band (navy) → page (light).
- **Surface rhythm:** a section = **Section Header Band** (navy) immediately
  followed by its **page** body (light). The banner sits once at the very top; the
  hero is the first band.
- **Section openers:** eyebrow (`SECTION 0X — NAME`, mono amber) → title (display)
  → optional Target/Spec subline.
- **List markers:** every list item leads with a 34px bordered square — a `›`
  chevron (unordered) or a number (ordered). This marker is a signature; keep it.
- **Responsive:** the 3-up index collapses to 1-up under 640px; meta/footer rows
  stack. See `components.html`.
- **Motion:** none required; all transitions disabled under `prefers-reduced-motion`.

---

## 6. Component reference

Each lists its **root class**, **surface**, **purpose**, and **trigger**.
Skeletons are in `components.html`.

| # | Component | Root class | Surface | Purpose |
|---|---|---|---|---|
| 01 | **Top Banner** | `.fm-banner` | accent | Full-bleed amber bar: doc type (left) + `REV / REGION` meta (right). |
| 02 | **Hero** | `.fm-band` + `.fm-wordmark` | band | Eyebrow + giant **split-color wordmark** + premise + mono meta line. |
| 03 | **Section-Index Cards** | `.fm-index` | band | Row of bordered `SEC 0X` cards — the table of contents. |
| 04 | **Section Header Band** | `.fm-band` + `.fm-sechead-title` | band | Full-bleed section opener: eyebrow + title + Target subline. |
| 05 | **Label Pill** | `.fm-pill` | page | Solid amber mono pill that heads/segments a list. |
| 06 | **Chevron-Marker List** | `.fm-list` (`›` markers) | page | Unordered directives; bordered-square `›` + text, bold key terms. |
| 07 | **Numbered-Marker List** | `.fm-list` (number markers) | page | Ordered protocol; bordered-square number + bold lead + detail. |
| 08 | **Safety Callout** | `.fm-callout` | page | Amber-outlined cream box, `⚠` mono label. `.note` = neutral variant. |
| 09 | **Spec Line** | `.fm-specline` | band / page | A `Label: value` one-liner (Target / Goal / Spec). |
| 10 | **Data Table** | `.fm-table` | page | Rows of items with specs/quantities; mono header, numeric columns (`.num`) mono & right-aligned. |
| 11 | **Footer Meta Line** | `.fm-footer` | band | Muted mono pair, left/right, closing a page. |
| — | **Inline emphasis** | `strong` | any | Bold a key term inside body copy (e.g. **Point A**). A rule, not a block. |

**Marker-list note:** components 06 and 07 share `.fm-list` / `.fm-item` /
`.fm-marker`; the only difference is the marker's content (`›` vs a number). A
`.fm-pill` typically precedes either.

---

## 7. Content → Component mapping  *(the workflow-facing asset)*

The table the future **LLM-driven** step consumes. For each chunk of source
content, recognize the signal, emit the component.

| Content signal (recognize it by…) | → Component | Notes |
|---|---|---|
| A document type + revision/region tag at the very top ("Field Manual, Rev. 01") | **Top Banner** | Left = type; right = `REV / REGION`. Mono uppercase. |
| The doc title (one key word to stress) + a one-line premise | **Hero** | Split the title: key term → `.hl` (amber). Premise → `.fm-lead`. |
| A list of the sections/parts, up front | **Section-Index Cards** | One card per section: `SEC 0X` + title. |
| The start of any titled section (`## Heading`) | **Section Header Band** | Eyebrow = `SECTION 0X — NAME`; title; optional Target subline. |
| A `Target:` / `Goal:` / `Spec:` one-liner | **Spec Line** | Key → mono (`.k`); value → body. |
| A named *group* of steps under a sub-label | **Label Pill** | The pill heads the list that follows. |
| Unordered "do this" directives | **Chevron-Marker List** | `›` markers. Bold the key term in each item. |
| Ordered / sequenced steps ("first, then", 1·2·3) | **Numbered-Marker List** | Number markers. Bold lead + detail. |
| A warning, caution, "safety", or `>` blockquote aside | **Safety Callout** | `⚠` label + amber outline. Use `.note` for non-warning asides. |
| Rows of items each with a quantity/spec (a table, or a header row + values) | **Data Table** | Mark numeric columns with `class="num"` → mono, right-aligned. Optional `.fm-pill` caption above. |
| A short imperative tagline / attribution closing a page | **Footer Meta Line** | Muted mono, left/right. |
| A key term to stress inside a sentence | **Inline emphasis** | `<strong>` — not a block. |

**Recognition priority when signals overlap**
1. Warning/safety language? → **Safety Callout**, always — over any ordinary list.
2. Explicit order/sequence ("first, then", numbered)? → **Numbered** over Chevron.
3. A sub-label heading a set of items? → **Label Pill + list**, not a bare list.
4. Title vs section start? → **Hero** only for the document title; every other
   `## Heading` is a **Section Header Band**.
5. Items with quantities/specs? → **Data Table** if there are ≥2 aligned value
   columns; a **Numbered/Chevron list** (with inline `label — value`) if it's a
   single value per item and reads as directives.

---

## 8. How the future workflow will use this

The generation pipeline is out of scope for now, but the intended handoff is:

1. **Ingest** structured markdown → split into chunks by heading/block.
2. **Classify** each chunk against §7's mapping (the LLM's core job).
3. **Emit** the matching component's HTML skeleton (from `components.html`), filling in content and choosing the correct **surface** (band vs page).
4. **Assemble** components in source order — banner once at top, then alternating
   Section Header Band → page body — inside the `--maxw` column with `tokens.css`.
5. **Validate** the render against `components.html` as the reference.

Because components read only through `tokens.css`, the same output can be re-skinned
later by swapping the theme block — no regeneration needed.

---

## 9. Do / Don't

**Do**
- Keep every label, eyebrow, and tagline in mono, uppercase, wide-tracked.
- Alternate band (navy) and page (light) surfaces; use each surface's text ramp.
- Lead every list item with a bordered-square marker.
- Reserve amber for command/attention; let it carry warnings too.
- Set numeric/table values in mono, right-aligned (`class="num"`) — data reads as data.

**Don't**
- Introduce a second accent hue or a serif/third text family.
- Put page-surface text colors on a band, or vice versa.
- Use a bare `<ul>` without the marker squares.
- Break the single-column, banner-once-at-top structure without a reason.

---

## 10. Validation — mapped against real content  *(Phase E)*

**A. The source itself (`Sample_C_Field_Manual.pdf`)** — every chunk maps:

| Source chunk | Signal | → Component | Covered? |
|---|---|---|---|
| "FIELD MANUAL · REV. 01 / EYE REGION" bar | doc type + rev meta | Top Banner | ✅ |
| "Eyemaxxing" + "practical protocol" premise | title + premise | Hero (split wordmark) | ✅ |
| SEC 01/02/03 cards | section list | Section-Index Cards | ✅ |
| "SECTION 01 — EYEBROWS" + title + "Target:" | section start | Section Header Band + Spec Line | ✅ |
| "GROOMING — DO FIRST" | grouped sub-label | Label Pill | ✅ |
| The three `›` grooming items | unordered directives | Chevron-Marker List | ✅ |
| "IF BROWS ARE SPARSE" 1·2·3 | ordered steps | Numbered-Marker List | ✅ |
| "⚠ SAFETY CHECK" box | warning aside | Safety Callout | ✅ |
| "HUNTER > PREY / IMPLEMENT IMMEDIATELY" | tactical tagline | Footer Meta / hero meta | ✅ |

**B. Cross-check against `30_day_track.md`** (a different content shape, to test
generality): day-by-day imperative steps → Numbered-Marker Lists; the `>` intro
blockquotes → Safety Callout `.note` variant; the "seven levers" enumeration →
Section-Index Cards or a Label-Pill-headed list; menus → Chevron-Marker Lists;
*quantitative tables* (e.g. per-pick portions with numbers) → **Data Table**
(`.fm-table`, added in this revision — numeric columns mono & right-aligned).

**Result:** the system covers the source completely and handles general directive
*and* data-dense content. The earlier boundary (numeric tables) is now closed by
the Data Table component (§6 #10); §7 rule 5 governs Table-vs-list selection.
