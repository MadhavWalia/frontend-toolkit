# Recommended stacks

`install.sh --stack <name>` applies a stack. Stacks only add; run from the toolkit repository.
`full` is what this machine has today.

| Stack | For | Adds |
|---|---|---|
| `essentials` | Every project | Impeccable, frontend-design, Context7, Playwright |
| `design-first` | Designer hands off Figma files | essentials + TypeScript LSP + Figma enabled |
| `solo` | MVP speed | essentials + UI/UX Pro Max |
| `full` | Component library and design system | essentials + TypeScript LSP + Chrome DevTools, with Figma and Vercel installed but disabled |

The polish pipeline needs no install. Its skills are in the library: generate, then apply
`library/ux/baseline-ui`, `library/ux/fixing-accessibility`, `library/motion/fixing-motion-performance`.

## Context budget

Measured with `claude plugin details`, always-on tokens per session:

| Item | Tokens | State |
|---|---|---|
| Impeccable | ~440 | on |
| frontend-design | ~80 | on |
| `frontend` router skill | ~100 | on |
| Figma | ~2,400 | off until needed |
| Vercel | ~4,200 | off until needed |

MCP tool schemas are loaded on demand in this Claude Code version, so the three servers cost little
until used. Use `/mcp` to disable one for a session.
