# `client-30-day.html` Revision 6 Plan

Four items from review, resolved by interview.

---

## 1. Day 7 — rewritten lead: cut the "banned" clause, add explicit praise

One rewritten lead (not a separate callout). Credits the client directly for what they built, drops the "not one thing you love has been banned" clause entirely, keeps the existing task/exit line untouched.

| Current | New |
|---|---|
| Genuinely: three foods adopted, a ritual running nightly, and not one thing you love has been banned. One small move closes the week. | One week in, and you built it: three foods adopted, a ritual running nightly. One small move closes the week. |

H2 ("One week in. Your morning is owned.") stays as-is — it's already doing celebratory work; the lead now backs it up with direct credit instead of a reassurance clause.

## 2. Day 6 — clarify "and the latest?"

Confirmed this is Day 6's numbered list, item 1 (the review note mislabeled it Day 7). "The latest?" currently floats without a verb, which reads ambiguously as "latest you stop eating." Repeats "start" so both halves plainly modify the same thing.

| Current | New |
|---|---|
| Roughly what time is the **earliest** you start eating, and the **latest**? | Roughly what time is the **earliest** you start eating, and the **latest** you'd ever start? |

## 3. Cut "After — When the push ends" section entirely

Confirmed no nav/TOC/anchor references it elsewhere on the page. Full `<section>` block (eyebrow, H2, lead, callout) removed. Weeks 2–4 becomes the last section before the footer.

Removed:
```html
<!-- AFTER -->
<section class="section">
  <div class="eyebrow">After — When the push ends</div>
  <h2>The program doesn't leave you on its hardest week.</h2>
  <p class="lead">When the final push is done, you go back to exactly the routine you ran before it: same containers, same rituals, same rhythm. Nothing new to learn; you already lived it.</p>
  <div class="callout">
    <div class="c-label">Heads up</div>
    <p>Expect the scale to tick up a couple of pounds that week. That's <strong style="color:var(--text)">water coming back with your carbs, not fat</strong>. It's completely expected and completely fine. Don't let it rattle you.</p>
  </div>
</section>
```

## Order of work

1. Day 7 lead rewrite (item 1).
2. Day 6 "latest" fix (item 2).
3. Cut the After section (item 3).
4. Audit: grep for "not one thing you love", "When the push ends", "and the latest?" (bare) to confirm clean removal; screenshot Day 6, Day 7, and the page tail (Weeks 2–4 → footer) to visually confirm.
