" cirno.vim: an ice-fairy colorscheme
" Midnight navy, starlight blue, ice-cyan, and one red ribbon. From Touhou's Cirno.
" https://github.com/brickfrog/cirno
"
" Supports true-color (set termguicolors) and 256-color terminals, dark + light.
"   set background=dark   " or light
"   colorscheme cirno

" Respects the current &background (set it before :colorscheme cirno).
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'cirno'

" --- palette : name -> [gui, cterm] -------------------------------------------
if &background ==# 'light'
  let s:p = {
    \ 'crust':['#c3d2e6',152], 'mantle':['#d7e3f1',254], 'base':['#eef4fb',255],
    \ 'surface0':['#e2ebf6',255], 'surface1':['#d2deee',189], 'surface2':['#bccde4',152],
    \ 'overlay0':['#90a3c0',109], 'overlay1':['#7388a8',67], 'overlay2':['#5d7295',60],
    \ 'text':['#16233d',235], 'subtext1':['#283955',237], 'subtext0':['#3c4d6c',239],
    \ 'comment':['#6c7f9f',67],
    \ 'ice':['#0c6f93',24], 'frost':['#0d7193',24], 'cyan':['#0c7799',30], 'teal':['#0c7d74',30],
    \ 'sky':['#2d6fc4',26], 'blue':['#2f5fcf',26], 'sapphire':['#11688f',24],
    \ 'periwinkle':['#5163b8',61], 'mauve':['#8a4fc0',97],
    \ 'ribbon':['#c4243f',161], 'flare':['#a81049',125], 'peach':['#9e4f17',130],
    \ 'gold':['#835f08',94], 'cream':['#6f5000',58], 'mint':['#0f7e51',29], 'spring':['#0c7e50',29],
    \ }
else
  let s:p = {
    \ 'crust':['#070c18',233], 'mantle':['#0a1120',233], 'base':['#0e1525',234],
    \ 'surface0':['#16203a',235], 'surface1':['#1f2c4a',236], 'surface2':['#2b3c60',238],
    \ 'overlay0':['#3d5277',60], 'overlay1':['#536b91',60], 'overlay2':['#6a82a8',67],
    \ 'text':['#d4e4f5',189], 'subtext1':['#bdcfe6',152], 'subtext0':['#a3b6d2',146],
    \ 'comment':['#5f7299',60],
    \ 'ice':['#7ad6f0',117], 'frost':['#ace6f7',153], 'cyan':['#4cc6ea',80], 'teal':['#5fccc6',80],
    \ 'sky':['#6fb2ee',75], 'blue':['#5b90e4',68], 'sapphire':['#3aa9dd',74],
    \ 'periwinkle':['#9fb6f2',147], 'mauve':['#b78ee2',140],
    \ 'ribbon':['#ec5a72',203], 'flare':['#f4849a',210], 'peach':['#eca06a',215],
    \ 'gold':['#e8cd86',186], 'cream':['#f2dda0',223], 'mint':['#84ddb2',115], 'spring':['#a4ebc8',152],
    \ }
endif

" --- highlight helper ---------------------------------------------------------
" s:hi('Group', fg, bg, attr): fg/bg are palette keys or 'NONE'; attr e.g. 'bold,italic'
function! s:hi(group, fg, bg, ...) abort
  let l:cmd = 'hi ' . a:group
  if a:fg !=# 'NONE'
    let l:cmd .= ' guifg=' . s:p[a:fg][0] . ' ctermfg=' . s:p[a:fg][1]
  else
    let l:cmd .= ' guifg=NONE ctermfg=NONE'
  endif
  if a:bg !=# 'NONE'
    let l:cmd .= ' guibg=' . s:p[a:bg][0] . ' ctermbg=' . s:p[a:bg][1]
  else
    let l:cmd .= ' guibg=NONE ctermbg=NONE'
  endif
  let l:a = (a:0 >= 1 && !empty(a:1)) ? a:1 : 'NONE'
  let l:cmd .= ' gui=' . l:a . ' cterm=' . l:a
  execute l:cmd
endfunction
command! -nargs=+ Hi call s:hi(<f-args>)

" --- editor UI ----------------------------------------------------------------
Hi Normal          text base
Hi NormalFloat     text mantle
Hi FloatBorder     overlay0 mantle
Hi FloatTitle      ice mantle bold
Hi NormalNC        text base
Hi ColorColumn     NONE surface0
Hi Cursor          base ice
Hi lCursor         base ice
Hi CursorLine      NONE surface0
Hi CursorColumn    NONE surface0
Hi CursorLineNr    ice NONE bold
Hi LineNr          overlay0 NONE
Hi LineNrAbove     overlay0 NONE
Hi LineNrBelow     overlay0 NONE
Hi SignColumn      overlay0 NONE
Hi VertSplit       crust NONE
Hi WinSeparator    surface0 NONE
Hi Folded          subtext0 surface0 italic
Hi FoldColumn      overlay0 NONE
Hi MatchParen      ice surface1 bold
Hi Visual          NONE surface2
Hi VisualNOS       NONE surface2
Hi Search          base gold
Hi IncSearch       base peach
Hi CurSearch       base peach bold
Hi Substitute      base flare
Hi Whitespace      surface1 NONE
Hi NonText         surface1 NONE
Hi SpecialKey      overlay0 NONE
Hi EndOfBuffer     base NONE
Hi Conceal         overlay1 NONE
Hi Directory       sky NONE
Hi Title           ice NONE bold

Hi Pmenu           subtext1 mantle
Hi PmenuSel        text surface1 bold
Hi PmenuKind       ice mantle
Hi PmenuKindSel    ice surface1
Hi PmenuExtra      overlay2 mantle
Hi PmenuExtraSel   overlay2 surface1
Hi PmenuSbar       NONE surface0
Hi PmenuThumb      NONE overlay0
Hi WildMenu        base ice bold

Hi StatusLine      subtext1 mantle
Hi StatusLineNC    overlay1 mantle
Hi TabLine         overlay1 mantle
Hi TabLineSel      ice base bold
Hi TabLineFill     overlay0 crust
Hi ToolbarLine     NONE surface0
Hi ToolbarButton   text surface1 bold
Hi QuickFixLine    NONE surface1
Hi debugPC         base ice
Hi debugBreakpoint ribbon NONE

Hi ErrorMsg        ribbon NONE bold
Hi WarningMsg      gold NONE
Hi ModeMsg         mint NONE bold
Hi MoreMsg         mint NONE
Hi Question        ice NONE
Hi MsgArea         subtext1 NONE
Hi MsgSeparator    overlay0 mantle

" --- syntax -------------------------------------------------------------------
Hi Comment         comment NONE italic
Hi Constant        peach NONE
Hi String          mint NONE
Hi Character       mint NONE
Hi Number          peach NONE
Hi Boolean         peach NONE
Hi Float           peach NONE

Hi Identifier      text NONE
Hi Function        ice NONE

Hi Statement       mauve NONE
Hi Conditional     mauve NONE
Hi Repeat          mauve NONE
Hi Label           mauve NONE
Hi Operator        sky NONE
Hi Keyword         mauve NONE
Hi Exception       ribbon NONE

Hi PreProc         teal NONE
Hi Include         teal NONE
Hi Define          teal NONE
Hi Macro           teal NONE
Hi PreCondit       teal NONE

Hi Type            gold NONE
Hi StorageClass    mauve NONE italic
Hi Structure       gold NONE
Hi Typedef         gold NONE

Hi Special         frost NONE
Hi SpecialChar     teal NONE
Hi Tag             ribbon NONE
Hi Delimiter       subtext0 NONE
Hi SpecialComment  sky NONE italic
Hi Debug           flare NONE

Hi Underlined      sapphire NONE underline
Hi Ignore          overlay0 NONE
Hi Error           flare NONE bold
Hi Todo            base gold bold
Hi Added           mint NONE
Hi Changed         gold NONE
Hi Removed         ribbon NONE

" --- diff & version control ---------------------------------------------------
Hi DiffAdd         mint surface0
Hi DiffChange      gold surface0
Hi DiffDelete      ribbon surface0
Hi DiffText        base gold bold
Hi diffAdded       mint NONE
Hi diffRemoved     ribbon NONE
Hi diffChanged     gold NONE
Hi diffLine        sky NONE
Hi diffFile        ice NONE bold
Hi diffNewFile     mint NONE
Hi diffOldFile     ribbon NONE

" --- spelling -----------------------------------------------------------------
Hi SpellBad        ribbon NONE undercurl
Hi SpellCap        gold NONE undercurl
Hi SpellRare       mauve NONE undercurl
Hi SpellLocal      teal NONE undercurl

" --- diagnostics (Neovim :h diagnostic-highlights) ----------------------------
Hi DiagnosticError          ribbon NONE
Hi DiagnosticWarn           gold NONE
Hi DiagnosticInfo           sky NONE
Hi DiagnosticHint           teal NONE
Hi DiagnosticOk             mint NONE
Hi DiagnosticUnderlineError ribbon NONE undercurl
Hi DiagnosticUnderlineWarn  gold NONE undercurl
Hi DiagnosticUnderlineInfo  sky NONE undercurl
Hi DiagnosticUnderlineHint  teal NONE undercurl
Hi DiagnosticVirtualTextError ribbon crust
Hi DiagnosticVirtualTextWarn  gold crust
Hi DiagnosticVirtualTextInfo  sky crust
Hi DiagnosticVirtualTextHint  teal crust

" --- common filetype tweaks ---------------------------------------------------
Hi htmlTag         subtext0 NONE
Hi htmlEndTag      subtext0 NONE
Hi htmlTagName     ribbon NONE
Hi htmlArg         gold NONE
Hi htmlH1          ice NONE bold
Hi markdownHeadingDelimiter ice NONE bold
Hi markdownH1      ice NONE bold
Hi markdownH2      sky NONE bold
Hi markdownCode    mint NONE
Hi markdownCodeBlock mint NONE
Hi markdownLinkText sapphire NONE underline
Hi markdownUrl     overlay2 NONE
Hi jsonKeyword     ice NONE
Hi yamlKey         ice NONE
Hi gitcommitSummary text NONE bold
Hi gitcommitComment comment NONE italic

" --- terminal ansi (Neovim) ---------------------------------------------------
if has('nvim')
  let g:terminal_color_0  = s:p['surface0'][0]
  let g:terminal_color_1  = s:p['ribbon'][0]
  let g:terminal_color_2  = s:p['mint'][0]
  let g:terminal_color_3  = s:p['gold'][0]
  let g:terminal_color_4  = s:p['blue'][0]
  let g:terminal_color_5  = s:p['mauve'][0]
  let g:terminal_color_6  = s:p['ice'][0]
  let g:terminal_color_7  = s:p['subtext1'][0]
  let g:terminal_color_8  = s:p['overlay0'][0]
  let g:terminal_color_9  = s:p['flare'][0]
  let g:terminal_color_10 = s:p['spring'][0]
  let g:terminal_color_11 = s:p['cream'][0]
  let g:terminal_color_12 = s:p['sky'][0]
  let g:terminal_color_13 = s:p['periwinkle'][0]
  let g:terminal_color_14 = s:p['frost'][0]
  let g:terminal_color_15 = s:p['text'][0]
endif

delcommand Hi
" vim: set et sw=2 :
