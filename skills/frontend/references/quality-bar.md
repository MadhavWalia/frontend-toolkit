# Quality bar

The definition of done for frontend work. A project's own standards win where they are stricter.

## Idiomatic

Write what a senior maintainer of this stack would write.

- Follow the framework's current conventions, confirmed through Context7, not from memory.
- Match the project's file layout, naming, state and styling approach before introducing any other.
- Use semantic HTML first: `button`, `a`, `nav`, `main`, `label`, `dialog`, `details`, `form`.
- Reuse existing components and tokens. A new component needs a reason the existing ones fail.
- Keep server and client responsibilities where the framework puts them. Do not fetch in effects when
  the framework has a data layer.

## Lean

Every byte, dependency and abstraction has to earn its place.

- Prefer, in order: the platform, what is already installed, a small focused package, a large package.
- CSS does layout, transitions, `:has()`, container queries, scroll snap and `<dialog>`-style work
  before JavaScript does. Motion libraries are for sequencing, gestures and scroll choreography that
  CSS cannot express.
- Before adding a dependency, state what it replaces, its install size, and the cost of ten lines of
  your own code instead.
- No speculative abstraction: no wrapper, prop or config option without a current caller.
- Delete what a change makes unused. A diff that removes code is usually an improvement.
- Default budgets for a content page, unless the project sets its own: 100 KB of JavaScript and 50 KB
  of CSS, compressed, on first load. Report the real numbers when you exceed them.

## High quality

Check these on the rendered result, not by reading the code.

- **Responsive:** works from 320px to wide desktop, with no horizontal scroll.
- **States:** loading, empty, error, disabled, hover, focus and long-content cases all exist.
- **Keyboard:** every action reachable, focus visible, order logical, no traps.
- **Accessible:** WCAG 2.2 AA. Text contrast 4.5:1, or 3:1 for large text. Labelled controls. Target
  size at least 24px. Run the `fixing-accessibility` skill on anything interactive.
- **Motion:** honours `prefers-reduced-motion`; animates `transform` and `opacity`.
- **Theme:** colours come from tokens. Both themes are checked if the product has both.
- **Vitals:** LCP under 2.5s, INP under 200ms, CLS under 0.1 at the 75th percentile.
- **Console:** no errors, warnings or failed requests.
- **Types and lint:** the project's checks pass.

## Avoid the generic look

- Commit to one point of view from the product's context, not a default template.
- Avoid the common tells: purple gradients, gradient text, glow shadows, side-stripe cards, and
  identical three-card feature rows. The Impeccable detector flags these automatically.
- Use real content while designing. Never ship lorem ipsum or invented metrics.

## Finish report

State what was rendered and at which widths, what was measured, which dependencies were added and
why, and anything not verified.
