# Frontend toolkit

Skills and tools that help Claude Code build idiomatic, lean, high-quality frontends, available in
every session on request.

One small skill, `frontend`, is linked into `~/.claude/skills`. It carries the quality bar and routes
each task to the right tool. A library of 42 vendored skills sits behind it and is read only when a
task needs it, so the library costs nothing per session.

## Use

Say "use the frontend toolkit", or run `/frontend <task>`. Also: `/frontend stacks`,
`/frontend catalog`, `/frontend doctor`.

For a new project: `/impeccable init`, then `/impeccable document` once the look settles.

## Layout

| Path | Purpose |
|---|---|
| `skills/frontend/SKILL.md` | Workflow and routing table |
| `skills/frontend/references/` | Quality bar, design systems, theming, pipelines, stacks, catalog |
| `skills/frontend/library/` | Generated. Vendored skills, text only, with licences |
| `sources.json` | Pinned upstream commits and the skills taken from each |
| `install.sh` | Sets up a machine, applies a stack, or checks health |
| `scripts/` | `vendor.py` rebuilds the library; `audit.py` scans it |
| `tests/` | Contrast check for the token recipe |

## Set up a machine

Needs Claude Code and Node.js in your `PATH`. Then run `./install.sh`, restart Claude Code, and run
`./install.sh --check`.

On this machine Node lives in `~/.local/share/node`, linked from `~/.local/bin`, so it needed no sudo
and no shell config change.

## Update

Everything is pinned, so nothing changes until you choose.

1. `python3 scripts/vendor.py --check-updates` lists sources that moved.
2. Read the upstream diff, then set the new commit in `sources.json`.
3. `python3 scripts/vendor.py` rebuilds the library. It stops if the audit fails.
4. For MCP servers, change the version at the top of `install.sh` and re-run it.

Plugins update from the `/plugin` menu. The audit is a pattern scan and does not replace reading the
diff: a skill is instructions Claude will follow.

## Good to know

- Impeccable's detector hook runs on UI file edits in every project. Run `/impeccable hooks off`
  inside a project to silence it there. Its telemetry is off; the setting is in `~/.impeccable/config.json`.
- Figma and Vercel are installed but disabled to save context. See `references/pipelines.md`.
- Vendored skills keep their MIT licences in `skills/frontend/library/licenses/`.
