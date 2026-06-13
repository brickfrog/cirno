-- cirno/init.lua
-- An ice-fairy colorscheme for Neovim: midnight navy, starlight blue,
-- ice-cyan, and one red ribbon. From Touhou's Cirno.
-- https://github.com/brickfrog/cirno

local M = {}

M.config = {
  -- "auto" reads vim.o.background; "dark" / "light" force a variant.
  variant = "auto",
  -- Make the editor background transparent (Normal bg = NONE, etc.).
  transparent = false,
  -- Italicize comments.
  italic_comments = true,
  -- Italicize builtins / this / self.
  italic_builtins = true,
  -- Bold keywords.
  bold_keywords = false,
  -- Per-group overrides: { GroupName = { fg = "#...", bg = "#...", ... } }
  overrides = {},
  -- Palette overrides per variant: { dark = { ... }, light = { ... } }
  palette_overrides = {},
}

-- Resolve the active variant ("dark" | "light").
local function resolve_variant(cfg)
  local v = cfg.variant or "auto"
  if v == "auto" then
    return (vim.o.background == "light") and "light" or "dark"
  end
  if v ~= "dark" and v ~= "light" then
    return "dark"
  end
  return v
end

-- Build the table of highlight groups for a given palette + config.
local function build_highlights(c, cfg)
  local NONE = "NONE"
  local bg_main = cfg.transparent and NONE or c.bg
  local bg_alt  = cfg.transparent and NONE or c.mantle

  local comment_style = { italic = cfg.italic_comments }
  local builtin_style = cfg.italic_builtins and { italic = true } or {}
  local kw_style = cfg.bold_keywords and { bold = true } or {}

  -- Merge helper: shallow merge of style tables.
  local function ext(base, extra)
    local t = {}
    for k, v in pairs(base) do t[k] = v end
    if extra then
      for k, v in pairs(extra) do t[k] = v end
    end
    return t
  end

  local hl = {
    -- ============================== Editor UI ==============================
    Normal       = { fg = c.text, bg = bg_main },
    NormalNC     = { fg = c.text, bg = bg_main },
    NormalFloat  = { fg = c.text, bg = cfg.transparent and NONE or c.mantle },
    FloatBorder  = { fg = c.overlay0, bg = cfg.transparent and NONE or c.mantle },
    FloatTitle   = { fg = c.ice, bg = cfg.transparent and NONE or c.mantle, bold = true },
    ColorColumn  = { bg = c.surface0 },
    Conceal      = { fg = c.overlay1 },
    Cursor       = { fg = c.base, bg = c.ice },
    lCursor      = { fg = c.base, bg = c.ice },
    CursorIM     = { fg = c.base, bg = c.ice },
    CursorColumn = { bg = c.surface0 },
    CursorLine   = { bg = c.surface0 },
    Directory    = { fg = c.ice },
    EndOfBuffer  = { fg = c.mantle },
    ErrorMsg     = { fg = c.ribbon, bold = true },
    VertSplit    = { fg = c.surface1 },
    WinSeparator = { fg = c.surface1 },
    Folded       = { fg = c.subtext0, bg = c.surface0 },
    FoldColumn   = { fg = c.overlay0, bg = bg_main },
    SignColumn   = { fg = c.overlay0, bg = bg_main },
    LineNr       = { fg = c.overlay0 },
    LineNrAbove  = { fg = c.overlay0 },
    LineNrBelow  = { fg = c.overlay0 },
    CursorLineNr = { fg = c.ice, bold = true },
    CursorLineSign = { bg = c.surface0 },
    CursorLineFold = { bg = c.surface0 },
    MatchParen   = { fg = c.ice, bg = c.surface2, bold = true },
    ModeMsg      = { fg = c.subtext1, bold = true },
    MoreMsg      = { fg = c.mint },
    MsgArea      = { fg = c.text },
    MsgSeparator = { fg = c.surface1 },
    NonText      = { fg = c.overlay0 },
    Whitespace   = { fg = c.surface2 },
    SpecialKey   = { fg = c.overlay0 },
    Pmenu        = { fg = c.subtext1, bg = c.surface0 },
    PmenuSel     = { fg = c.text, bg = c.surface2, bold = true },
    PmenuKind    = { fg = c.ice, bg = c.surface0 },
    PmenuKindSel = { fg = c.ice, bg = c.surface2 },
    PmenuExtra   = { fg = c.subtext0, bg = c.surface0 },
    PmenuExtraSel = { fg = c.subtext0, bg = c.surface2 },
    PmenuSbar    = { bg = c.surface1 },
    PmenuThumb   = { bg = c.overlay0 },
    Question     = { fg = c.mint },
    QuickFixLine = { bg = c.surface1, bold = true },
    Search       = { fg = c.base, bg = c.gold },
    IncSearch    = { fg = c.base, bg = c.peach },
    CurSearch    = { fg = c.base, bg = c.peach, bold = true },
    Substitute   = { fg = c.base, bg = c.flare },
    StatusLine   = { fg = c.subtext1, bg = c.mantle },
    StatusLineNC = { fg = c.overlay0, bg = c.mantle },
    TabLine      = { fg = c.subtext0, bg = c.mantle },
    TabLineFill  = { bg = c.crust },
    TabLineSel   = { fg = c.ice, bg = c.surface0, bold = true },
    Title        = { fg = c.ice, bold = true },
    Visual       = { bg = c.surface2 },
    VisualNOS    = { bg = c.surface2 },
    WarningMsg   = { fg = c.gold },
    Winbar       = { fg = c.subtext0, bg = bg_main },
    WinbarNC     = { fg = c.overlay0, bg = bg_main },
    WildMenu     = { fg = c.text, bg = c.surface2 },
    debugPC      = { bg = c.mantle },
    debugBreakpoint = { fg = c.ribbon, bg = c.surface0 },

    -- =========================== Classic syntax ===========================
    Comment        = ext({ fg = c.comment }, comment_style),
    Constant       = { fg = c.peach },
    String         = { fg = c.mint },
    Character      = { fg = c.mint },
    Number         = { fg = c.peach },
    Float          = { fg = c.peach },
    Boolean        = { fg = c.peach },
    Identifier     = { fg = c.text },
    Function       = { fg = c.ice },
    Statement      = ext({ fg = c.mauve }, kw_style),
    Conditional    = ext({ fg = c.mauve }, kw_style),
    Repeat         = ext({ fg = c.mauve }, kw_style),
    Label          = { fg = c.sky },
    Operator       = { fg = c.sky },
    Keyword        = ext({ fg = c.mauve }, kw_style),
    Exception      = ext({ fg = c.mauve }, kw_style),
    PreProc        = { fg = c.teal },
    Include        = { fg = c.teal },
    Define         = { fg = c.teal },
    Macro          = { fg = c.teal },
    PreCondit      = { fg = c.teal },
    Type           = { fg = c.gold },
    StorageClass   = { fg = c.gold },
    Structure      = { fg = c.gold },
    Typedef        = { fg = c.gold },
    Special        = { fg = c.frost },
    SpecialChar    = { fg = c.frost },
    Tag            = { fg = c.ribbon },
    Delimiter      = { fg = c.subtext0 },
    SpecialComment = ext({ fg = c.subtext0 }, comment_style),
    Debug          = { fg = c.flare },
    Underlined     = { fg = c.sapphire, underline = true },
    Bold           = { bold = true },
    Italic         = { italic = true },
    Ignore         = { fg = c.overlay0 },
    Error          = { fg = c.ribbon, bold = true },
    Todo           = { fg = c.base, bg = c.gold, bold = true },

    -- ============================ Diagnostics =============================
    DiagnosticError = { fg = c.ribbon },
    DiagnosticWarn  = { fg = c.gold },
    DiagnosticInfo  = { fg = c.sky },
    DiagnosticHint  = { fg = c.teal },
    DiagnosticOk    = { fg = c.mint },
    DiagnosticVirtualTextError = { fg = c.ribbon, bg = c.surface0 },
    DiagnosticVirtualTextWarn  = { fg = c.gold, bg = c.surface0 },
    DiagnosticVirtualTextInfo  = { fg = c.sky, bg = c.surface0 },
    DiagnosticVirtualTextHint  = { fg = c.teal, bg = c.surface0 },
    DiagnosticVirtualTextOk    = { fg = c.mint, bg = c.surface0 },
    DiagnosticUnderlineError = { undercurl = true, sp = c.ribbon },
    DiagnosticUnderlineWarn  = { undercurl = true, sp = c.gold },
    DiagnosticUnderlineInfo  = { undercurl = true, sp = c.sky },
    DiagnosticUnderlineHint  = { undercurl = true, sp = c.teal },
    DiagnosticUnderlineOk    = { undercurl = true, sp = c.mint },
    DiagnosticFloatingError = { fg = c.ribbon },
    DiagnosticFloatingWarn  = { fg = c.gold },
    DiagnosticFloatingInfo  = { fg = c.sky },
    DiagnosticFloatingHint  = { fg = c.teal },
    DiagnosticFloatingOk    = { fg = c.mint },
    DiagnosticSignError = { fg = c.ribbon },
    DiagnosticSignWarn  = { fg = c.gold },
    DiagnosticSignInfo  = { fg = c.sky },
    DiagnosticSignHint  = { fg = c.teal },
    DiagnosticSignOk    = { fg = c.mint },
    DiagnosticDeprecated = { fg = c.overlay1, strikethrough = true },
    DiagnosticUnnecessary = { fg = c.overlay1, italic = true },

    -- ================================ LSP =================================
    LspReferenceText  = { bg = c.surface2 },
    LspReferenceRead  = { bg = c.surface2 },
    LspReferenceWrite = { bg = c.surface2, underline = true },
    LspCodeLens       = ext({ fg = c.comment }, comment_style),
    LspCodeLensSeparator = { fg = c.overlay0 },
    LspInlayHint      = { fg = c.overlay1, bg = c.surface0, italic = true },
    LspSignatureActiveParameter = { fg = c.peach, bold = true },

    -- ============================= Treesitter =============================
    ["@comment"]              = ext({ fg = c.comment }, comment_style),
    ["@comment.documentation"] = ext({ fg = c.comment }, comment_style),
    ["@comment.error"]        = { fg = c.base, bg = c.ribbon, bold = true },
    ["@comment.warning"]      = { fg = c.base, bg = c.gold, bold = true },
    ["@comment.note"]         = { fg = c.base, bg = c.sky, bold = true },
    ["@comment.todo"]         = { fg = c.base, bg = c.gold, bold = true },

    ["@keyword"]              = ext({ fg = c.mauve }, kw_style),
    ["@keyword.function"]     = ext({ fg = c.mauve }, kw_style),
    ["@keyword.operator"]     = ext({ fg = c.mauve }, kw_style),
    ["@keyword.return"]       = ext({ fg = c.mauve }, kw_style),
    ["@keyword.import"]       = { fg = c.teal },
    ["@keyword.export"]       = { fg = c.teal },
    ["@keyword.conditional"]  = ext({ fg = c.mauve }, kw_style),
    ["@keyword.repeat"]       = ext({ fg = c.mauve }, kw_style),
    ["@keyword.exception"]    = ext({ fg = c.mauve }, kw_style),
    ["@keyword.coroutine"]    = ext({ fg = c.mauve }, kw_style),
    ["@keyword.debug"]        = { fg = c.flare },
    ["@keyword.directive"]    = { fg = c.teal },
    ["@keyword.directive.define"] = { fg = c.teal },
    ["@conditional"]          = ext({ fg = c.mauve }, kw_style),
    ["@repeat"]               = ext({ fg = c.mauve }, kw_style),
    ["@exception"]            = ext({ fg = c.mauve }, kw_style),

    ["@function"]             = { fg = c.ice },
    ["@function.call"]        = { fg = c.ice },
    ["@function.builtin"]     = { fg = c.ice },
    ["@function.macro"]       = { fg = c.teal },
    ["@function.method"]      = { fg = c.ice },
    ["@function.method.call"] = { fg = c.ice },
    ["@method"]               = { fg = c.ice },
    ["@method.call"]          = { fg = c.ice },
    ["@constructor"]          = { fg = c.ice },

    ["@type"]                 = { fg = c.gold },
    ["@type.builtin"]         = { fg = c.gold, italic = true },
    ["@type.definition"]      = { fg = c.gold },
    ["@type.qualifier"]       = ext({ fg = c.mauve }, kw_style),
    ["@storageclass"]         = { fg = c.gold },

    ["@string"]               = { fg = c.mint },
    ["@string.documentation"] = { fg = c.mint },
    ["@string.regex"]         = { fg = c.spring },
    ["@string.regexp"]        = { fg = c.spring },
    ["@string.escape"]        = { fg = c.frost },
    ["@string.special"]       = { fg = c.frost },
    ["@string.special.symbol"] = { fg = c.peach },
    ["@string.special.url"]   = { fg = c.sapphire, underline = true },
    ["@character"]            = { fg = c.mint },
    ["@character.special"]    = { fg = c.frost },

    ["@number"]               = { fg = c.peach },
    ["@number.float"]         = { fg = c.peach },
    ["@float"]                = { fg = c.peach },
    ["@boolean"]              = { fg = c.peach },
    ["@constant"]             = { fg = c.peach },
    ["@constant.builtin"]     = { fg = c.peach },
    ["@constant.macro"]       = { fg = c.teal },

    ["@variable"]             = { fg = c.text },
    ["@variable.builtin"]     = ext({ fg = c.teal }, builtin_style),
    ["@variable.parameter"]   = { fg = c.periwinkle },
    ["@variable.parameter.builtin"] = { fg = c.periwinkle, italic = true },
    ["@variable.member"]      = { fg = c.sky },
    ["@parameter"]            = { fg = c.periwinkle },
    ["@field"]                = { fg = c.sky },
    ["@property"]             = { fg = c.sky },

    ["@operator"]             = { fg = c.sky },

    ["@punctuation"]          = { fg = c.subtext0 },
    ["@punctuation.delimiter"] = { fg = c.subtext0 },
    ["@punctuation.bracket"]  = { fg = c.subtext0 },
    ["@punctuation.special"]  = { fg = c.frost },

    ["@tag"]                  = { fg = c.ribbon },
    ["@tag.builtin"]          = { fg = c.ribbon },
    ["@tag.attribute"]        = { fg = c.gold },
    ["@tag.delimiter"]        = { fg = c.subtext0 },
    ["@attribute"]            = { fg = c.gold },
    ["@attribute.builtin"]    = { fg = c.gold },

    ["@namespace"]            = { fg = c.teal },
    ["@module"]               = { fg = c.teal },
    ["@module.builtin"]       = ext({ fg = c.teal }, builtin_style),

    ["@label"]                = { fg = c.sky },
    ["@define"]               = { fg = c.teal },
    ["@preproc"]              = { fg = c.teal },
    ["@include"]              = { fg = c.teal },

    ["@symbol"]               = { fg = c.peach },
    ["@text"]                 = { fg = c.text },
    ["@text.literal"]         = { fg = c.mint },
    ["@none"]                 = { fg = c.text },

    -- Treesitter markup (markdown, help, etc.)
    ["@markup"]               = { fg = c.text },
    ["@markup.heading"]       = { fg = c.ice, bold = true },
    ["@markup.heading.1"]     = { fg = c.ice, bold = true },
    ["@markup.heading.2"]     = { fg = c.cyan, bold = true },
    ["@markup.heading.3"]     = { fg = c.sky, bold = true },
    ["@markup.heading.4"]     = { fg = c.teal, bold = true },
    ["@markup.heading.5"]     = { fg = c.mauve, bold = true },
    ["@markup.heading.6"]     = { fg = c.periwinkle, bold = true },
    ["@markup.strong"]        = { fg = c.peach, bold = true },
    ["@markup.bold"]          = { fg = c.peach, bold = true },
    ["@markup.italic"]        = { fg = c.mauve, italic = true },
    ["@markup.emphasis"]      = { fg = c.mauve, italic = true },
    ["@markup.strikethrough"] = { fg = c.overlay1, strikethrough = true },
    ["@markup.underline"]     = { underline = true },
    ["@markup.heading.marker"] = { fg = c.overlay0 },
    ["@markup.quote"]         = { fg = c.subtext0, italic = true },
    ["@markup.math"]          = { fg = c.peach },
    ["@markup.link"]          = { fg = c.sapphire, underline = true },
    ["@markup.link.label"]    = { fg = c.ice },
    ["@markup.link.url"]      = { fg = c.sapphire, underline = true },
    ["@markup.raw"]           = { fg = c.mint },
    ["@markup.raw.block"]     = { fg = c.subtext1 },
    ["@markup.list"]          = { fg = c.ice },
    ["@markup.list.checked"]  = { fg = c.mint },
    ["@markup.list.unchecked"] = { fg = c.overlay1 },
    ["@markup.environment"]   = { fg = c.teal },
    ["@markup.environment.name"] = { fg = c.gold },

    -- Treesitter diff
    ["@diff.plus"]            = { fg = c.mint },
    ["@diff.minus"]           = { fg = c.ribbon },
    ["@diff.delta"]           = { fg = c.gold },

    -- Legacy markup capture aliases (older parsers)
    ["@text.title"]           = { fg = c.ice, bold = true },
    ["@text.strong"]          = { fg = c.peach, bold = true },
    ["@text.emphasis"]        = { fg = c.mauve, italic = true },
    ["@text.underline"]       = { underline = true },
    ["@text.uri"]             = { fg = c.sapphire, underline = true },
    ["@text.reference"]       = { fg = c.ice },
    ["@text.todo"]            = { fg = c.base, bg = c.gold, bold = true },
    ["@text.note"]            = { fg = c.base, bg = c.sky, bold = true },
    ["@text.warning"]         = { fg = c.base, bg = c.gold, bold = true },
    ["@text.danger"]          = { fg = c.base, bg = c.ribbon, bold = true },
    ["@text.diff.add"]        = { fg = c.mint },
    ["@text.diff.delete"]     = { fg = c.ribbon },

    -- ===================== LSP semantic tokens (@lsp) =====================
    ["@lsp.type.namespace"]     = { fg = c.teal },
    ["@lsp.type.type"]          = { fg = c.gold },
    ["@lsp.type.class"]         = { fg = c.gold },
    ["@lsp.type.enum"]          = { fg = c.gold },
    ["@lsp.type.interface"]     = { fg = c.gold },
    ["@lsp.type.struct"]        = { fg = c.gold },
    ["@lsp.type.typeParameter"] = { fg = c.gold, italic = true },
    ["@lsp.type.parameter"]     = { fg = c.periwinkle },
    ["@lsp.type.variable"]      = { fg = c.text },
    ["@lsp.type.property"]      = { fg = c.sky },
    ["@lsp.type.enumMember"]    = { fg = c.peach },
    ["@lsp.type.function"]      = { fg = c.ice },
    ["@lsp.type.method"]        = { fg = c.ice },
    ["@lsp.type.macro"]         = { fg = c.teal },
    ["@lsp.type.decorator"]     = { fg = c.gold },
    ["@lsp.type.keyword"]       = ext({ fg = c.mauve }, kw_style),
    ["@lsp.type.comment"]       = ext({ fg = c.comment }, comment_style),
    ["@lsp.type.string"]        = { fg = c.mint },
    ["@lsp.type.number"]        = { fg = c.peach },
    ["@lsp.type.operator"]      = { fg = c.sky },
    ["@lsp.type.modifier"]      = ext({ fg = c.mauve }, kw_style),
    ["@lsp.type.event"]         = { fg = c.gold },
    ["@lsp.type.regexp"]        = { fg = c.spring },
    ["@lsp.type.builtinType"]   = { fg = c.gold, italic = true },
    ["@lsp.type.selfKeyword"]   = ext({ fg = c.teal }, builtin_style),
    ["@lsp.typemod.variable.readonly"]      = { fg = c.peach },
    ["@lsp.typemod.variable.defaultLibrary"] = ext({ fg = c.teal }, builtin_style),
    ["@lsp.typemod.function.defaultLibrary"] = { fg = c.ice },
    ["@lsp.typemod.method.defaultLibrary"]   = { fg = c.ice },
    ["@lsp.typemod.keyword.documentation"]   = { fg = c.teal },
    ["@lsp.mod.deprecated"]     = { strikethrough = true },

    -- =============================== GitSigns =============================
    GitSignsAdd          = { fg = c.mint },
    GitSignsChange       = { fg = c.gold },
    GitSignsDelete       = { fg = c.ribbon },
    GitSignsAddNr        = { fg = c.mint },
    GitSignsChangeNr     = { fg = c.gold },
    GitSignsDeleteNr     = { fg = c.ribbon },
    GitSignsAddLn        = { bg = c.surface0 },
    GitSignsChangeLn     = { bg = c.surface0 },
    GitSignsDeleteLn     = { bg = c.surface0 },
    GitSignsCurrentLineBlame = ext({ fg = c.overlay0 }, comment_style),
    GitSignsAddInline    = { bg = c.surface1 },
    GitSignsChangeInline = { bg = c.surface1 },
    GitSignsDeleteInline = { bg = c.surface1 },
    -- Generic diff (gitcommit, diff filetype)
    Added                = { fg = c.mint },
    Changed              = { fg = c.gold },
    Removed              = { fg = c.ribbon },
    DiffAdd              = { fg = c.mint, bg = c.surface0 },
    DiffChange           = { fg = c.gold, bg = c.surface0 },
    DiffDelete           = { fg = c.ribbon, bg = c.surface0 },
    DiffText             = { fg = c.gold, bg = c.surface1, bold = true },
    diffAdded            = { fg = c.mint },
    diffChanged          = { fg = c.gold },
    diffRemoved          = { fg = c.ribbon },
    diffLine             = { fg = c.sky },
    diffFile             = { fg = c.ice },
    diffNewFile          = { fg = c.mint },
    diffOldFile          = { fg = c.ribbon },

    -- =============================== nvim-cmp =============================
    CmpItemAbbr            = { fg = c.subtext1 },
    CmpItemAbbrDeprecated  = { fg = c.overlay1, strikethrough = true },
    CmpItemAbbrMatch       = { fg = c.ice, bold = true },
    CmpItemAbbrMatchFuzzy  = { fg = c.ice, bold = true },
    CmpItemMenu            = { fg = c.comment, italic = true },
    CmpItemKind            = { fg = c.overlay2 },
    CmpItemKindText        = { fg = c.text },
    CmpItemKindMethod      = { fg = c.ice },
    CmpItemKindFunction    = { fg = c.ice },
    CmpItemKindConstructor = { fg = c.ice },
    CmpItemKindField       = { fg = c.sky },
    CmpItemKindProperty    = { fg = c.sky },
    CmpItemKindVariable    = { fg = c.text },
    CmpItemKindClass       = { fg = c.gold },
    CmpItemKindStruct      = { fg = c.gold },
    CmpItemKindInterface   = { fg = c.gold },
    CmpItemKindEnum        = { fg = c.gold },
    CmpItemKindEnumMember  = { fg = c.peach },
    CmpItemKindModule      = { fg = c.teal },
    CmpItemKindKeyword     = { fg = c.mauve },
    CmpItemKindSnippet     = { fg = c.mint },
    CmpItemKindColor       = { fg = c.frost },
    CmpItemKindFile        = { fg = c.subtext1 },
    CmpItemKindFolder      = { fg = c.ice },
    CmpItemKindReference   = { fg = c.peach },
    CmpItemKindConstant    = { fg = c.peach },
    CmpItemKindValue       = { fg = c.peach },
    CmpItemKindEvent       = { fg = c.gold },
    CmpItemKindOperator    = { fg = c.sky },
    CmpItemKindTypeParameter = { fg = c.gold },
    CmpItemKindUnit        = { fg = c.peach },
    CmpItemKindCopilot     = { fg = c.mint },

    -- blink.cmp (shares semantics with cmp)
    BlinkCmpLabel          = { fg = c.subtext1 },
    BlinkCmpLabelMatch     = { fg = c.ice, bold = true },
    BlinkCmpLabelDeprecated = { fg = c.overlay1, strikethrough = true },
    BlinkCmpKind           = { fg = c.overlay2 },
    BlinkCmpMenuBorder     = { fg = c.overlay0 },
    BlinkCmpDocBorder      = { fg = c.overlay0 },

    -- =============================== Telescope ============================
    TelescopeBorder         = { fg = c.overlay0, bg = bg_alt },
    TelescopeNormal         = { fg = c.text, bg = bg_alt },
    TelescopePromptNormal   = { fg = c.text, bg = c.surface0 },
    TelescopePromptBorder   = { fg = c.surface0, bg = c.surface0 },
    TelescopePromptTitle    = { fg = c.base, bg = c.ice, bold = true },
    TelescopePromptPrefix   = { fg = c.ice, bg = c.surface0 },
    TelescopePromptCounter  = { fg = c.overlay1, bg = c.surface0 },
    TelescopeResultsNormal  = { fg = c.subtext1, bg = bg_alt },
    TelescopeResultsBorder  = { fg = c.overlay0, bg = bg_alt },
    TelescopeResultsTitle   = { fg = bg_alt, bg = c.ice, bold = true },
    TelescopePreviewNormal  = { fg = c.text, bg = bg_alt },
    TelescopePreviewBorder  = { fg = c.overlay0, bg = bg_alt },
    TelescopePreviewTitle   = { fg = c.base, bg = c.ice, bold = true },
    TelescopeSelection      = { fg = c.text, bg = c.surface1, bold = true },
    TelescopeSelectionCaret = { fg = c.ice, bg = c.surface1 },
    TelescopeMultiSelection = { fg = c.peach, bg = c.surface1 },
    TelescopeMatching       = { fg = c.ice, bold = true },
    TelescopeTitle          = { fg = c.ice, bold = true },

    -- =============================== NvimTree =============================
    NvimTreeNormal          = { fg = c.subtext1, bg = bg_alt },
    NvimTreeNormalNC        = { fg = c.subtext1, bg = bg_alt },
    NvimTreeRootFolder      = { fg = c.ice, bold = true },
    NvimTreeFolderName      = { fg = c.sky },
    NvimTreeFolderIcon      = { fg = c.ice },
    NvimTreeOpenedFolderName = { fg = c.sky, bold = true },
    NvimTreeEmptyFolderName = { fg = c.overlay1 },
    NvimTreeSymlink         = { fg = c.frost },
    NvimTreeSpecialFile     = { fg = c.gold },
    NvimTreeExecFile        = { fg = c.mint },
    NvimTreeImageFile       = { fg = c.mauve },
    NvimTreeIndentMarker    = { fg = c.surface2 },
    NvimTreeGitDirty        = { fg = c.gold },
    NvimTreeGitNew          = { fg = c.mint },
    NvimTreeGitDeleted      = { fg = c.ribbon },
    NvimTreeGitStaged       = { fg = c.teal },
    NvimTreeGitMerge        = { fg = c.peach },
    NvimTreeGitRenamed      = { fg = c.mauve },
    NvimTreeWindowPicker    = { fg = c.base, bg = c.ice, bold = true },
    NvimTreeCursorLine      = { bg = c.surface0 },
    NvimTreeWinSeparator    = { fg = c.surface1, bg = bg_alt },

    -- =============================== neo-tree =============================
    NeoTreeNormal           = { fg = c.subtext1, bg = bg_alt },
    NeoTreeNormalNC         = { fg = c.subtext1, bg = bg_alt },
    NeoTreeDirectoryName    = { fg = c.sky },
    NeoTreeDirectoryIcon    = { fg = c.ice },
    NeoTreeRootName         = { fg = c.ice, bold = true },
    NeoTreeFileName         = { fg = c.subtext1 },
    NeoTreeFileNameOpened   = { fg = c.text, bold = true },
    NeoTreeSymbolicLinkTarget = { fg = c.frost },
    NeoTreeIndentMarker     = { fg = c.surface2 },
    NeoTreeExpander         = { fg = c.overlay0 },
    NeoTreeGitAdded         = { fg = c.mint },
    NeoTreeGitConflict      = { fg = c.peach },
    NeoTreeGitDeleted       = { fg = c.ribbon },
    NeoTreeGitIgnored       = { fg = c.overlay0 },
    NeoTreeGitModified      = { fg = c.gold },
    NeoTreeGitUntracked     = { fg = c.spring },
    NeoTreeGitStaged        = { fg = c.teal },
    NeoTreeFloatBorder      = { fg = c.overlay0, bg = bg_alt },
    NeoTreeTitleBar         = { fg = c.base, bg = c.ice, bold = true },
    NeoTreeWinSeparator     = { fg = c.surface1, bg = bg_alt },
    NeoTreeDimText          = { fg = c.overlay0 },
    NeoTreeCursorLine       = { bg = c.surface0 },

    -- ============================== bufferline ============================
    BufferLineFill                = { bg = c.crust },
    BufferLineBackground          = { fg = c.overlay1, bg = c.mantle },
    BufferLineBufferVisible       = { fg = c.subtext0, bg = c.mantle },
    BufferLineBufferSelected      = { fg = c.text, bg = bg_main, bold = true },
    BufferLineTab                 = { fg = c.overlay1, bg = c.mantle },
    BufferLineTabSelected         = { fg = c.ice, bg = bg_main },
    BufferLineTabSeparator        = { fg = c.crust, bg = c.mantle },
    BufferLineTabSeparatorSelected = { fg = c.crust, bg = bg_main },
    BufferLineSeparator           = { fg = c.crust, bg = c.mantle },
    BufferLineSeparatorVisible    = { fg = c.crust, bg = c.mantle },
    BufferLineSeparatorSelected   = { fg = c.crust, bg = bg_main },
    BufferLineIndicatorSelected   = { fg = c.ice, bg = bg_main },
    BufferLineModified            = { fg = c.gold, bg = c.mantle },
    BufferLineModifiedVisible     = { fg = c.gold, bg = c.mantle },
    BufferLineModifiedSelected    = { fg = c.mint, bg = bg_main },
    BufferLineError               = { fg = c.ribbon, bg = c.mantle },
    BufferLineErrorSelected       = { fg = c.ribbon, bg = bg_main },
    BufferLineWarning             = { fg = c.gold, bg = c.mantle },
    BufferLineWarningSelected     = { fg = c.gold, bg = bg_main },
    BufferLineHint                = { fg = c.teal, bg = c.mantle },
    BufferLineHintSelected        = { fg = c.teal, bg = bg_main },
    BufferLineInfo                = { fg = c.sky, bg = c.mantle },
    BufferLineInfoSelected        = { fg = c.sky, bg = bg_main },
    BufferLineDuplicate           = { fg = c.overlay1, bg = c.mantle },
    BufferLineDuplicateSelected   = { fg = c.subtext0, bg = bg_main },
    BufferLineCloseButton         = { fg = c.overlay1, bg = c.mantle },
    BufferLineCloseButtonSelected = { fg = c.ribbon, bg = bg_main },
    BufferLinePick                = { fg = c.ribbon, bg = c.mantle, bold = true },
    BufferLinePickSelected        = { fg = c.ribbon, bg = bg_main, bold = true },

    -- ========================= indent-blankline ==========================
    IblIndent     = { fg = c.surface1 },
    IblWhitespace = { fg = c.surface1 },
    IblScope      = { fg = c.overlay0 },
    -- legacy ibl v2
    IndentBlanklineChar           = { fg = c.surface1 },
    IndentBlanklineContextChar    = { fg = c.overlay0 },
    IndentBlanklineSpaceChar      = { fg = c.surface1 },
    IndentBlanklineSpaceCharBlankline = { fg = c.surface1 },

    -- =============================== which-key ============================
    WhichKey          = { fg = c.ice },
    WhichKeyGroup     = { fg = c.sky },
    WhichKeyDesc      = { fg = c.subtext1 },
    WhichKeySeparator = { fg = c.comment },
    WhichKeyValue     = { fg = c.overlay2 },
    WhichKeyFloat     = { bg = bg_alt },
    WhichKeyBorder    = { fg = c.overlay0, bg = bg_alt },
    WhichKeyTitle     = { fg = c.ice, bold = true },
    WhichKeyIcon      = { fg = c.frost },
    WhichKeyIconAzure = { fg = c.sky },

    -- ============================ nvim-notify =============================
    NotifyERRORBorder = { fg = c.ribbon },
    NotifyWARNBorder  = { fg = c.gold },
    NotifyINFOBorder  = { fg = c.sky },
    NotifyDEBUGBorder = { fg = c.overlay1 },
    NotifyTRACEBorder = { fg = c.mauve },
    NotifyERRORIcon   = { fg = c.ribbon },
    NotifyWARNIcon    = { fg = c.gold },
    NotifyINFOIcon    = { fg = c.sky },
    NotifyDEBUGIcon   = { fg = c.overlay1 },
    NotifyTRACEIcon   = { fg = c.mauve },
    NotifyERRORTitle  = { fg = c.ribbon, bold = true },
    NotifyWARNTitle   = { fg = c.gold, bold = true },
    NotifyINFOTitle   = { fg = c.sky, bold = true },
    NotifyDEBUGTitle  = { fg = c.overlay1, bold = true },
    NotifyTRACETitle  = { fg = c.mauve, bold = true },
    NotifyERRORBody   = { fg = c.text },
    NotifyWARNBody    = { fg = c.text },
    NotifyINFOBody    = { fg = c.text },
    NotifyDEBUGBody   = { fg = c.text },
    NotifyTRACEBody   = { fg = c.text },
    NotifyBackground  = { bg = c.mantle },

    -- ======================= dashboard / alpha ===========================
    DashboardHeader   = { fg = c.ice },
    DashboardFooter   = { fg = c.comment, italic = true },
    DashboardDesc     = { fg = c.sky },
    DashboardKey      = { fg = c.peach },
    DashboardIcon     = { fg = c.frost },
    DashboardShortCut = { fg = c.mauve },
    DashboardCenter   = { fg = c.subtext1 },
    DashboardProjectTitle = { fg = c.ice, bold = true },
    DashboardMruTitle = { fg = c.ice, bold = true },
    AlphaHeader       = { fg = c.ice },
    AlphaButtons      = { fg = c.sky },
    AlphaShortcut     = { fg = c.peach },
    AlphaFooter       = { fg = c.comment, italic = true },

    -- ================================ flash ==============================
    FlashBackdrop = { fg = c.overlay0 },
    FlashMatch    = { fg = c.base, bg = c.sky, bold = true },
    FlashCurrent  = { fg = c.base, bg = c.peach, bold = true },
    FlashLabel    = { fg = c.base, bg = c.ribbon, bold = true },
    FlashPrompt   = { fg = c.text, bg = c.surface0 },
    FlashPromptIcon = { fg = c.ice },

    -- ============================== mini.* ===============================
    MiniStatuslineModeNormal  = { fg = c.base, bg = c.ice, bold = true },
    MiniStatuslineModeInsert  = { fg = c.base, bg = c.mint, bold = true },
    MiniStatuslineModeVisual  = { fg = c.base, bg = c.mauve, bold = true },
    MiniStatuslineModeReplace = { fg = c.base, bg = c.ribbon, bold = true },
    MiniStatuslineModeCommand = { fg = c.base, bg = c.gold, bold = true },
    MiniStatuslineModeOther   = { fg = c.base, bg = c.teal, bold = true },
    MiniStatuslineDevinfo     = { fg = c.subtext1, bg = c.surface1 },
    MiniStatuslineFilename    = { fg = c.subtext0, bg = c.mantle },
    MiniStatuslineFileinfo    = { fg = c.subtext1, bg = c.surface1 },
    MiniStatuslineInactive    = { fg = c.overlay0, bg = c.mantle },
    MiniTablineCurrent        = { fg = c.text, bg = c.surface1, bold = true },
    MiniTablineVisible        = { fg = c.subtext0, bg = c.mantle },
    MiniTablineHidden         = { fg = c.overlay1, bg = c.mantle },
    MiniTablineModifiedCurrent = { fg = c.gold, bg = c.surface1, bold = true },
    MiniTablineModifiedVisible = { fg = c.gold, bg = c.mantle },
    MiniTablineModifiedHidden  = { fg = c.gold, bg = c.mantle },
    MiniTablineFill           = { bg = c.crust },
    MiniTablineTabpagesection = { fg = c.base, bg = c.ice, bold = true },
    MiniCursorword            = { bg = c.surface2 },
    MiniCursorwordCurrent     = { bg = c.surface2 },
    MiniIndentscopeSymbol     = { fg = c.overlay0 },
    MiniIndentscopePrefix     = { fg = c.surface1 },
    MiniTrailspace            = { bg = c.ribbon },
    MiniFilesNormal           = { fg = c.subtext1, bg = bg_alt },
    MiniFilesBorder           = { fg = c.overlay0, bg = bg_alt },
    MiniFilesTitle            = { fg = c.ice, bg = bg_alt, bold = true },
    MiniFilesTitleFocused     = { fg = c.ice, bg = bg_alt, bold = true },
    MiniFilesFile             = { fg = c.subtext1 },
    MiniFilesDirectory        = { fg = c.sky },
    MiniDiffSignAdd           = { fg = c.mint },
    MiniDiffSignChange        = { fg = c.gold },
    MiniDiffSignDelete        = { fg = c.ribbon },
    MiniPickNormal            = { fg = c.text, bg = bg_alt },
    MiniPickBorder            = { fg = c.overlay0, bg = bg_alt },
    MiniPickPrompt            = { fg = c.ice, bg = bg_alt },
    MiniPickMatchCurrent      = { fg = c.text, bg = c.surface1 },
    MiniPickMatchMarked       = { fg = c.peach, bg = c.surface1 },

    -- =============================== Misc ================================
    healthSuccess = { fg = c.mint },
    healthWarning = { fg = c.gold },
    healthError   = { fg = c.ribbon },

    -- spelling
    SpellBad   = { undercurl = true, sp = c.ribbon },
    SpellCap   = { undercurl = true, sp = c.gold },
    SpellLocal = { undercurl = true, sp = c.sky },
    SpellRare  = { undercurl = true, sp = c.mauve },

    -- floats / notify shared
    WinBar    = { fg = c.subtext0, bg = bg_main },
    WinBarNC  = { fg = c.overlay0, bg = bg_main },

    -- ============================ Markdown (vim) =========================
    markdownHeadingDelimiter = { fg = c.overlay0 },
    markdownH1               = { fg = c.ice, bold = true },
    markdownH2               = { fg = c.cyan, bold = true },
    markdownH3               = { fg = c.sky, bold = true },
    markdownLinkText         = { fg = c.ice },
    markdownUrl              = { fg = c.sapphire, underline = true },
    markdownCode             = { fg = c.mint },
    markdownCodeBlock        = { fg = c.subtext1 },
    markdownBold             = { fg = c.peach, bold = true },
    markdownItalic           = { fg = c.mauve, italic = true },
    markdownListMarker       = { fg = c.ice },

    -- ============================ HTML / web =============================
    htmlTag        = { fg = c.subtext0 },
    htmlEndTag     = { fg = c.subtext0 },
    htmlTagName    = { fg = c.ribbon },
    htmlArg        = { fg = c.gold },
    htmlH1         = { fg = c.ice, bold = true },
    htmlLink       = { fg = c.sapphire, underline = true },
    cssClassName   = { fg = c.gold },
    cssTagName     = { fg = c.ribbon },
    cssPropertyName = { fg = c.sky },
  }

  -- Apply user overrides last.
  if cfg.overrides and type(cfg.overrides) == "table" then
    for group, spec in pairs(cfg.overrides) do
      hl[group] = vim.tbl_extend("force", hl[group] or {}, spec)
    end
  end

  return hl
end

-- Set the 16 terminal colors from the palette.
local function set_terminal_colors(c)
  vim.g.terminal_color_0  = c.surface1   -- black
  vim.g.terminal_color_1  = c.ribbon     -- red
  vim.g.terminal_color_2  = c.mint       -- green
  vim.g.terminal_color_3  = c.gold       -- yellow
  vim.g.terminal_color_4  = c.sky        -- blue
  vim.g.terminal_color_5  = c.mauve      -- magenta
  vim.g.terminal_color_6  = c.ice        -- cyan
  vim.g.terminal_color_7  = c.subtext1   -- white
  vim.g.terminal_color_8  = c.overlay0   -- bright black
  vim.g.terminal_color_9  = c.flare      -- bright red
  vim.g.terminal_color_10 = c.spring     -- bright green
  vim.g.terminal_color_11 = c.cream      -- bright yellow
  vim.g.terminal_color_12 = c.blue       -- bright blue
  vim.g.terminal_color_13 = c.periwinkle -- bright magenta
  vim.g.terminal_color_14 = c.frost      -- bright cyan
  vim.g.terminal_color_15 = c.text       -- bright white
end

-- M.setup(opts): store config without applying.
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
  return M.config
end

-- M.load(opts): apply the colorscheme.
function M.load(opts)
  if opts then
    M.config = vim.tbl_deep_extend("force", M.config, opts)
  end
  local cfg = M.config

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "cirno"

  local variant = resolve_variant(cfg)
  -- Keep &background in sync with the active variant.
  if cfg.variant == "dark" then
    vim.o.background = "dark"
  elseif cfg.variant == "light" then
    vim.o.background = "light"
  end

  local palette = require("cirno.palette")
  local c = vim.deepcopy(palette[variant])

  -- Palette overrides per variant.
  local povr = cfg.palette_overrides and cfg.palette_overrides[variant]
  if povr and type(povr) == "table" then
    for k, v in pairs(povr) do c[k] = v end
  end

  local groups = build_highlights(c, cfg)
  local set_hl = vim.api.nvim_set_hl
  for group, spec in pairs(groups) do
    set_hl(0, group, spec)
  end

  set_terminal_colors(c)
end

-- Expose the palette for downstream consumers (e.g. lualine theme).
function M.palette(variant)
  local palette = require("cirno.palette")
  if variant == "dark" or variant == "light" then
    return palette[variant]
  end
  return palette[resolve_variant(M.config)]
end

return M
