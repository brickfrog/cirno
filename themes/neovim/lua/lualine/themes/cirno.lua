-- lualine theme for cirno.
-- Mode A backgrounds: normal=ice, insert=mint, visual=mauve,
-- replace=ribbon, command=gold; each with a dark foreground.
-- B section uses surface; C section bg=mantle fg=subtext0.

local ok, cirno = pcall(require, "cirno")
local p
if ok and cirno.palette then
  p = cirno.palette()
else
  -- Fall back to reading the palette directly (e.g. lualine loaded first).
  local variant = (vim.o.background == "light") and "light" or "dark"
  p = require("cirno.palette")[variant]
end

-- Dark foreground used on the bright mode-A accents.
local dark_fg = (vim.o.background == "light") and p.base or "#08111f"

local function mode(accent)
  return {
    a = { fg = dark_fg, bg = accent, gui = "bold" },
    b = { fg = p.subtext1, bg = p.surface1 },
    c = { fg = p.subtext0, bg = p.mantle },
  }
end

local theme = {
  normal  = mode(p.ice),
  insert  = mode(p.mint),
  visual  = mode(p.mauve),
  replace = mode(p.ribbon),
  command = mode(p.gold),
  inactive = {
    a = { fg = p.overlay1, bg = p.mantle, gui = "bold" },
    b = { fg = p.overlay0, bg = p.mantle },
    c = { fg = p.overlay0, bg = p.mantle },
  },
}

return theme
