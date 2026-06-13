-- cirno/palette.lua
-- An ice-fairy palette: midnight navy, starlight blue, ice-cyan, one red ribbon.
-- From Touhou's Cirno.  https://github.com/brickfrog/cirno
--
-- Returns { dark = {...}, light = {...} }, each holding every named color.

local M = {}

M.dark = {
  -- backgrounds
  crust    = "#070c18",
  mantle   = "#0a1120",
  base     = "#0e1525",
  bg       = "#0e1525",
  surface0 = "#16203a",
  surface1 = "#1f2c4a",
  surface2 = "#2b3c60",
  overlay0 = "#3d5277",
  overlay1 = "#536b91",
  overlay2 = "#6a82a8",

  -- foregrounds
  text     = "#d4e4f5",
  subtext1 = "#bdcfe6",
  subtext0 = "#a3b6d2",
  comment  = "#5f7299",

  -- accents
  ice        = "#7ad6f0",
  frost      = "#ace6f7",
  cyan       = "#4cc6ea",
  teal       = "#5fccc6",
  sky        = "#6fb2ee",
  blue       = "#5b90e4",
  sapphire   = "#3aa9dd",
  periwinkle = "#9fb6f2",
  mauve      = "#b78ee2",
  ribbon     = "#ec5a72",
  flare      = "#f4849a",
  peach      = "#eca06a",
  gold       = "#e8cd86",
  cream      = "#f2dda0",
  mint       = "#84ddb2",
  spring     = "#a4ebc8",
}

M.light = {
  -- backgrounds
  crust    = "#c3d2e6",
  mantle   = "#d7e3f1",
  base     = "#eef4fb",
  bg       = "#eef4fb",
  surface0 = "#e2ebf6",
  surface1 = "#d2deee",
  surface2 = "#bccde4",
  overlay0 = "#90a3c0",
  overlay1 = "#7388a8",
  overlay2 = "#5d7295",

  -- foregrounds
  text     = "#16233d",
  subtext1 = "#283955",
  subtext0 = "#3c4d6c",
  comment  = "#6c7f9f",

  -- accents
  ice        = "#0c6f93",
  frost      = "#0d7193",
  cyan       = "#0c7799",
  teal       = "#0c7d74",
  sky        = "#2d6fc4",
  blue       = "#2f5fcf",
  sapphire   = "#11688f",
  periwinkle = "#5163b8",
  mauve      = "#8a4fc0",
  ribbon     = "#c4243f",
  flare      = "#a81049",
  peach      = "#9e4f17",
  gold       = "#835f08",
  cream      = "#6f5000",
  mint       = "#0f7e51",
  spring     = "#0c7e50",
}

return M
