# `client-30-day.html` Revision 5 Plan

Four items from review, resolved by interview.

---

## 1. Day 5 — cut "Learn it (...)"

| Current | New |
|---|---|
| Grab **frozen steam-in-bag** vegetables. Learn it (it's a microwave and a few minutes), taste it today, and tonight add a serving to the prep, alongside the yogurt and the meat. Three containers now. | Grab **frozen steam-in-bag** vegetables, taste it today, and tonight add a serving to the prep, alongside the yogurt and the meat. Three containers now. |

"Taste it today" already covers trying it, so the standalone "Learn it" fragment is dead weight.

## 2. Day 6 — numbered list + water audit restored

Kick relabels from "Two quick things for later" to "Three quick things for later." The prose sentence becomes a numbered list, and the water audit (present in the original `30_day_track.md` but missing from this page) slots back in as item 3, matching the original's grouping and order.

Current:
```html
<p class="task"><span class="kick">Two quick things for later</span>First: roughly what time is the <strong>earliest</strong> you start eating, and the <strong>latest</strong>? Second: from these carbs, which would you <strong>actually eat</strong>? (The list isn't exhaustive, so tell me if a favorite's missing.)</p>
```

New:
```html
<p class="task"><span class="kick">Three quick things for later</span></p>
<ol>
  <li>Roughly what time is the <strong>earliest</strong> you start eating, and the <strong>latest</strong>?</li>
  <li>From these carbs, which would you <strong>actually eat</strong>? (The list isn't exhaustive, so tell me if a favorite's missing.)</li>
  <li>Accurate number, not the ideal one: how many bottles of water are you actually getting through in a day, morning included?</li>
</ol>
```

`<ol>` gets the same plain-list treatment already applied to Day 3's `<ul>` — no new CSS needed.

## 3. Day 7 — cut Task 1 and Task 2, keep only the carb task

You deliver the water-bottle bump and the eating-window line directly; they come off the page. Only the carb task remains, renumbered without a "Task N" prefix (matching how single-task Days like Day 4 label their one task).

Current:
```html
<p class="lead">Genuinely: three foods adopted, a ritual running nightly, and not one thing you love has been banned. Three small moves close the week.</p>
<div class="body">
  <p class="task"><span class="kick">Task 1 · One more bottle</span>Take your daily water count and <strong>add one more bottle</strong>, anywhere in the day. That's the new number. (Morning 2L is unchanged.)</p>
  <p class="task"><span class="kick">Task 2 · A start line</span><strong>Never eat earlier than the time you already start eating.</strong> You already do this. Now it's just a line. (Water, black coffee, and plain tea are always fine.)</p>
  <p class="task"><span class="kick">Task 3 · Your first carb</span>From your list, we start with one pick. Buy enough for the week, and tonight add a serving to the prep, alongside the yogurt, meat, and vegetable. <strong>Four containers now.</strong></p>
</div>
<p class="exit">The board: <b>start-time → 2L water → prepped food first → your bottles through the day → prep tomorrow tonight.</b></p>
```

New:
```html
<p class="lead">Genuinely: three foods adopted, a ritual running nightly, and not one thing you love has been banned. One small move closes the week.</p>
<div class="body">
  <p class="task"><span class="kick">Your first carb</span>From your list, we start with one pick. Buy enough for the week, and tonight add a serving to the prep, alongside the yogurt, meat, and vegetable. <strong>Four containers now.</strong></p>
</div>
<p class="exit">The board: <b>prepped food first → prep tomorrow tonight.</b></p>
```

"Three small moves" → "One small move" (lead), exit line drops the "start-time" and "your bottles through the day" clauses since those aren't on-page anymore.

## Order of work

1. Day 5 pass (item 1).
2. Day 6 pass — kick relabel + list conversion + water audit (item 2).
3. Day 7 pass — task cuts, lead trim, exit-line trim (item 3).
4. Audit: grep for "Learn it", "Task 1 · One more bottle", "Task 2 · A start line", "start-time" to confirm clean removal; screenshot Day 5, Day 6, Day 7 to visually confirm.
