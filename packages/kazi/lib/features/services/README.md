# Services

The operational tab. Where the home answers *"how much am I getting"*, this
answers *"what did I do"* — over a window of its own, independent of the
billing cycle.

## List / Summary is a switch, not a second tab

Both sides answer the same question over the **same filtered services** — one
row at a time, one total at a time. Making the summary inherit the filters (the
most expensive thing to build in a management app) beats duplicating them on a
parallel screen.

It is drawn as a segmented control, deliberately shaped unlike the chips right
below it: those two are the faces of the tab, and everything in the row under
them is a filter. The header band closes above the switch, not below it, so the
switch belongs to the content it governs rather than to the title bar.

## The row

```
▏ Alongamento em gel            R$ 81
▏ Marina R. · 09 ago         de R$ 180
```

- **Commission is the headline, gross is the footnote.** Same order the home
  panel uses, and the answer to the question that brings someone into the app.
- **The category lives in the leading edge and nowhere else**, or a list of
  services turns into a row of coloured blocks. `KaziCategoryBorder` makes it
  the card's own left border rather than content, which returns the ~16px the
  old dot took from the client's name — the line most likely to overflow on a
  small screen — and lets the colour follow the corner instead of squaring off
  against it.
- **The edge never changes colour.** It says which type the service is, and the
  type does not change when the payment arrives. Repainting a paid row green
  would erase the only visual reading of category the list has.
- **The client's name drops on a list that is already one client's.** On the
  ficha the row reads "09 ago · recebido": repeating the name on every line
  says nothing, and it is the one thing long enough to push the situation off
  the end of the line the two share (`ServiceCard(showClient: false)`).
- **`receivedMarkSpan` is a word on the date line**, not a badge and not a
  colour change on the row: "Júlia S. · 08 ago · recebido", with the gross
  still in its column. A situation that takes the place of a figure costs the
  reader the number they came to check.
- Yellow is not available on the row either — on these screens it belongs to
  the button that registers a service.
- Rows are separated by a **gap, not a rule**: each is a bordered card, and a
  divider between two bordered cards reads as a third border.

### Swiping

The swipe flips the payment stamp and the row **stays put** — `confirmDismiss`
always returns false, since the row still belongs to the list and animating it
out would be a lie. Swiping a paid service undoes the stamp, so the background
label has to say so.

Both branches of the row (ad-wrapped and plain) must be **keyed**; `Dismissible`
throws without a stable key. The revealed background is clipped to the card's
corners, or the colour pokes out square at both ends of the swipe.

## Three controls, three different jobs

The tab is governed by exactly three things, and confusing them is what
produced the old client sheet that duplicated the filter sheet:

- **Chips** are the quick filters, always visible: **period and status**. One
  tap applies, another removes. A chip is never yellow — that belongs to the
  FAB. The period chip names its month — "Agosto", not "this month" — and says
  the same thing the header card above the list says, because both read
  `periodLabel`.
- **Search** is a *mode of this screen*, not a route. The header becomes the
  field, the switch and the chips go away, and **the period is ignored**:
  someone typing a client's name wants to find them in everything they have
  registered, not in the six weeks the chips happen to be showing. It matches
  type, client and note, and answers in two blocks — services and clients.
- **The filter sheet** holds what does not fit in a chip: the full period
  picker, type (several at once), and client. Its four groups read, in order,
  período · situação · tipo de serviço · cliente, and each control shows its
  own value — the period presets name their month, and "Escolher datas" says
  the range it picked instead of repeating its own name.

The type and client filters have **no permanent chip**. They appear as one only
once applied, with a clear button — which is what makes a filter applied from
somewhere else (the client ranking, a shortcut from the home) visible and
undoable where the rows are.

### The sheet counts before it applies

The button reads "Ver 12 serviços", so nobody applies blind. The count is
computed over the services **already in memory**, which is why it disappears —
falling back to "Aplicar filtros" — the moment the draft period stops matching
the loaded one: past that point the honest answer needs a query, and a made-up
number would be worse than none.

Only the period reaches Firestore. Status, type and client all narrow the list
in memory, so changing them costs nothing and clearing them from a no-results
screen brings the rows straight back.

### The type and client lists are sized for a big catalog

Both are built from the services already fetched, so they can never offer a
filter that only empties the screen — and both have to survive a user with
hundreds of types and a busy month.

The **types** are rows (tick · colour · name · count), of which only a handful
show at once: what is selected comes first, so the cap can never hide an
applied filter; past eight types a search field appears above them; and the
full list is one tap away. Everything there is matched on the device.

The **client** is a field rather than a row of chips, because a busy month has
about as many clients as it has services. It opens `KaziDropdown`'s searchable
picker, which is the same control the service form uses.

### Search fetches once, not per keystroke

Opening the mode loads every service the user has, once. Re-querying per
character would spend a read per letter to answer a question the device can
already answer. If that fetch fails it falls back to the period's services
rather than taking the screen down.

Clients come from `searchByName`, because the services alone cannot supply
them: a client with no service yet would never appear. A late answer for a term
the user has already moved past is dropped.

A search that finds nothing is not a dead end — it becomes the shortcut that
creates what was being looked for.

## `PeriodHeaderCard`

The header of the current cut, fixed above the first row and **identical in both
views** — List and Summary describe the same services, so two different headers
would be two different answers to one question.

It answers three things: which period is on screen, what it earned, and how much
of it has not arrived. What it reports is always the exact sum of what is below
it: change the period chip and the whole card is rewritten; filter by client and
the figures shrink with the rows.

- The headline is **`totals.commission`** — the earnings, not the gross. The
  gross follows in the subtitle, where "de X gerados · Y já recebidos · Z
  pendentes" spells out the arithmetic in the three permitted words.
- The split is **dropped until something has been paid**. A permanent "R$ 0 já
  recebidos" reads as a problem rather than as absence — the same rule the home
  panel follows.
- A **plain card, not a second graphite panel**: the home owns that panel.
- The headline scales (`FittedBox`) rather than wrapping; a truncated amount is
  worse than a smaller one.

### The bulk action is the card's last line

Separated by a rule, and **absent when nothing is owed**. It lives here rather
than in a floating bar at the bottom for two reasons: it does not fight the FAB
for the bottom-right corner, and being inside the header makes it obvious that
it applies to *this cut*, not to the app.

It stamps everything **currently listed** and still owed — never the billing
cycle, which would stamp services the user cannot see. Hence the count in the
label: it is always the number of rows below it that will change.

The pending amount is null when a rate is missing. An understated amount on an
action that writes to every one of those services is worse than no amount.

The confirmation says what it is about to do in money and what it will leave
alone — a bulk stamp on a month of earnings is the one action nobody wants to
guess about. Undo carries the **exact ids that were written**, never re-derived
from a list that may have moved on: one mistaken tap would otherwise rewrite
dozens of payment dates with no way back.

A second tap while the write is in flight is ignored.

## Summary

### The weekly chart

One column per week of the **filtered period**, and the weeks are cut from the
period rather than from the calendar: seven days from whatever the chips picked,
because a pay cycle rarely opens on a Monday.

**Two inks, and one of them is neutral.** Graphite is what has arrived, light
grey is what has not. Yellow is deliberately absent: on bars this thin it
vibrates against the graphite and the chart starts reading as decoration rather
than as data — and it would compete with the FAB ten centimetres away.

A week with no service stays as a column of zero. It is the one that tells the
story: the last bars of a cycle are all grey because the payment arrives in a
block, at closing.

**The legend is mandatory and sits under the chart.** A chart with no key, in an
app about money, is guesswork. Every column also carries a `Semantics` label
reading week, amount and how much of it arrived — the chart is only allowed to
exist because it can be read out loud.

Bars are computed in memory from the services already fetched, so the chart
costs no query. A service whose rate cannot be resolved is left out and counted
in `unconverted`, never summed at face value.

With the chart present, the header's subtitle drops the received/pending split
and says only "de X cobrados dos clientes": the chart *is* that split, said
better.

- Percentages are **amber, never brand yellow** — yellow is surface, never text
  ink (see the design system README).
- Bar colours are keyed on the **catalog item's id, never its position** in the ranking:
  colour follows the entity, so changing a filter must not repaint the bars that
  survive it.
- Bar values are drawn in **ink, not the slice's colour** — the bar already
  carries the identity, and coloured numbers read as status.
- An all-zero period is guarded before dividing; every bar would otherwise be as
  meaningless as the next.
- The client ranking is a **podium, not a directory** — the Clients tab holds the
  full list. Tapping one filters to that client and stays on this side, which
  answers "how much did this person bring me" without a new screen.

## Details

Read top down: **what the user earns, then the facts that produced it.**

- The earnings sit in a **graphite panel** — the same surface the home uses for
  the number it exists to report, because this screen exists to report this one.
  Under it, `45% de R$ 180,00` in amber: the gross is context, not a peer, and
  it is the only place the gross appears — a row of its own gave a figure the
  reader did not come for the same weight as the one they did.
- Everything else is a `DetailInfoRow` — the same bordered card the client and
  the catalogue item are read in, so one screen teaches the next. The **type
  carries the category edge**, the same mark the list rows use, and it is the
  only row with an edge or a colour at all: no other one has an identity to
  carry, so none takes an icon either.
- `Situação` says **Pendente** or **Recebido em <data>**. A status that is a
  word, not a colour, is the rule the whole app follows.
- The date shows a time **only when the service has one**. A date-only service
  sits at midnight, and printing "00:00" would invent precision the record does
  not have.
- One amount, not three. `Gerado` was a row of its own and `Retido` another —
  the second a word outside the permitted vocabulary, and both numbers the
  panel already carries or the reader can reach by subtracting. The rows below
  are facts, not figures.
- When the service was registered in a currency other than the user's default,
  the converted twin sits **directly under the amount it restates**, above the
  gross line. Far from its figure it reads as a total of its own.

### The actions

**Marking received is the footer CTA**, in the same `KaziFormFooter` the forms
submit from — a rule, then one full-width button where the thumb already is. It
is the one thing this screen exists to offer, and the label says which way it is
about to flip the stamp. Undoing it drops the fill for the footer's outlined
form: an undo that shouts as loudly as the thing it undoes reads as the screen's
main offer. A second tap while the write is in flight is ignored.

**Deleting lives in the "…"**, never as a button in the body. A full-width
control at the end of the content gives an action performed once a quarter the
visual weight of a primary one, and puts it exactly where the thumb stops
scrolling. The same shape applies to the client and the catalog item.

## The form

Four fields, two of them already answered by the catalog, and the whole screen
reads as one column of boxes. Everything here follows the screen inventory
(`kazi_core/docs/screens.html`, Tela 12).

- **The caption lives inside the box.** `KaziField` — and the three controls
  built on it, `KaziFieldInput`, `KaziFieldPicker` and `KaziFieldDate` — draw a
  small upper-cased label above the value. A floating placeholder disappears
  the moment it is answered, and a form of six answered fields becomes six
  unlabelled numbers, which is exactly the state someone re-reads before
  saving money. **This is every form in the app**, not just this one: the
  client form, the catalog form, the filter sheet's client picker, the pay
  cycle and the guided setup all draw the same box. Search boxes deliberately
  do not — a search field has a magnifier and no caption, and it is not
  answering a question about the record.
- **The box is the only thing outlined.** It is a card like any other —
  `colors.card`, a border, and the ink of a tap — and the control inside it
  draws no border of its own: a frame inside a frame reads as two controls,
  and the caption already says where the field starts. The box's outline is
  what carries state, the focus ring while it is typed in and danger while it
  is refusing to be left alone.
- **A picker shows no chevron.** It is the same box a typed field is, and a
  caret pointing down on half the fields distinguishes nothing — tapping any
  field opens whatever that field offers.
- **Each picker carries its own "+ Novo"** inside the box, with its own tap
  target: the field opens the list, the pill creates what the list could not
  offer. `KaziFieldAction` draws it on the page's own ground so it reads as a
  control laid over the field rather than as part of its value. Both pickers
  open the same sheet `KaziDropdown` opens: one picker for the app, two fields
  drawing it.
- **Two hints, not two more fields.** The sentence under a control is part of
  it: the catalog line says the price and commission can be changed for this
  record alone, the client line says it is optional. The third is amber and is
  not a hint about a field but the *answer* the two money fields produced —
  "R$ 81,00 são seus".
- **Value and commission sit side by side** because they are one decision; the
  currency picker is above them, since a currency the amount is not stored in
  is the one mistake this screen must not allow.
- **The date is three chips and no calendar.** Today and yesterday cover almost
  every registration in one tap. The third opens the picker, and once a day
  comes back **it replaces the chip's own label** — a chip that keeps saying
  "Escolher" after answering leaves the chosen date invisible, which is how the
  old always-visible date field justified its existence.
- **The bar closes with a cross, and the footer button says what the title
  says.** The form is opened over whatever the person was reading, so leaving
  it drops what they typed rather than stepping back somewhere; and
  "Registrar serviço" as both title and button is the label-is-a-contract rule.
  The button lives in `KaziFormFooter` — outside the scroll, at full width,
  under a rule that makes it the page's foot rather than the last thing in the
  content. The client form and the catalog form submit from the same bar. A
  second tap while the write is in flight is ignored.

### The quick-add sheets

The two "+ Novo" sheets share `QuickAddSheet`: title, the fields, one button.
It reads **"Criar e usar"** and not "Salvar" because the created record comes
back selected — a sheet that closed and left the person hunting for what they
just made would not have been a shortcut.

- The catalog sheet asks name, default price, commission and colour. The
  eighteen colours **scroll horizontally in one row**: as a grid they add three
  rows and push the button off the screen, and the partly cut last circle is
  itself the signal that there are more.
- The client sheet asks name and phone; the document is optional. A client
  with no way to be reached is a row that only takes up space, and the number
  is asked once, while the person is still in front of you.
- **A namesake is answered in the sheet, not found later as a second row.**
  The first tap on "Criar e usar" looks the name up; if somebody already has
  it, the sheet says so on a `KaziNote` and offers the two answers as radios,
  *use the one that exists* or *create anyway*. The second tap acts on the
  choice. Editing the name drops the warning, because a warning about a name
  nobody is typing any more is worse than none.
  - **The warning names what makes the person recognizable**, in the order it
    can: "com 12 serviços" first, then the last service and its date, then the
    bare name.
  - The count comes from the denormalized `servicesCount` when the document
    has it. **When it does not — a client whose services predate the counters,
    which is most of them — the warning spends one aggregate read**
    (`ServicesRepository.countByClient`) rather than leaving the name
    unqualified: the count is the whole reason the warning is actionable, and
    an aggregate is one read no matter how long the history. It is taken only
    at the moment the warning is about to appear, never while typing.
  - **A count that cannot be taken is null, never zero.** Zero falls through to
    the last service and then to the bare name, because "com 0 serviços" next
    to a name the user recognizes reads as a wrong fact rather than a missing
    one.
  - The rule itself is `ClientNamesakeRule`, shared with the full client form
    so the quick-add cannot be the way around it. It **never blocks and never
    fails a save**: two people legitimately share a name, and a lookup that
    throws reads as "no namesake" rather than costing the user their typing.
    Two documents that are both filled and different settle it as a
    coincidence. A repeated *document* is the rule that does block, and that
    one is `ClientDocumentRule`.
  - Choosing the existing client writes nothing and skips validation — the
    phone of a client that is not being created has nothing to say — and the
    picked client is appended to the form's list, because the form holds only
    the first hundred and a namesake found by query is often not among them.
- Both sheets pad their foot by the keyboard's inset **or**, when it is down,
  by the system navigation bar: a modal sheet is drawn edge to edge, so without
  it the button sits under Android's gesture bar and cannot be pressed. The
  selection sheet behind every picker does the same for its last row.
- Cancelling a sheet never discards what was already filled in on the form
  behind it.

## The catalogue

Three chips, and the third is the point of the other two: **Todos · Mais usados ·
Sem comissão**. An item with no commission configured enters the generated total
and not the user's, so the chip is a shortcut to a gap worth fixing — which is
why it also gets the danger ink on the row's subtitle.

A **legacy item is not a gap.** It carries its commission as a mirrored
`discountPercent`, so `effectiveCommissionPercent` resolves it and the chip
leaves it out. Reading it as missing would send the user to fix nothing.

The row says `R$ 180 · 45% para você` and `18 usos`; the count and the lifetime
figures come from the denormalized counters (see `core/counters.md`) and are
simply absent on an item the counters have never been written to — "—" rather
than a zero the user might believe.

The detail leads with **what the user keeps** on one of these, then what the
item has done, and closes with the sentence the screen would otherwise
contradict: changing the price here reaches the next records and none of the
ones already registered. History is immutable, and a screen that suggests
otherwise has to say so in text.

Archiving is in the "…". **Deleting does not appear on the detail at all** — it
exists only behind the archive screen, and only for an item nothing references.
An item that is referenced keeps its delete button and explains itself when
tapped, with the count and the amount that make the reason concrete: a missing
button leaves the person wondering where it went, where a refusal with a number
closes the question.

## `CatalogItem` and the names that stayed behind

What the product calls a **catalog item** was `ServiceType` in code until it was
renamed. Only Dart identifiers moved. Every name that something outside this
repository already reads keeps the old vocabulary — and none of it is a leftover
to be "finished off" later:

| Frozen name | Where | Why it cannot move |
|---|---|---|
| `serviceTypes` | Firestore collection (`FirebaseCatalogItemRepository.path`, the currency backfill) | Renaming it orphans every document already written. |
| `typeId`, `typeName`, `type` | Fields of a service document | Written and read by app versions already on Play. |
| `serviceTypeId` | `Service.toMap` in kazi_core | The API's key on the wire. |
| `service_type_created`, `service_types_count`, `form: service_type`, `save_service_type` | Analytics event, user property, parameter, replay target | A rename splits one metric into two, and every dashboard keeps querying the old name. |

Dart-side there is exactly one vocabulary: `CatalogItem`, `catalogItemId`,
`Service.catalogItem`.
