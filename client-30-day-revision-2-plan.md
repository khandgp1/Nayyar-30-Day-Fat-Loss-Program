# `client-30-day.html` Revision 2 Plan

Three items from review, resolved by interview:

1. Purge the spaced em-dash (` — `) from client-visible prose. **Eyebrows keep it** (design furniture); **CSS comments keep it** (invisible to client). Prose gets rewritten sentence by sentence, not a mechanical character swap.
2. Rule 2's "Fill it in when it's done" reworded to **marker framing** (nothing to physically fill).
3. The Day-vs-calendar-day rule joins **"00 — How to use this program" as its own rule** (section grows to five rules), and rule 1 is aligned so "today's day" means the first unfinished Day.

---

## A. Section 00 rework (items 2 + 3)

Lead changes from "Four rules" to "Five rules" and loses its em-dash:

> The strip up top is the rhythm these thirty days build. Each day below adds one piece of it. Five rules for using this page:

New rule set:

| # | Kick | Body |
|---|---|---|
| 1 | Only today | Each morning, open the first Day with an empty circle left on it and do its tasks. Don't read ahead and don't plan the week. The Day in front of you is the whole job. |
| 2 | A Day isn't a calendar day | Each Day is sized to fit in one, but it's finished when its tasks are finished, not at midnight. If a Day takes you two, fine. The next Day starts only when this one is closed. |
| 3 | Check it off | Every circle is a task. The Day is done when every circle on it is done. |
| 4 | Yesterday keeps running | Each new Day adds to the ones before it. Nothing you've installed gets dropped. |
| 5 | Report as asked | When a Day asks for a photo, a pick, or an answer, send it the same day. If something isn't working, say so immediately. That's what I'm here for. |

Note: "Day" (capital D) = program day; lowercase "day" = calendar day. Used consistently in this section.

## B. Kick labels that use the em-dash (item 1)

Labels are furniture, not sentences, so they switch to the page's existing `·` separator
(matching "Task 1 · The scale") instead of being rewritten:

| Current | Proposed |
|---|---|
| The evening ritual — tonight, then every night | The evening ritual · tonight, then every night |
| The meat run — buy, cook, eat today | The meat run · buy, cook, eat today |
| First — a quick check | First · a quick check |
| Then — buy it, learn it, stack it | Then · buy it, learn it, stack it |

## C. Prose rewrites (item 1)

Every client-visible ` — ` outside eyebrows/kicks, with its replacement. En-dash ranges
(10–15g, Days 0–5, Weeks 2–4) and the wake → water arrow are untouched.

**Day 0**
- Lead: "No food changes yet. Today is just tools and picks, so Day 1 has something to stand on."
- Task 1: "Buy a **digital kitchen food scale that measures in grams**. Any brand under $20 works. Get it **today** (in-store or same-day)…"
- Task 2: "Buy **plain 0% Greek yogurt**, a few different brands. … No added sugar, no "vanilla," no "honey" — those flavors hide 10–15g of sugar." → "…no "honey." Those flavors hide 10–15g of sugar."
- Task 3: "…tell me your **top 3**: just the three you'd actually eat."

**Day 1**
- Lead: "Light on purpose, so Day 0 has room to finish."
- Morning task: "drink **2 liters of water, before coffee and before food**."
- Yogurt task: "Start eating the yogurt. **Any amount** counts: a spoonful or half a tub."

**Day 2**
- Meat run body: "Buy enough for the week, prepare it, and eat it. Today."

**Day 3**
- Lead: "…disappears from your plate by week two, so we fix taste now, before it becomes a problem."
- "Be honest: **"it was fine" counts as a no.**"
- List: "**You liked it.** Great, keep it…" / "**Close but not there.** Let's make it better: seasoning, a sauce, a different cooking method…" / "**Not working.** Swap it for another pick, no penalty. (Easiest option on the board: pre-cooked chicken breast strips. No prep, hard to get wrong.)"
- "…just **repeat the meat run today** with the new pick: buy, cook, eat, report."

**Day 4**
- Lead: "You don't need the math, just a portion size."
- Task: "…add it to the fridge, ready to grab tomorrow."
- Callout: "Be strict about this one. Everything you eat *after* it is still completely yours."

**Day 5**
- Lead: "High-volume, fills you up, almost no calories, so every later change lands on someone who's already full."
- Swap check: "…we swap in **green beans, cauliflower, or a mixed medley**. Same frozen steam-in-bag category, same task."
- Stack task: "…tonight add a serving to the prep, alongside the yogurt and the meat."

**Day 6**
- "If something isn't clicking (a meat that's stalling, a step that keeps slipping), we talk it through and fix it."
- "(The list isn't exhaustive, so tell me if a favorite's missing.)"

**Day 7**
- Lead: "Genuinely: three foods adopted, a ritual running nightly…"
- Task 1: "…**add one more bottle**, anywhere in the day."
- Task 2: "You already do this. Now it's just a line."
- Task 3: "…tonight add a serving to the prep, alongside the yogurt, meat, and vegetable."

**Weeks 2–4**
- Lead: "From here it just gets fine-tuned. This is what a day looks like, every day."
- Timeline items: "Hold your start time, nothing before it" / "Your prepped containers before anything else: yogurt, protein, vegetable, carb" / "Prep tomorrow's containers: same ritual, every night"
- Closing: "I'll add **one small change at a time**, based on how your check-ins go: a bit more protein, a portion tweak, a longer morning window, some daily walking. … And tell me how you're feeling. That's the most useful thing you can report."

**After**
- "It's completely expected and completely fine. Don't let it rattle you."

## Order of work

1. **Section 00** — five-rule rework (items 2 + 3 in one edit).
2. **Kicks** — the four `·` label swaps.
3. **Prose sweep** — Day 0 → After, section by section, then a `grep ' — '` audit to confirm only eyebrows and CSS comments remain, plus a screenshot pass.
