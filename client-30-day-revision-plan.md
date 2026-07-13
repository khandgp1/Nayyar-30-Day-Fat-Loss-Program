# `client-30-day.html` Revision Plan

Agreed direction from review: the sheet is a **client-facing daily protocol**. The client's only job is
*today* — so everything that explains the method, previews the future, or labels the document as a
"sheet" gets cut or reworked into operating instructions.

---

## 1. Hero tag — replace "Your Program Sheet"

- Tag becomes: `30-DAY FAT LOSS · DAILY PROTOCOL`
- Ripple edits for consistency:
  - `<title>` → `30-Day Fat Loss · Daily Protocol`
  - Footer (currently `30-Day Fat Loss — your program sheet. One habit at a time; nothing you love banned.`)
    → `30-Day Fat Loss · Daily Protocol` (slogan echo cut per items 2–3)

## 2. New H1

- Replace `Thirty days. One habit at a time.` with:

  > **The 30-Day *Fat Loss* Protocol.**

  ("Fat Loss" carries the orange `<em>` accent, matching current H1 styling.)

## 3. Cut the hero subtitle

- Delete the `hero-sub` paragraph ("Nothing you love gets banned…") entirely. No replacement.
- The "why it works" framing disappears from the page (see also item 5).

## 4. Intro stat strip → Daily Loop strip

Keep the 4-cell `statline` component but repurpose it as the unchanging daily sequence:

| Cell label | Cell text |
|---|---|
| WAKE | 2L water first |
| EAT | Prepped food first |
| DAY | The rest is yours |
| NIGHT | Prep tomorrow |

- Visual: small mono label on top (reusing `stat-label` treatment), short bold text under it —
  a light restyle of the existing cells (the big `stat-num` slot now holds a word, not a number).
- Wording caveat handled in item 5's copy: the full loop only exists from Day 4 on, so the
  "How to use" section frames it as *the rhythm the days build* — the strip itself stays clean.

## 5. "00 — How this works" → "00 — How to use this program"

Replace the method-explanation section with operating instructions. Draft copy:

- **Eyebrow:** `00 — How to use this program`
- **H2:** `Open today's day. Do it. Close the page.`
- **Body** (four short instructions, covering everything agreed):
  1. **Only today.** Each morning, find today's day and do its tasks. Don't read ahead and
     don't plan the week — the day in front of you is the whole job.
  2. **Check it off.** Every task has a circle. Fill it when it's done. The day is complete
     when every circle is.
  3. **Yesterday keeps running.** Each new day adds to the days before it — nothing you've
     installed gets dropped.
  4. **Report as asked.** When a day asks for a photo, a pick, or an answer — send it the
     same day. If something isn't working, say so immediately; that's what I'm here for.
- Rendered as a compact list in the existing `.body` style (numbered `kick` labels), not a table.

## 6. Cut "Week 1 — At a Glance"

- Delete the whole section (eyebrow, H2, lead, schedule strip, legend).
- This orphans the schedule-strip CSS (`.schedule`, `.cell`, `.swatch`, legend rules) — remove
  that CSS block too so the file stays clean.

## 7. Day tasks → open-circle checklist items

- **Scope:** the labeled tasks inside each day's `.body` — Day 0 (3 tasks), Day 1 (2), Day 2 (2),
  Day 4 (1), Day 5 (2), Day 6 (the "two quick things" ask), Day 7 (3).
- **Not converted:** Day 3 (it's a decision walkthrough, stays prose), "Done when" exit lines,
  the Weeks 2–4 timeline, callouts.
- **Component:** new `.task` style — an open circle rendered with CSS (`::before` ring in the
  orange accent, transparent fill) sitting to the left of the existing `kick` label; body text
  indents to align. Visual only — no click behavior, prints/PDFs cleanly.

  ```text
  ○ TASK 1 · THE SCALE
    Buy a digital kitchen food scale that measures in grams…
  ```

## Order of work

One commit per item is overkill — proposed grouping:

1. **Hero rework** — items 1, 2, 3, 4 (one coherent hero edit incl. title + footer).
2. **Section rework** — items 5 and 6 (new How-to-use copy in, Week-1 strip + CSS out).
3. **Checklist component** — item 7 (new `.task` CSS + convert all day tasks).

Each step is independently reviewable in the browser before moving on.
