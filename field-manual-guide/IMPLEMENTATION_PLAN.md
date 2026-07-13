# Field Manual — Style Guide Implementation Plan

> **Status:** Draft for review · 2026-07-13
> **Source template:** `Sample_C_Field_Manual.pdf` ("Eyemaxxing — Field Manual, Rev. 01")
> **Purpose:** Extract the design language of the Field Manual PDF into a reusable
> style guide — a **second, standalone** design system alongside the PSMF "Burn"
> guide — that will later feed the same programmatic *text → polished product* workflow.

---

## 1. What we're building (and why)

`Sample_C_Field_Manual.pdf` is a hand-designed, 2-page tactical "field manual." It
has a strong, distinct visual language — amber-on-navy, split-color wordmark,
solid label-pills, bordered-square list markers, safety callouts — that currently
lives only inside a flattened PDF. To produce more manuals like it (and eventually
**generate them from source content**), we lift that language into a documented,
reusable *system*, exactly as we did for `psmf-protocol.html`.

This is a **standalone system** (per alignment): its own folder, its own tokens,
its own gallery and spec. It shares *philosophy* with the PSMF guide (mono for
meta/labels, semantic accent, single-column rhythm) but nothing else — different
fonts, a two-tone light/dark surface model, a single command accent, and a
different component set. Forcing it into the "Burn" tokens would corrupt both.

Two layers, same as before:

1. **The design system** — tokens, typography, component catalog, documented and rendered.
2. **The mapping layer** — the *"this content becomes this component"* rules the future LLM-driven workflow runs on.

The workflow itself remains **out of scope** for this phase.

---

## 2. Decisions locked (from alignment interview)

| Decision | Choice | Consequence for the plan |
|---|---|---|
| **Relationship to PSMF guide** | **Standalone new system** in `field-manual-guide/` | Separate `tokens.css` / `components.html` / `STYLE_GUIDE.md`. No shared files. |
| **Surface model** | **Dual light + dark, first-class** | Tokens define a dark **band** surface set *and* a light **page** surface set, each with its own text ramp. Components declare which surface they sit on. |
| **Component coverage** | **Generalize the full pattern** | Infer the repeating section template (Secs 02/03 follow Sec 01's shape) and build a complete, reusable set — not only the literal 2 pages. |
| **Layout target** | **Single-page web scroll** | Bands become full-bleed `<section>`s in one continuous `.wrap`; **no page breaks**. Print/paged feel is evoked by band rhythm, not real pages. |

**Inherited from the PSMF guide (not re-litigated):**
- **Workflow engine = LLM-driven mapping** — the guide must expose explicit content→component rules.
- **Input shape = mostly structured markdown** — mapping can assume headings, lists, ordered steps, callouts as reliable signals.

---

## 3. Deliverables & file structure

```
field-manual-guide/
  IMPLEMENTATION_PLAN.md     # this file
  STYLE_GUIDE.md             # the written spec — tokens, type, rules, do/don't, mapping table
  components.html            # live gallery: every component rendered + labeled, on both surfaces
  tokens.css                 # the extracted CSS variable system (locked structure + "Recon" theme,
                             #   split so a future theme is a drop-in)
```

**Why each exists** (identical rationale to the PSMF guide, kept parallel on purpose):
- `STYLE_GUIDE.md` — human- and LLM-readable source of truth. Prose rules + mapping table.
- `components.html` — you can *see* the system; also the reference render the future pipeline validates against.
- `tokens.css` — the machine-usable extraction, split into a **locked** section (structure, fonts, semantics) and a **theme** section (the "Recon" palette), so a second theme later is a copy-swap of one block.

> **Note:** as before, we ship **one theme** ("Recon" — the amber/navy look). We only ensure the structure *supports* re-theming; no variant palette is built now.

---

## 4. The design system, extracted

### 4.1 Design tokens

Colors below are **sampled directly from the PDF render** (provisional names; exact
hexes verified in Phase A). Split into **locked** (fixed brand) and **theme** (swappable).

**Theme tokens — the "Recon" palette (swappable later):**

*Dark "band" surface (hero, section headers, banner backdrop):*
```
--band-bg        #0D2133   deep navy — the field-manual backdrop
--band-line      #1C3446   hairline borders on navy (index cards, dividers)
--band-text      #E9F1F6   near-white primary text on navy
--band-dim       #9FB4C4   secondary text on navy (subheads, "Target:" lines)
--band-mute      #5C7589   footer / meta text on navy
```

*Light "page" surface (section bodies, lists, callouts):*
```
--page-bg        #F5F6F9   light body background
--page-card      #FFFFFF   raised card / cell fill
--page-line      #E1E6EC   hairline borders on light
--page-text      #22384A   primary body text (dark slate-navy)
--page-dim       #5A6B80   secondary body text
--page-mute      #8A98A8   captions / least emphasis
```

*Accent (single command accent + tints):*
```
--accent-command      #F4A531   THE amber — banner, wordmark, pills, callout borders, eyebrows
--accent-command-ink  #0D2133   dark text placed ON amber (pills, banner)
--accent-command-tint #FFF6EB   cream fill for the safety callout
--marker-line         #E9FAF3   faint cool tint on bordered-square list markers
```

> **Accent semantics (decided):** unlike the PSMF three-role system, the Field
> Manual is a **single-accent** brand. `--accent-command` does *everything* —
> structure, emphasis, and warning (the safety callout is amber-bordered, not a
> separate hue). This "one loud accent" is itself the signature and becomes a
> **documented rule**. We reserve one optional slot (`--accent-confirm`) for a
> future do/don't "positive" state, but the source never uses it, so we do not
> introduce it now.

**Locked tokens (fixed brand — never swap):**
```
fonts: --font-display, --font-mono   (see §4.2)
spacing scale, radii (pill + small square markers), max-width,
band/section padding rhythm, border weights, full-bleed banner height
```

### 4.2 Typography — a **two-family** system (the key contrast with PSMF)

The Field Manual has **no editorial serif voice**. Its "voice" is terse tactical
mono meta-text ("HUNTER > PREY", "IMPLEMENT IMMEDIATELY"), not a soft serif line.
So this brand is deliberately **two families**, not three:

| Font | Token | Role | Used for |
|---|---|---|---|
| **Bold geometric sans** *(proposed: Inter / Archivo)* | `--font-display` | Display **and** body, weight-differentiated | Giant wordmark (heavy), section titles (bold), body copy (regular) |
| **Monospace** *(proposed: Space Mono / JetBrains Mono)* | `--font-mono` | Meta / labels / directives | banner text, eyebrows, `SEC 0X` labels, pill text, safety label, footer meta |

**Rules to document:**
- Anything meta, label, or tactical → **mono, uppercase, wide tracking**. No exceptions.
- The **split-color wordmark** (`Eye` in `--band-text` + `maxxing` in `--accent-command`) is a signature display technique — a `<span>`-split on the key term.
- Display and body are the **same family** at different weights (heavy vs regular) — that single-family sans is what gives the "modern manual" feel.
- Fonts are **locked** — chosen as close substitutes for the PDF's embedded faces; exact family confirmed in Phase A.

### 4.3 Component catalog (generalized from the 2-page sample)

Each documented with purpose, HTML skeleton, tokens used, the surface it lives on,
and **what content-type triggers it** (§5).

1. **Top Banner** *(signature)* — full-bleed amber bar: left label + right `REV / REGION` meta. Mono uppercase.
2. **Hero** *(band)* — eyebrow (`// PRACTICAL PROTOCOL…`) + giant **split-color wordmark** + sans subhead + a two-item mono meta footer line.
3. **Section-Index Cards** *(band)* — a row of bordered cards (`SEC 0X` amber label + title). Table-of-contents / nav.
4. **Section Header Band** *(band)* — full-bleed navy band opening a section: eyebrow (`SECTION 0X — NAME`) + big title + a "Target:" spec subline.
5. **Label Pill** *(page)* — solid amber rounded pill, dark mono uppercase text (`GROOMING — DO FIRST`). Groups/segments a list.
6. **Chevron-Marker List** *(page)* — items each with a bordered-square `›` marker + text; key terms bold. Unordered directives.
7. **Numbered-Marker List** *(page)* — items each with a bordered-square number + bold lead + text. Ordered protocol.
8. **Safety Callout** *(page)* — amber-bordered, cream-fill box, `⚠ SAFETY CHECK` mono label + body. The warning component.
9. **Spec Line** *(band or page)* — a `Label: value` one-liner (the "Target: low-set, full…" pattern).
10. **Footer / Meta Line** — muted mono pair, left/right (reused in hero + page bottoms).
11. **Inline emphasis** — bold key term inside body (`Point A`); documented as a rule, not a block.

**Inferred variants (motivated, kept minimal):** a Label-Pill can head *either* a
chevron or numbered list; the Safety Callout generalizes to a `note` variant (same
box, neutral label) for non-warning asides. Anything more speculative (e.g. a
do/don't compare) is noted as *possible future*, not built.

---

## 5. The mapping layer (bridge to the future workflow)

The most important asset: an explicit table telling the LLM which component to
reach for. Draft (each row gets a 1-line "recognize it by…" cue in the spec):

| Content signal in source | → Component |
|---|---|
| Document type + revision/region meta at the very top | Top Banner |
| Doc title (one key word emphasized) + one-line premise | Hero (split-color wordmark on the key word) |
| A list of the sections/parts up front | Section-Index Cards |
| The start of any titled section (`## Heading`) | Section Header Band |
| A `Target:` / `Goal:` / `Spec:` one-liner | Spec Line |
| A named *group* of steps under a sub-label | Label Pill (+ the list below it) |
| Unordered "do this" directives | Chevron-Marker List |
| Ordered / sequenced protocol steps (1,2,3) | Numbered-Marker List |
| A warning, caution, "safety", or `>` blockquote aside | Safety Callout (warn) / note variant |
| A short imperative tagline / attribution | Footer Meta Line |
| A key term to stress inside a sentence | Inline emphasis (bold) |

**Recognition priority when signals overlap** (to be finalized in the spec):
1. Explicit sequence/order words ("first, then", numbered) → **Numbered** over Chevron.
2. Warning/safety language → **Safety Callout** over ordinary list, always.
3. A sub-label heading a set of items → **Label Pill + list**, not a bare list.

---

## 6. Phased execution

**Phase A — Extract & formalize the system** *(foundation)*
- A1. Verify sampled hexes + confirm the display/mono font substitutes against the PDF.
- A2. Author `tokens.css`: locked block + "Recon" theme block, with the dual band/page surface sets and the single command accent.
- A3. Document typography roles, the split-color wordmark rule, and the band/page rhythm.

**Phase B — Build the live gallery**
- B1. `components.html` — render all components, each labeled with its trigger, shown **on the correct surface** (band vs page).
- B2. Wire it to `tokens.css` so it re-skins on a theme swap.

**Phase C — Lock re-themability structurally** *(no second theme built)*
- C1. Organize `tokens.css` into clearly-commented **locked** and **theme** blocks.
- C2. Confirm the gallery reads *only* through variables — a future theme is a single-block swap.

**Phase D — Write the spec + mapping**
- D1. `STYLE_GUIDE.md` — tokens, type, per-component reference, do/don't rules.
- D2. Embed the content→component mapping table (§5) with recognition cues + priority rules.
- D3. A short "how the future workflow will use this" handoff section.

**Phase E — Validate against real content**
- E1. Hand-map a slice of representative source (the Eyemaxxing sections, and cross-check a chunk of `30_day_track.md`) onto components using only the guide — confirm coverage, fold any refinement into §5.

---

## 7. Resolved decisions

1. **Relationship** → **standalone** `field-manual-guide/`; shares philosophy, not files.
2. **Surface model** → **dual light+dark, first-class** (`--band-*` and `--page-*` sets).
3. **Accent semantics** → **single command accent** (amber does structure + emphasis + warning); one optional `--accent-confirm` slot reserved, not built.
4. **Typography** → **two families** (one geometric sans for display+body, one mono for meta); **no serif** — this is the deliberate contrast with PSMF.
5. **Coverage** → **generalize** the repeating section pattern; minimal motivated variants only.
6. **Layout** → **single-page scroll**, full-bleed bands, no real page breaks.

No open decisions remain — Phase A can start on approval.

---

## 8. Explicitly out of scope (this phase)

- The actual generation pipeline / any code that calls an LLM.
- Input parsing / markdown ingestion tooling.
- A second/variant "Recon" theme (structure supports it; none built).
- True paged/print PDF export (we evoke the manual feel in a single scroll page).
- Merging or cross-referencing with the PSMF "Burn" system beyond shared philosophy.

---

## 9. What I need from you to proceed

- A single sign-off on this plan (deliverables §3 + phases §6).
- Optional: a nudge on the two proposed font substitutes (§4.2) — Inter vs Archivo
  for display, Space Mono vs JetBrains Mono for meta. I'll pick sensible defaults
  (Inter + Space Mono) if you don't specify.

All design decisions are resolved (§7). On your approval, I start at Phase A.
