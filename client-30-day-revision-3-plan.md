# `client-30-day.html` Revision 3 Plan

Four items from review, resolved by interview:

1. Check-ins are the client's responsibility, unprompted → rework rule 5 in section 00 (stays five rules), warm tone, no "I don't chase."
2. Day 1 lead ("Light on purpose, so Day 0 has room to finish.") → cut clean, no replacement.
3. "breakfast" → "first food" in both Day 2 spots, and the wake → water → yogurt chain untied from the morning.
4. Day 2 gets a "Need ideas? Just ask" **callout box** after its tasks.

---

## 1. Section 00 — rule 5 rework

Kick changes from "Report as asked" to ownership framing; body absorbs the per-Day asks:

> **5 · Check in, unprompted**
> Your check-ins are what I coach from, so send them without being asked. When you close a Day,
> tell me how it went. When a Day asks for a photo, a pick, or an answer, send it the same day.
> If something isn't working, say so immediately. That's what I'm here for.

## 2. Day 1 — cut the lead

Delete `<p class="lead">Light on purpose, so Day 0 has room to finish.</p>`. Day 1 runs
H2 → tasks. (Only day without a lead; agreed acceptable.)

## 3. Day 2 — de-breakfast

| Where | Current | New |
|---|---|---|
| H2 | Tonight, you prep tomorrow's breakfast. | Tonight, you prep tomorrow's first food. |
| Ritual task | That's tomorrow's breakfast, already waiting. Your morning becomes: wake → water → the yogurt that's sitting there. | That's tomorrow's first food, already waiting. Your day starts itself: wake → water → the yogurt that's sitting there, whenever you start eating. |

"first food" also echoes Day 4's strict rule ("first food you eat each day"), so the vocabulary
now lines up across the sheet.

## 4. Day 2 — help callout

New `.callout` (same component as Day 4's "The one strict rule") placed after Day 2's task body:

```html
<div class="callout">
  <div class="c-label">Need ideas?</div>
  <p>Recipes, seasonings, cooking methods, easy shortcuts. If you're stuck on any of it, just ask.</p>
</div>
```

## Order of work

1. Rule 5 rework (item 1).
2. Day 1 lead cut (item 2).
3. Day 2 pass (items 3 + 4 in one edit set).
4. Audit: grep for "breakfast" and leftover em-dashes, screenshot Day 1–2 and section 00.
