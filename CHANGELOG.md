# Changelog

All notable changes to Cirno are documented here. Format loosely follows
[Keep a Changelog](https://keepachangelog.com/); versions are date-stamped.

## [1.0.0] — 2026-06-13

The first flight. ❄️

### Added
- **Palette** — a single source of truth (`palette/cirno.json`) with two
  variants, **Cirno** (dark) and **Cirno Day** (light), both validated to clear
  WCAG AA contrast. Sampled directly from the wallpaper.
- **Terminals** — Ghostty, Kitty, Alacritty, WezTerm, foot.
- **Multiplexers** — tmux, Zellij.
- **Editors** — VS Code (dark + light extension), Vim, Neovim (Lua plugin with
  Treesitter + LSP + plugin integrations and a lualine theme), Helix.
- **Desktop** — DankMaterialShell (dms), Waybar, Rofi, Wofi, Hyprland, mako,
  dunst, swaylock, GTK / libadwaita.
- **Shell & CLI** — Starship, fish, zsh (syntax highlighting), fzf, bat, delta,
  lazygit, yazi, fastfetch, btop.
- Tooling: `scripts/build_palette.py` (regenerate + contrast-check) and
  `scripts/swatches.py` (render the palette previews).
