# Protocol Sheet — Style Guide

> The design system behind `psmf-protocol.html`, extracted for reuse.
> **Structure is locked; the palette is themeable.** This document is the
> source of truth for both humans building sheets by hand and the future
> text-to-product workflow.

**Files in this system**

| File | What it is |
|---|---|
| `tokens.css` | The variable system. Locked block + theme block. |
| `components.html` | Live gallery — every component rendered and labeled. Open it in a browser. |
| `STYLE_GUIDE.md` | This document. Rules + the component reference + the content→component mapping. |
| `PAGE_FORMAT.md` | **Optional addendum — applies only on request when converting a sheet to PDF.** Page geometry, cover, running header/footer, and per-component break rules for the HTML→**US-Letter PDF** path. It does **not** change the screen HTML (which stays a single scrolling page) and ships no CSS into any sheet. |

---

## 1. Design philosophy

Three ideas define the look:

1. **Data reads like data.** Every number, label, formula, and tag is set in
   monospace (IBM Plex Mono). The moment something is quantitative, it changes
   typeface. This is the system's strongest signal.
2. **Color carries meaning, not decoration.** There are exactly three accents,
   each with a fixed semantic role (§4). A sheet never introduces a color "just
   to look nice."
3. **One quiet editorial voice.** A single serif-italic line per section (the
   lead / hero subhead) is the only "human" voice against an otherwise
   technical, structural page. Used sparingly, it lands.

The result reads like an instrument panel, not a brochure.

---

## 2. Design tokens

All tokens live in `tokens.css`, split into two blocks.

### 2.1 Locked (never swap per product)

- **Fonts** — the brand trio (§3).
- **Spacing scale** — `--space-1` (4px) → `--space-18` (72px).
- **Radii** — `--radius-sm` 8px, `--radius` 10px, `--radius-pill` 999px.
- **Layout** — `--maxw` 860px, `--gutter` 24px.
- **Type scale** — `--fs-h1`, `--fs-h2`, `--fs-lead`, `--fs-label`, etc.

### 2.2 Theme (swappable — one theme ships today: "Burn")

| Token | Value | Role |
|---|---|---|
| `--bg` / `--bg-soft` / `--card` / `--line` | `#101411` → `#2c352e` | surface ramp (darkest → borders) |
| `--text` / `--text-dim` / `--text-mute` | `#e9ece7` → `#5e6b60` | text ramp (brightest → faintest) |
| `--accent-effort` (+ `-dim`) | `#ff6a45` / `#6b3527` | **primary: intensity / deficit / exertion** |
| `--accent-recover` (+ `-dim`) | `#6be3c4` / `#2c4f47` | **secondary: rest / refeed / positive** |
| `--accent-warn` | `#f0c75e` | **caution / reassess / attention** |
| `--grid-line` | `rgba(255,255,255,0.018)` | dot-grid background tint |

**To add a theme later:** copy the whole THEME block in `tokens.css`, change only
the color values, keep every variable name. Components read exclusively through
these variables, so nothing else moves.

---

## 3. Typography — three fonts, three jobs

| Font | Token | Role | Used for |
|---|---|---|---|
| **Space Grotesk** | `--font-display` | Structure / body | H1, H2, body copy, card values |
| **IBM Plex Mono** | `--font-mono` | Data / labels | eyebrows, stat numbers, table headers & numbers, tags, formulas, footer |
| **Source Serif 4** *(italic)* | `--font-editorial` | Voice | hero subhead, section lead lines, pull quotes |

**Rules**
- Anything quantitative or label-like → **mono**. No exceptions.
- The serif is **always italic** and used **once or twice per section at most**.
- Headings are Grotesk, tight tracking (`--ls-tight` on H1), never mono.
- These typefaces are **locked** — they do not change per product.

---

## 4. Semantic color rules

Three accents, each a fixed *meaning* that survives any future re-theme (the hue
may change; the role does not):

- **`--accent-effort`** — the hard thing, the push, the deficit, the cost. Used
  for the primary tag/dot, H1 emphasis `<em>`, the "aggressive" macro card,
  totals numbers, effort tags, the "reduce/negative" compare card.
- **`--accent-recover`** — the release, the reward, the positive/rest state.
  Used for refeed cells, the "keep/positive" compare card, recover tags.
- **`--accent-warn`** — caution and reassessment. Used only for callouts and
  schedule badges. Never a primary accent — it's an interruption.

**Do not** use an accent outside its role (e.g. don't color a positive outcome
in `--accent-effort` just for contrast). The consistency *is* the meaning.

---

## 5. Layout & structure rules

- **Container:** all content in `.wrap` — `max-width: 860px`, centered, 24px gutter.
- **Background:** a fixed 48px dot-grid (`body::before`) sits behind everything at
  `z-index:0`; content rides above at `z-index:1`. It's a signature — keep it.
- **Section rhythm:** every section opens with the **eyebrow → H2 → `.lead`**
  triad (§ component 03). Eyebrows are numbered (`01 —`, `02 —`, …).
- **Vertical rhythm:** sections separated by a 1px `--line` border, ~56px padding.
- **Responsive:** 4-up grids collapse to 2-up under 720px; the schedule strip
  stays 7-wide but shrinks. Tables shrink type. See `components.html`.
- **Motion:** hover lift on schedule cells only; all transitions disabled under
  `prefers-reduced-motion`.

---

## 6. Component reference

Each component below lists its **root class**, **purpose**, and **trigger** (the
content signal that calls for it). Skeletons are in `components.html`.

| # | Component | Root class | Purpose |
|---|---|---|---|
| 01 | **Hero** | `.hero` | Title (`<em>` accent), premise (serif sub), sets the sheet's frame. |
| 02 | **Statline** | `.statline` | 3–4 headline metrics in a bordered strip. |
| 03 | **Section Header** | `.eyebrow` + `h2` + `.lead` | The repeating section opener. |
| 04 | **Macro Cards** | `.macro-grid` | 3–5 parallel target values; `.accent` variant highlights one. |
| 05 | **Calc Box** | `.calc-box` | A value + its derivation; `.primary` marks the preferred item. |
| 06 | **Data Table** | `table` | Rows of items w/ right-aligned mono numbers; `tr.totals` for sums. |
| 07 | **Table Tag** | `.table-tag` | Inline semantic pill: `.effort` / `.recover`. |
| 08 | **Two-Card Compare** | `.compare-grid` | A keep/reduce or do/don't pair; `.positive` / `.negative`; optional `.arrow-note`. |
| 09 | **Schedule Strip** | `.schedule` | *Signature.* N-cell colored schedule (`.type-a`/`.type-b`), optional `data-badge`, legend. |
| 10 | **Timeline** | `.timeline` | Vertical, dotted-node week/stage progression. |
| 11 | **Callout** | `.callout` | Warn-bordered note with a mono label. |
| 12 | **Chip List** | `.chip-list` | A flat enumeration / menu of options. |
| 13 | **Footer** | `footer` | Muted mono closing line. |

**Schedule Strip note (generalization):** originally the PSMF "cycle visualizer,"
it's now generic — any repeating schedule. `.type-a` = effort-colored cell,
`.type-b` = recover-colored cell, `data-badge="…"` adds a warn-colored corner
badge. The 7-column grid is the default; adjust `grid-template-columns` for other
cycle lengths.

---

## 7. Content → Component mapping  *(the workflow-facing asset)*

This is the table the future **LLM-driven** step consumes. For each chunk of
source content, recognize the signal, emit the component.

| Content signal (recognize it by…) | → Component | Notes |
|---|---|---|
| The document's title + one-line premise, at the top | **Hero** | Put the key phrase in `<em>` (effort color). Premise → `.hero-sub` (serif). |
| A cluster of 3–4 defining metrics about the subject | **Statline** | Numbers → mono. Lives inside the hero. |
| The start of any titled section (`## Heading`) | **Section Header** | Eyebrow = number + short label; H2 = the punchy claim; lead = one serif sentence. |
| 3–5 **parallel** target values (macros, limits, quotas) | **Macro Cards** | Mark the most important/aggressive one with `.accent`. |
| A single value **with a formula or derivation** shown | **Calc Box** | Two-up; highlight the "preferred/target" with `.primary`. |
| Rows of items each with a quantity/number; possibly a total | **Data Table** | Right-align + mono the numbers. Add `tr.totals` only if the rows sum. |
| A short status label attached to a heading or row | **Table Tag** | `.effort` for cost/hard states, `.recover` for reward/rest states. |
| A "do this / not that" or "keep / reduce / increase / decrease" pairing | **Two-Card Compare** | `.positive` = the keep side, `.negative` = the cut side. Add `.arrow-note` for a before→after. |
| A repeating **N-day or N-step schedule / cycle** | **Schedule Strip** | Two cell types by default; badge the special days. |
| A **week-by-week or stage-by-stage** progression / outlook | **Timeline** | Each stage = `tl-stage` label + a short `<ul>`. |
| A warning, caveat, "reassess," or `>` blockquote aside | **Callout** | Label = the note's kind ("Reassess", "Note", "Warning"). |
| A flat **enumeration / menu** of options (no quantities) | **Chip List** | One chip per item. Great for food/option menus. |
| The document's closing/attribution line | **Footer** | Muted mono, one line. |

**Recognition priority when signals overlap**
1. Has numbers that sum? → **Data Table** over Chip List.
2. Parallel *targets* (not a running list)? → **Macro Cards** over Table.
3. Time/step sequence? → **Timeline** (progression) vs **Schedule Strip** (repeating cycle).
4. A pairing/contrast? → **Two-Card Compare** over two separate lists.

---

## 8. How the future workflow will use this

The generation pipeline is out of scope for now, but the intended handoff is:

1. **Ingest** structured markdown (like `30_day_track.md`) → split into chunks by heading/block.
2. **Classify** each chunk against §7's mapping (this is the LLM's core job).
3. **Emit** the matching component's HTML skeleton (from `components.html`), filling in content.
4. **Assemble** components inside a `.wrap`, in source order, with the dot-grid shell + `tokens.css`.
5. **Validate** the render against `components.html` as the reference.

Because components read only through `tokens.css`, the same pipeline output can be
re-skinned later by swapping the theme block — no regeneration needed.

---

## 9. Do / Don't

**Do**
- Keep every number and label in mono.
- Reuse the eyebrow→H2→lead rhythm for every section.
- Respect the three accent meanings.
- Keep the dot-grid background and the 860px container.

**Don't**
- Introduce a fourth accent color or a new font.
- Use the serif for anything but the one editorial line per section.
- Color things against their semantic role for contrast.
- Let a sheet exceed the single-page, single-column structure without a reason.

---

## 10. Validation — mapped against `30_day_track.md`  *(Phase E)*

Sanity check: does §7 cover real source content? Mapping representative chunks of
`30_day_track.md`:

| Source chunk | Signal | → Component | Covered? |
|---|---|---|---|
| Program title + "Day 0" premise | title + premise | Hero | ✅ |
| Day 0 exit condition (3 gates) | short enumeration | Chip List *or* compact list | ✅ |
| Day 4 "per-pick anchors" table (Pick / portion) | rows with quantities | Data Table | ✅ |
| "Standing habits by end of Day 3" (1,2,3) | stage/step list | Timeline (if sequential) | ✅ |
| The `>` intro blockquotes on each day | caveat / framing aside | Callout | ✅ |
| Phase 2 "seven levers" | enumeration of named items | Chip List → then per-lever sections | ✅ |
| Phase 2 **Sequencing** table (Window / Focus) | week-window progression | Timeline **or** Data Table | ✅ (Timeline preferred — it's a progression) |
| Carb menu / protein menu | flat option menu | Chip List | ✅ |
| "One lever per adjustment" operating rules | do/don't-style rules | Two-Card Compare *or* Callout list | ✅ |

**Result:** every representative chunk maps to an existing component. One
refinement surfaced and is now folded into §7's priority rules: a
*window→focus* table (Phase 2 sequencing) is a **progression**, so it prefers
**Timeline** over Data Table even though it's tabular in the source. No missing
components. The system covers the source.
