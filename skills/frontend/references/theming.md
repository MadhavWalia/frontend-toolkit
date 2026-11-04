# Site-wide theming

Decide once and let every page inherit it. Pick the lightest option that fits.

| Need | Use |
|---|---|
| Fast consistent look, no build changes | A theme block in the project's `CLAUDE.md` |
| Real token system on Tailwind v4 | The recipe below |
| shadcn/ui theming | `library/theming/tailwind-theme-builder`, `library/theming/shadcn-ui` |
| Rules derived from a Figma file | Enable the Figma plugin and follow its `figma-power/steering/create-design-system-rules.md` |
| Tailwind utilities and plugins | `library/theming/tailwindcss` |

## One-hue token recipe

All colours derive from `--brand-hue` through OKLCH, so changing one number re-themes the site.
Compiled against Tailwind v4 and contrast-checked at every 10 degrees of hue; see
`tests/test_tokens.py`. Raw values live in `:root` and `.dark`, and `@theme inline` maps them to
utilities such as `bg-background`. The `inline` keyword is what lets dark mode work, because the
utility then points straight at the variable that changes.

```css
@import "tailwindcss";

@custom-variant dark (&:where(.dark, .dark *));

:root {
  --brand-hue: 250;
  --background: oklch(0.99 0.005 var(--brand-hue));
  --foreground: oklch(0.2 0.02 var(--brand-hue));
  --muted: oklch(0.95 0.01 var(--brand-hue));
  --muted-foreground: oklch(0.45 0.02 var(--brand-hue));
  --border: oklch(0.88 0.015 var(--brand-hue));
  --primary: oklch(0.45 0.15 var(--brand-hue));
  --primary-foreground: oklch(0.98 0.01 var(--brand-hue));
}

.dark {
  --background: oklch(0.17 0.015 var(--brand-hue));
  --foreground: oklch(0.95 0.01 var(--brand-hue));
  --muted: oklch(0.24 0.02 var(--brand-hue));
  --muted-foreground: oklch(0.72 0.02 var(--brand-hue));
  --border: oklch(0.32 0.02 var(--brand-hue));
  --primary: oklch(0.78 0.12 var(--brand-hue));
  --primary-foreground: oklch(0.2 0.03 var(--brand-hue));
}

@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-muted: var(--muted);
  --color-muted-foreground: var(--muted-foreground);
  --color-border: var(--border);
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
}
```

Add spacing, type and radius scales in `@theme` only where they differ from Tailwind's defaults.
Name tokens by role (`primary`, `muted`), never by appearance (`blue-500`), so a theme change does
not make the names wrong.

## CLAUDE.md theme block

Paste into a project's `CLAUDE.md` to lock an aesthetic without any tooling. This approach comes from
Anthropic's [frontend aesthetics cookbook](https://platform.claude.com/cookbook/coding-prompting-for-frontend-aesthetics).

```markdown
## Frontend theme
Always design with an editorial aesthetic:
- Serif headlines, magazine grid, generous margins
- Muted palette with one ink accent
- Pull quotes and strong type hierarchy
```

| Preset | Directives |
|---|---|
| Editorial | Serif headlines, magazine grid, muted palette, pull quotes |
| SaaS minimal | One accent, system UI font, lots of air, cards |
| Brutalist | System fonts, visible borders, square corners, loud colour |
| Dark luxury | True black, gold and cream accents, thin serif type |
| Organic | Earth tones, rounded shapes, warm shadows, serif body |
| Art deco | Gold and black, geometric pattern, symmetry |
| Cyberpunk | Neon on dark, monospace, scan lines |
| Retro-futuristic | Gradient mesh, chrome, geometric shapes |

Presets are starting points. Check the result against the quality bar, since several of them invite
the generic tells it warns about.
