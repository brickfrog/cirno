# Cirno for Claude Code

A custom theme for [Claude Code](https://docs.claude.com/en/docs/claude-code) (the
CLI). The brand accent (normally orange) becomes Cirno's **ice-cyan**; success is
frost-mint, errors are the ribbon red, and the multi-agent/subagent palette maps to
the full Cirno accent set.

## Install

```sh
cp cirno.json ~/.claude/themes/cirno.json
```

Then select it inside Claude Code with **`/theme`** → **Cirno** (or restart Claude
Code if it was already pointed at this file).

## How it works

Claude Code themes are `{ "name", "base", "overrides" }`. `base` is a built-in
theme (`dark`, `light`, `dark-ansi`, `dark-daltonized`, …) and `overrides` maps
named color keys to colors (`#rrggbb`, `rgb(...)`, or `ansi:*`). This theme builds
on `dark` and overrides ~60 keys with Cirno colors; anything not listed falls back
to the `dark` base.

Colors come straight from [`palette/cirno.json`](../../palette/cirno.json). The diff
backgrounds reuse the same dark tints as the [delta](../delta) port.
