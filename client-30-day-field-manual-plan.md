# `client-30-day.html` → Field Manual ("Recon") Plan

Recreates the 30-Day Fat Loss program in the `field-manual-guide/` design system
(navy **band** + light **page** surfaces, single amber `--accent-command`, mono
meta, bordered-square list markers) instead of the current "Burn" theme.
Decisions locked by interview:

| Decision | Choice |
|---|---|
| Where it lives | **New sibling file**, `client-30-day-field-manual.html`. `client-30-day.html` (Burn) stays untouched. |
| Scope | **HTML + a paginated PDF**, built now (not deferred) — mirrors the Burn pipeline (`burn-guide/print.css` + `build-pdf.sh`) but adapted for FM's dual band/page surfaces. |
| Components not in the FM catalog (chip picks, compare grid) | **Reuse existing components only** — no new components added to `field-manual-guide/`. |
| Table of contents | **Yes** — Section-Index Cards for Day 0–7 / Milestone / Weeks 2–4, right after the Hero. |
| Content wording | **Preserved verbatim.** Only structure/markup/visual presentation changes — this is a re-skin, not a rewrite. |

---

## 1. Deliverables

| File | What it is |
|---|---|
| `client-30-day-field-manual.html` | The screen sheet. Self-contained (`<style>` block with a Google Fonts `@import`, like `client-30-day.html` does) — no external link to `field-manual-guide/tokens.css`, so it stays a single portable file. Single-page scroll, no print rules baked in (same scope rule as Burn's screen HTML). |
| `field-manual-guide/print.css` | New. The FM print stylesheet — page geometry, running header/footer, per-component break rules. Sheet-agnostic, reusable for future FM documents. |
| `field-manual-guide/build-pdf.sh` | New. Same shape as `burn-guide/build-pdf.sh`: `./build-pdf.sh <sheet.html> <out.pdf>`, injects `print.css` into a temp copy, runs `pagedjs-cli`. Never touches the source HTML. |
| `client-30-day-field-manual.pdf` | Committed output, repo root. |

No edits to `client-30-day.html`, `burn-guide/*`, or the existing `field-manual-guide/tokens.css` / `components.html` / `STYLE_GUIDE.md`.

---

## 2. Content → component mapping

Following `STYLE_GUIDE.md` §7's recognition rules (explicit sequence → Numbered
over Chevron; a sub-label heading a set of items → Label Pill + list; warning
language → Safety Callout, always).

| Source chunk | → FM component | Notes |
|---|---|---|
| (new) doc type + meta bar | **Top Banner** | Left `30-DAY FAT LOSS PROGRAM`, right `CLIENT PROTOCOL · REV 01`. Doesn't exist in the Burn version — FM's structure expects one. |
| Tag + H1 (`The 30-Day *Fat Loss* Protocol.`) | **Hero** | Split wordmark: `The 30-Day ` + `<span class="hl">Fat Loss</span>` + ` Protocol.` Eyebrow = `// Daily Protocol`. |
| Statline (Wake / Eat / Day / Night) | **4× Spec Line**, stacked in the Hero | No FM strip component exists; `Label: value` is exactly Spec Line's shape (`Wake: 2L water first`, etc.), same role as the FM sample's `Target:` subline, just four instead of one. |
| Day 0–7 / Milestone / Weeks 2–4 headings | **Section-Index Cards** (new block after Hero) | 11 cards: `00` (How to use), `DAY 0`…`DAY 7`, `MILESTONE`, `WK 2–4`. |
| Every `.eyebrow` + `h2` + `.lead` (00, Day 0–7, Milestone, Weeks 2–4) | **Section Header Band** | Eyebrow → `SECTION`-style label (e.g. `DAY 4 — PORTION THE MEAT`); title; lead → `.fm-target` subline where one exists. |
| 00's five numbered rules | **Numbered-Marker List** | Explicit `1·…5·` → Numbered, per priority rule. |
| Day 0's three tasks (`Task 1/2/3`) | **Numbered-Marker List** | Explicit numbering. |
| Day 0's protein chips (9 options) | **Label Pill** (`Pick Your Proteins`) **+ a row of `.fm-pill`s** | Reuses the existing pill class as a repeated inline row (flex-wrap), not a new "chip" component — visually closest to the original compact chip list. |
| Day 1's two tasks (water, yogurt) | **Chevron-Marker List** | Not sequenced. |
| Day 2's two tasks (evening ritual, meat run) | **Chevron-Marker List** | Not sequenced. |
| Day 2's "Need ideas?" callout | **Safety Callout, `.note` variant** | Neutral aside, not a warning. |
| Day 3's three outcomes (liked it / close / not working) | **Chevron-Marker List** | Unordered set of cases. |
| Day 4's one task | **Chevron-Marker List** (single item) | Keeps the marker rhythm consistent with every other day. |
| Day 4's portion table | **Data Table** | `class="num"` on the portion column, mono/right-aligned. Caption stays a small mono line under it. |
| Day 4's "one strict rule" callout | **Safety Callout** (warning, `⚠`) | This is the program's one hard rule — warrants the amber warning framing, not `.note`. |
| Day 5's two tasks ("First…" / "Then…") | **Numbered-Marker List** | Explicit `First`/`Then` sequence wins over Chevron. |
| Day 5's compare grid (Flavor freely / Skip these) | **Two Label-Pill-headed Chevron lists, side by side** | Reuses Label Pill + Chevron list twice in a 2-col layout — no new "compare" component. |
| Day 5's arrow-note | **Safety Callout, `.note` variant** | Short aside, not a warning. |
| Day 6's three numbered questions | **Label Pill (`Three Quick Things For Later`) + Numbered-Marker List** | Explicit `1/2/3`. |
| Day 6's carb chips | **Label Pill (`Your Carb Options`) + row of `.fm-pill`s** | Same pattern as Day 0's proteins. |
| Day 7's two tasks | **Chevron-Marker List** | Not sequenced. |
| Every `.exit` "Done when…" line | **Spec Line** | `k="Done"`, value = the rest of the line. |
| Milestone section | **Section Header Band + Spec Line** | No callout needed — it's a beat, not a warning. |
| Weeks 2–4 timeline (Morning / Through the day / Evening) | **3× (Label Pill + Chevron-Marker List)**, stacked | FM has no timeline component; three Label-Pill-headed lists reproduce the same three-stage structure. |
| Weeks 2–4 "What's next" callout | **Safety Callout, `.note` variant** | Forward-looking note, not a warning. |
| Closing `<footer>` line | **Footer Meta Line** | Left = `30-DAY FAT LOSS · DAILY PROTOCOL`, right = a short imperative tagline (e.g. `Start Today`). |

**Structural note (not visual):** each Day is wrapped in one container
(`<article class="fm-day">`) holding its Section Header Band + page body as
siblings. This changes nothing on screen — it exists so the PDF step (§4) can
put `break-before: page` on one element per day and keep a day's band+body
glued to the same sheet.

---

## 3. Screen HTML notes

- Tokens/components copied inline from `field-manual-guide/tokens.css` +
  `components.html`, exactly as `client-30-day.html` inlines Burn's — same
  self-contained-sheet convention, no external stylesheet dependency.
- Fonts: Inter (400/500/600/800/900) + Space Mono (400/700), via `@import`.
- Section-Index Cards grid (11 cards) reuses the existing 3-up → 1-up responsive
  rule from `components.html` as-is.
- No new CSS components are introduced; the pill-row (for chip picks) and the
  2-col list layout (for the compare grid) are plain flex/grid wrappers around
  existing `.fm-pill` / `.fm-list` markup, not new named components.

---

## 4. PDF addendum (new — first PDF pass for this system)

Mirrors `burn-guide/PAGE_FORMAT.md`'s method (Paged.js + headless Chrome via
`pagedjs-cli`, same `build-pdf.sh <sheet> <out>` shape), adapted for FM's two
surfaces:

- **Page geometry:** `@page { size: letter; margin: 0.5in; }`, portrait — same as Burn.
- **Cover (page 1):** Top Banner + Hero + Section-Index Cards together, `break-after: page`, no running header/footer (`@page :first` blanked).
- **One day per page:** `break-before: page` on each `.fm-day` wrapper (§2's structural note) — Section Header Band and its page body stay glued to one sheet. Long days may overflow to a second sheet; that's allowed.
- **Running header:** left = doc title (from the Top Banner text), right = the current day's eyebrow (`string-set`) — same deviation Burn made (short eyebrow, not the full-sentence H2).
- **Running footer:** left = the closing tagline, right = `Page N`.
- **Light-on-paper is the easy case here:** unlike Burn (dark theme needing `print-color-adjust: exact` + a reattached dot-grid), FM's `.fm-band`/`.fm-page` divs already paint their own background per component on screen — that should carry into print with just `print-color-adjust: exact`, no page-level background hack needed. Flag and fix in review if a band doesn't fill the printable width on a page.
- **Component break rules:**
  - keep whole: Hero, Spec Line group, Section-Index Cards, Label Pill, each Chevron/Numbered list item, Safety Callout, each pill row;
  - eyebrow / title / target subline → `break-after: avoid` (no orphaned openers);
  - Data Table → breakable, `thead { display: table-header-group; }`;
  - Footer Meta Line runs as the running footer; no standalone closing line needed since it's already the footer.

---

## 5. Order of work

1. Build `client-30-day-field-manual.html` per §2–§3; open it in a browser and eyeball every day against the mapping table.
2. Write `field-manual-guide/print.css` + `field-manual-guide/build-pdf.sh` per §4.
3. Run the build, producing `client-30-day-field-manual.pdf`; iterate page by page.
4. Commit all four deliverables.

## 6. Validation

- [ ] Every day/section in `client-30-day.html` has a corresponding block in the new sheet — no content dropped.
- [ ] All body copy matches the source verbatim (spot-check a few paragraphs).
- [ ] Single amber accent only; no second hue introduced.
- [ ] Every label/eyebrow/pill is mono, uppercase, wide-tracked; band vs page text ramps aren't crossed.
- [ ] Cover renders alone (banner + hero + index cards), no running furniture; content starts page 2.
- [ ] One day per PDF page; no orphaned eyebrow/title; the portion table's header repeats if it spans a page.
- [ ] Both fonts (Inter, Space Mono) render in the PDF.
- [ ] Letter size, 0.5in margins.

---

## 7. Open items for your review

- Top Banner copy (`30-DAY FAT LOSS PROGRAM` / `CLIENT PROTOCOL · REV 01`) and the footer tagline (`Start Today`) are placeholders — say the word if you want different copy.
- Section-Index Cards label the how-to-use section `00`; confirm that's wanted in the index, or drop it and start the index at Day 0.
