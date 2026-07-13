# Style Guide — Implementation Plan

> **Status:** Draft for review · 2026-07-13
> **Purpose:** Extract the design language of `psmf-protocol.html` into a reusable style guide that will later become the foundation of a programmatic *text → polished product* workflow.

---

## 1. What we're building (and why)

`psmf-protocol.html` is a hand-built, one-off deliverable. It has a strong, consistent design language, but that language currently lives only inside one file's `<style>` block. If we want to produce more sheets like it — and eventually **generate them programmatically from source content** like `30_day_track.md` — we first need to lift the design out of the one-off and turn it into a documented, reusable *system*.

This plan produces that system in two layers:

1. **The design system** — tokens, typography, and a catalog of components, documented and rendered.
2. **The mapping layer** — the rules that say *"this kind of content becomes this component,"* which is the bridge the future LLM-driven workflow will run on.

The workflow itself is **out of scope for this phase** — but every decision here is made so that workflow drops in cleanly later.

---

## 2. Decisions locked (from alignment interview)

| Decision | Choice | Consequence for the plan |
|---|---|---|
| **Guide format** | Spec **+** live HTML gallery **+** extracted tokens | Three artifacts, not one doc. Gallery is also the render target the future workflow validates against. |
| **Design scope** | **Re-themable system** — fixed structure, swappable theme | Must separate *structure* (layout, components, type roles) from *skin* (palette, hues, maybe fonts). Tokens get a theming layer. |
| **Workflow engine** | **LLM-driven mapping** | Guide must define explicit **content-type → component** rules, not just describe components in isolation. |
| **Input shape** | **Mostly structured markdown** (like `30_day_track.md`) | Mapping rules can assume headed sections, tables, callouts, and lists as reliable input signals. |

---

## 3. Deliverables & file structure

```
burn-guide/
  IMPLEMENTATION_PLAN.md     # this file
  STYLE_GUIDE.md             # the written spec — tokens, type, rules, do/don't, mapping table
  components.html            # live gallery: every component rendered + labeled
  tokens.css                 # the extracted CSS variable system (locked structure + current theme,
                             #   split into clearly-marked sections so a future theme is a drop-in)
```

**Why each exists:**
- `STYLE_GUIDE.md` — the human- and LLM-readable source of truth. Prose rules + the mapping table.
- `components.html` — you can *see* the system; also the reference render the future pipeline is checked against.
- `tokens.css` — the machine-usable extraction. Internally split into a **locked** section (structure, fonts, semantics) and a **theme** section (the current palette), so adding a second theme later is a copy-swap of one block — no restructuring.

> **Note (per your call):** we are **not** building a second/variant theme now. We only ensure the *structure supports* re-theming later. One theme ships: the current look.

---

## 4. The design system, extracted

### 4.1 Design tokens (already present, to be formalized)

The template already uses a clean CSS-variable system. We lift it verbatim, then split it into **locked tokens** (fixed across all future products) and **theme tokens** (swappable later):

**Theme tokens (the palette — swappable in a future theme):**
```
--bg, --bg-soft, --card, --line          → surface ramp
--text, --text-dim, --text-mute          → text ramp
--accent-effort (was --burn) + dim pair  → primary "effort / intensity" semantic
--accent-recover (was --fill) + dim pair → secondary "recovery / positive" semantic
--accent-warn (was --warn)               → caution semantic
```

**Locked tokens (fixed brand — never swap):**
```
fonts: --font-display, --font-mono, --font-editorial   (the Grotesk / Plex-Mono / Serif trio)
spacing scale, border-radius (8/10px), max-width (860px),
grid gap rhythm, section padding (56px), border weights
```

> **Token naming (decided):** `--burn` / `--fill` → **evocative, generalized semantic roles**: `--accent-effort` / `--accent-recover` (+ their `-dim` pairs), and `--accent-warn`. The *meaning* is documented alongside each ("effort = intensity/deficit/exertion," "recover = rest/refeed/positive") so any future theme keeps the semantics even with new hues.

> **Fonts (decided):** the **Grotesk / Plex-Mono / Serif trio is part of the locked brand** — it moves into the locked section and does *not* swap per product. Only the palette is themeable.

### 4.2 Typography — three fonts, three jobs

| Font | Role | Used for |
|---|---|---|
| Space Grotesk | **Display / body** | H1, H2, body copy |
| IBM Plex Mono | **Data / labels** | eyebrows, stat numbers, table headers, tags, formulas |
| Source Serif 4 *(italic)* | **Editorial voice** | hero subhead, pull quotes |

This "mono = data, serif-italic = voice, grotesk = structure" split is the signature of the look and becomes a **documented rule**, not just current usage.

### 4.3 Component catalog

Every reusable block in the template, documented with: purpose, HTML skeleton, tokens used, and — critically — **what content-type triggers it** (§5).

1. **Hero** — tag chip + H1 (with `<em>` accent) + serif subhead + statline
2. **Statline** — 4-up bordered metric strip (label + mono number)
3. **Section header** — numbered eyebrow + H2 + `.lead` intro (the repeating section rhythm)
4. **Macro cards** — 4-up metric cards, optional accent variant
5. **Calc box** — 2-up "formula" panel (value + derivation), with a "preferred" highlight variant
6. **Data table** — left labels + right-aligned mono numbers + totals row
7. **Table tags** — inline semantic pills (burn/fill)
8. **Two-card compare** — "Keep / Reduce" style paired lists + arrow-note
9. **Schedule strip** *(signature — generalized from the PSMF "cycle visualizer")* — an N-column grid of day/step cells, each colored by type, with optional corner badges and a legend underneath. Reusable for *any* repeating schedule, not just PSMF weeks.
10. **Timeline** — vertical, dotted-node, week-by-week outlook
11. **Callout** — left-accent-bordered note with mono label
12. **Chip list** — pill row for enumerations/menus
13. **Footer** — mono, muted, closing line

Global elements: fixed dot-grid background, responsive rules, `prefers-reduced-motion` handling.

---

## 5. The mapping layer (the bridge to the future workflow)

Because the engine will be **LLM-driven**, the guide's most important asset is an explicit table telling the model *which component to reach for given a kind of content*. Draft mapping:

| Content signal in source | → Component |
|---|---|
| Title + one-line premise + a few headline metrics | Hero + Statline |
| A set of 3–5 parallel target values | Macro cards |
| A value with a derivation / formula | Calc box |
| A "do this / not that" or "keep / reduce" pair | Two-card compare |
| Rows of items with quantities/numbers | Data table (+ totals if summ­able) |
| A repeating N-day / N-step schedule | Schedule strip |
| Week-by-week or stage-by-stage progression | Timeline |
| A warning, caveat, or "reassess" note (`>` blockquote) | Callout |
| A flat enumeration / menu of options | Chip list |
| A short semantic status label | Table tag / pill |

This table is written to be **directly usable as LLM instructions** later. Each row will include a 1-line "recognize it by…" cue so the mapping is reproducible.

---

## 6. Phased execution

**Phase A — Extract & formalize the system** *(foundation)*
- A1. Pull `tokens.css` from the template; split structural vs theme tokens.
- A2. Rename fitness-specific tokens to semantic roles (per §7 decision).
- A3. Document typography roles and the section rhythm.

**Phase B — Build the live gallery**
- B1. `components.html` — render all 13 components with labels + the source-content example that produced each.
- B2. Wire it to `tokens.css` so it re-skins when a theme swaps.

**Phase C — Lock re-themability structurally** *(no second theme built)*
- C1. Organize `tokens.css` into a **locked** block and a **theme** block, clearly commented.
- C2. Confirm the gallery reads *only* through variables — i.e. a future theme would be a single-block swap. No variant theme is produced now.

**Phase D — Write the spec + mapping**
- D1. `STYLE_GUIDE.md` — tokens, type, per-component reference, do/don't rules.
- D2. Embed the **content-type → component mapping table** (§5) with recognition cues.
- D3. A short "how the future workflow will use this" section, so the handoff is explicit.

**Phase E — Validate against real content**
- E1. Hand-map a slice of `30_day_track.md` (e.g. the 7-day cycle, the Phase-2 lever table) onto components using only the guide — confirm the mapping holds and nothing's missing.

---

## 7. Resolved decisions

All four alignment questions are now settled:

1. **Token naming** → **evocative, generalized semantic roles**: `--accent-effort` / `--accent-recover` / `--accent-warn` (see §4.1).
2. **Fonts** → **locked brand.** The Grotesk / Plex-Mono / Serif trio does not swap per product; only the palette is themeable (see §4.1).
3. **Second theme** → **not now.** Ship the current theme only; structure `tokens.css` so a future theme is a drop-in (see §3, Phase C).
4. **Signature component** → **generalize** the cycle visualizer into a reusable **"schedule strip"** — an N-cell colored schedule with legend, usable for any repeating cycle (see §4.3 #9).

No open decisions remain — Phase A can start on approval.

---

## 8. Explicitly out of scope (this phase)

- The actual generation pipeline / any code that calls an LLM.
- Input parsing / markdown ingestion tooling.
- Multi-page or navigation (template is single-page; we keep that).
- Print/PDF export (note: a `Sample_C_Field_Manual.pdf` exists in-repo — flag whether PDF output matters *later*, not now).

---

## 9. What I need from you to proceed

- A single sign-off on this plan as written (deliverables §3 + phases §6).

All design decisions are resolved (§7). On your approval, I start at Phase A.
