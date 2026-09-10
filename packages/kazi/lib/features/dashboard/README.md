# Dashboard (the home)

One screen, two blocks: a graphite money panel for the **pay cycle**, then a
list of **what was done today**.

**Two kinds of nothing, and only one of them is empty.** An account with no
service in the cycle at all gets the invitation — brand block, a line about how
the total fills in, and a button that registers the first one. A day with
nothing on it, in a cycle that has services, is just a quiet day and says so in
one muted line: the brand block there would announce an empty account every
morning before the first appointment. The panel keeps reporting the cycle,
zeroed, in both cases.

A failed read is a **band above the content**, not a screen and not a snackbar.
The cycle total keeps the last value it knew rather than blanking — the fear
behind a failed load in a money app is that the records are gone, and a screen
that empties itself confirms it.

## The money panel

| Line | Shows | Why |
|---|---|---|
| Eyebrow | `AGOSTO · FECHA EM 22 DIAS` | The month the cycle's window **opens** in, so 6 Aug → 5 Sep reads "Agosto" — naming it after the payday would label the window with work it does not cover. Without the countdown the amount above it floats free of any reference. |
| Amount | `totals.commission` | What the user takes home: the number they cannot work out in their head with a different commission on each of 32 services. |
| Below | `Seu ganho · de <gross> gerados em N serviços` | Names the amount above it, then qualifies it. The share percentage that used to open this line was dropped: it says nothing the two figures do not already say, and "seu ganho" is the one word the rest of the app uses for the amount. **Not tappable** — a figure that navigates on touch is a control disguised as a number; the door into the summary is the row at the end of the day's list, which says where it goes. |
| Received | `alreadyReceived(...)` | Rendered **only** once something has been paid. A permanent "R$ 0 já recebidos" reads as a problem rather than as absence. |

The amount uses `FittedBox(scaleDown)`, not wrapping or ellipsis: six digits in
Archivo 800 at 32px do not fit 360dp, and a truncated amount is worse than a
smaller one.

The panel paints **under the status bar**. The page therefore removes the top
padding (`MediaQuery.removePadding`) so `KaziSafeArea` does not leave a strip of
page background above it, and hands the inset down for the panel to re-apply.
Status-bar icon brightness comes from `colors.overlayOn(colors.money.surface)`
— derived from the panel, never hardcoded, or it breaks when the panel changes
and blackens the navigation bar in dark mode.

## The two shortcuts

Neither opens a screen of its own. Both land on the services tab with a filter
applied and **visible in the chips**, so the filters are learned once and stay
editable where the rows are — the rule every "ver mais" in the app follows.

| Shortcut | Where | Lands on |
|---|---|---|
| `Ver na lista` | beside the day's heading | Serviços · Lista · período Hoje |
| `Ver resumo de <mês>` | last row of the home | Serviços · Resumo |

## Today's list

The day's subtotal lives in the section header, next to the list it describes:
the job is operational — confirming nothing went unregistered — not emotional,
which is why it is not at the top of the screen. It reports the **commission**,
because `TodayServiceCard` leads with each service's commission and a subtotal
has to add up to the rows under it. When a rate is missing the amount is dropped
rather than understated.

`TodayServiceCard` is shaped like a services-list row for the same reason: the
share the user keeps is the headline, the gross the footnote it came out of.
Two cards answering the same question with the numbers swapped is how the
subtotal and the rows stopped agreeing in the first place.

Free users get a banner in this list by the same rule as the services tab —
after every third card, or after the last one of a shorter day. Placement and
spacing are in the [ads README](../../core/services/data/ads/README.md).

## Slots above the list

`OnboardingChecklistCard` and `ActiveUserNudges` both render nothing with their
flags off, and are mutually exclusive by segment: the checklist belongs to users
the guided setup ran for, the nudges to users it deliberately did not. For every
existing user with the flags off, the slot is empty.

`PartialTotalsNote` is deliberately **below** the graphite panel: its ink is
tuned for the page surface, not a dark one. It is guarded by `isPartial` at the
call site rather than collapsing itself, so the surrounding gap goes with it.

## The menu avatar

A second door into the menu, alongside the tab. Two doors on purpose: when the
Agenda takes the fourth seat in the nav bar the menu loses its tab and this
becomes the only way in, so it has to be a habit by then.

## Fetching

One query serves both blocks — the home reports the cycle's totals and slices
today out of the same list. The cycle window is **awaited** from the user's
configured pay cycle rather than read through `billingCycleProvider`'s
synchronous fallback: the page is already showing its loading state, so waiting
costs no visible frame, whereas the fallback would fetch the calendar month on
every cold start and then correct itself — a flash of the wrong number.

Rates are resolved before totals: ordering by value and summing both require
every service expressed in the same currency. The rate book is fail-open — an
empty one still renders, with the totals flagged incomplete.
