# `client-30-day.html` Revision 7 Plan

Two items from review, resolved by interview.

---

## 1. Weeks 2–4 — reword the H2, drop standalone "board"

"Board" is an established checklist/menu metaphor used elsewhere on the page (Day 3's "Easiest option on the board," Day 7's exit line "The board: prepped food first → prep tomorrow tonight"), but as a standalone H2 with no "the board:" framing around it, it doesn't read clearly. Swapped for plain language that also echoes the lead sentence right below it ("The routine you built in week one...").

| Current | New |
|---|---|
| Same board, small changes. | Same routine, small changes. |

Day 7's exit line keeps "The board:" as-is — that usage is an established recap-line prefix elsewhere on the page, so only the standalone H2 usage was the problem.

## 2. New celebratory section between Day 7 and Weeks 2–4

Full section, same pattern as every other block (eyebrow + H2 + lead), no tasks or checklist — this is a milestone beat, not a to-do. Pure "look what you built" framing, no tie-forward to weeks 2–4 (that bridge is already the job of the Weeks 2–4 lead).

New section, inserted after Day 7's closing `</section>` and before the Weeks 2–4 `<!-- WEEKS 2-4 -->` comment:

```html
<!-- MILESTONE -->
<section class="section">
  <div class="eyebrow">Milestone</div>
  <h2>You built a whole system in a week.</h2>
  <p class="lead">Wake time, 2 liters of water, prepped containers, a ritual running every night — none of that existed eight days ago. You built it, ran it daily, and it held. That's the hard part, done.</p>
</section>
```

## Order of work

1. Weeks 2–4 H2 reword (item 1).
2. Insert the new Milestone section between Day 7 and Weeks 2–4 (item 2).
3. Audit: grep for "Same board, small changes" (old H2) to confirm clean removal; screenshot Day 7 → Milestone → Weeks 2–4 transition to visually confirm placement, tone, and spacing.
