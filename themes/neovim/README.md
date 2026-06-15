# Cirno for Neovim

An ice-fairy colorscheme: midnight navy, starlight blue, ice-cyan, and one red
ribbon. From Touhou's Cirno. Includes a dark variant (**Cirno**) and a light
variant (**Cirno Day**), Treesitter and LSP semantic-token support, and
highlights for common plugins.

- Repo: https://github.com/brickfrog/cirno

## Requirements

- Neovim 0.8+ (uses `vim.api.nvim_set_hl`)
- `termguicolors` (the theme enables it for you on load)

## Install

### lazy.nvim

```lua
{
  "brickfrog/cirno",
  -- the Neovim plugin lives in a subdirectory of the theme repo
  config = function()
    require("cirno").setup({
      variant = "auto",        -- "auto" | "dark" | "light"
      transparent = false,
      italic_comments = true,
    })
    vim.cmd.colorscheme("cirno")
  end,
}
```

If you only want the colorscheme with defaults, you can skip `setup` entirely:

```lua
{ "brickfrog/cirno", config = function() vim.cmd.colorscheme("cirno") end }
```

> Note: because the plugin lives under `themes/neovim/` in this repo, point your
> plugin manager at that subdirectory if it supports it, or vendor the
> `themes/neovim` folder onto your `runtimepath`.

### packer.nvim

```lua
use({
  "brickfrog/cirno",
  config = function()
    require("cirno").setup({})
    vim.cmd.colorscheme("cirno")
  end,
})
```

### Manual / runtimepath

Copy `themes/neovim/` onto your `runtimepath`:

```vim
set runtimepath+=/path/to/cirno/themes/neovim
colorscheme cirno
```

## Usage

The simplest form respects your current `background`:

```vim
set background=dark   " or light
colorscheme cirno
```

Or drive it from Lua with options:

```lua
require("cirno").setup({
  variant = "dark",        -- force the dark "Cirno" variant
  transparent = false,     -- set true to make backgrounds NONE
  italic_comments = true,
  italic_builtins = true,
  bold_keywords = false,
  overrides = {            -- override any highlight group
    -- Comment = { fg = "#5f7299", italic = false },
  },
  palette_overrides = {    -- override named palette colors per-variant
    -- dark = { ribbon = "#ff5577" },
  },
})
vim.cmd.colorscheme("cirno")
```

### Options

| Option              | Default  | Description                                              |
| ------------------- | -------- | -------------------------------------------------------- |
| `variant`           | `"auto"` | `"auto"` reads `vim.o.background`; or `"dark"`/`"light"`. |
| `transparent`       | `false`  | Make editor backgrounds `NONE`.                          |
| `italic_comments`   | `true`   | Italicize comments.                                      |
| `italic_builtins`   | `true`   | Italicize builtins / `this` / `self`.                    |
| `bold_keywords`     | `false`  | Bold keywords.                                           |
| `overrides`         | `{}`     | Per-highlight-group overrides.                           |
| `palette_overrides` | `{}`     | Per-variant named-color overrides.                       |

## lualine

A matching lualine theme ships with the plugin:

```lua
require("lualine").setup({
  options = { theme = "cirno" },
})
```

Mode-A accents: normal=ice, insert=mint, visual=mauve, replace=ribbon,
command=gold (each on a dark foreground). The center section uses the `mantle`
background with `subtext0` text.

## Palette

The full palette is exposed for your own use:

```lua
local colors = require("cirno").palette()        -- active variant
local dark   = require("cirno").palette("dark")  -- a specific variant
```

## Supported plugins

Treesitter, LSP semantic tokens, diagnostics, GitSigns, nvim-cmp, blink.cmp,
Telescope, nvim-tree, neo-tree, bufferline, indent-blankline, which-key,
nvim-notify, dashboard, alpha, flash, and the mini.* family.
