# Design systems

## What one is

SBB's [Lyne design system](https://digital.sbb.ch/en/design-system/getting-started/intro/) calls a
design system a digital construction kit: teams take ready components from it to assemble an
interface, and it also sets out the brand's design language, such as how logo and colour are used,
and the principles behind them. Its purpose is consistency across products and devices. It does not
cover every need. Teams may build their own components when it falls short, and additions come back
through contribution rules.

So a design system is not a component folder. It is shared decisions plus the means to reuse them:

| Layer | Answers | Lives in |
|---|---|---|
| Principles and brand | Why does it look and behave this way? | `PRODUCT.md`, `DESIGN.md` |
| Tokens | Which colour, space, type and motion values exist? | `tokens.css` or Tailwind `@theme` |
| Components | What are the reusable building blocks? | The component directory, Storybook |
| Patterns | How do blocks combine for a job? | `DESIGN.md` |
| Governance | Who changes it, and how? | `DESIGN.md`, contribution notes |

Scale it to the project. One small site needs tokens and a short `DESIGN.md`. Governance and
Storybook pay off when several people or products share the system.

## Set one up with Impeccable

Run from the project root:

1. `/impeccable init` records users, purpose and brand in `PRODUCT.md`.
2. Existing product: `/impeccable extract` pulls repeated values and components into the system.
   New product: `/impeccable shape` sets the direction first.
3. Define tokens as described in [theming.md](theming.md).
4. `/impeccable document` captures the visual system in `DESIGN.md`. Commit it.
5. `/impeccable live` steers changes on the running app, when one exists.

Impeccable reads the project's tokens, Tailwind config and components, so later commands follow them.

## Working in a system

- Use a token or component that exists. Search before creating.
- Never hardcode a colour, spacing or font value that has a token.
- A one-off need stays local to the feature, as SBB allows.
- A need that repeats gets promoted: add the token or component, then update `DESIGN.md` in the same change.
- When the design and the system disagree, raise it. Do not quietly fork the system.
