# Catalog

Status of every tool in the requested sections of
[Claude-Code-Frontend-Design-Toolkit](https://github.com/wilwaldon/Claude-Code-Frontend-Design-Toolkit)
(README as of April 2026), checked on 2026-11-04.

**Installed** runs in every session. **Library** is vendored here and read on demand. **Ready** is
installed but off, or one command away. **Replaced** and **Skipped** give the reason.

## Design system

| Tool | Status | Notes |
|---|---|---|
| Impeccable | Installed | Plugin 4.8.0. Detector hook runs on UI edits in all projects. Telemetry off |

## Site-wide theming

| Tool | Status | Notes |
|---|---|---|
| Tailwind CSS Kit | Library | `theming/tailwindcss` |
| Design Tokens (phrazzld) | Replaced | Repository deleted. `references/theming.md` has a tested recipe |
| Design System Architect | Replaced | Directory listing only, with no verifiable source. Same recipe covers it |
| UI Styling (ClaudeKit) | Replaced | Third-party mirror of a paid kit. Use `theming/shadcn-ui` |
| Tailwind Styling (MajesticLabs) | Skipped | Repository archived |
| Create Design System Rules | Ready | Ships in the Figma plugin under `figma-power/steering` |
| CLAUDE.md theme blocks | Library | `references/theming.md` |

## Animation and motion

| Tool | Status | Notes |
|---|---|---|
| Animation skills (freshtechbro) | Library | 5 web skills of the 23. Last updated Nov 2025, so confirm APIs with Context7. Its 3D skills are covered by Three.js below |
| Motion skill (jezweb) | Replaced | No longer in the repository. Use `motion/motion-framer` |
| Design Motion Principles | Library | `motion/design-motion-principles` |

## UI/UX intelligence

| Tool | Status | Notes |
|---|---|---|
| Wondelai skills | Library | The 5 UX skills; marketing and growth skills left out |
| Jeffallan skills | Library | React, Next.js, Vue, Angular, under `framework/` |
| Google Stitch skills | Skipped | Tied to the Stitch service. DESIGN.md is handled by Impeccable |
| UI/UX Design (Useforclaude) | Skipped | Source repository not found. Wondelai covers it |

## Design-to-code

| Tool | Status | Notes |
|---|---|---|
| Figma MCP | Ready | Official plugin, disabled, not signed in. README's SSE command replaced by the remote server |
| Figma Code Connect | Ready | `figma-code-connect` skill in the plugin. Figma plan required |
| Web Artifacts Builder | Skipped | The Artifact tool does this here |

## Testing and browser automation

| Tool | Status | Notes |
|---|---|---|
| Playwright MCP | Installed | Pinned 0.0.84, headless, isolated profile |
| Chrome DevTools MCP | Installed | Pinned 1.12.0. Package is Google's `chrome-devtools-mcp`; README's name returns 404 |
| Webapp Testing | Replaced | Playwright MCP covers it without running scripts |
| Storybook MCP | Ready | Per project; see `references/pipelines.md` |
| Visual Regression | Library | `quality/visual-regression`, now at qf-studio/navigator. Generators removed |
| Web Quality (Addy Osmani) | Library | All 6 skills under `quality/` |

## Docs and context

| Tool | Status | Notes |
|---|---|---|
| Context7 | Installed | Pinned 4.5.0, no API key |
| Skill Seekers | Ready | `pip install skill-seekers` when needed |
| Firecrawl | Ready | Official plugin. Needs a paid API key |

## Framework skills

| Tool | Status | Notes |
|---|---|---|
| D3.js | Replaced | Upstream has no licence, so it cannot be vendored. Use `dataviz` and Context7 |
| Three.js | Library | All 13 skills under `framework/` |
| shadcn/ui | Library | `theming/shadcn-ui`, from jezweb. Google's version needs Stitch |
| TypeScript LSP | Installed | Official plugin with language server 6.0.3 and TypeScript 6.0.3, since TypeScript 7 has no `tsserver` |
| Baseline UI, a11y, motion perf | Library | Plus `fixing-metadata` |

## Deploy and preview

| Tool | Status | Notes |
|---|---|---|
| Vercel | Ready | CLI 65.11.0 installed. Official plugin disabled, MCP server not signed in. Telemetry off |
| PinMe | Ready | Runs through npx. Public IPFS, so ask first |

## Recommended stacks

See `references/stacks.md`. UI/UX Pro Max is in the `solo` stack only, since it overlaps Impeccable.
