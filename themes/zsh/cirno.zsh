# Cirno - zsh-syntax-highlighting theme
# https://github.com/brickfrog/cirno
# Install: source this file AFTER zsh-syntax-highlighting.zsh in your ~/.zshrc
#
#   source /path/to/zsh-syntax-highlighting.zsh
#   source /path/to/cirno.zsh
#
# Requires: zsh-syntax-highlighting (and optionally zsh-autosuggestions).
# Touhou ice-fairy palette: midnight navy, starlight blue, ice-cyan, one red ribbon.

# Ensure the styles array exists.
typeset -gA ZSH_HIGHLIGHT_STYLES

# --- defaults ----------------------------------------------------------------
ZSH_HIGHLIGHT_STYLES[default]='fg=#d4e4f5'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ec5a72,bold'

# --- commands ----------------------------------------------------------------
ZSH_HIGHLIGHT_STYLES[command]='fg=#7ad6f0'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7ad6f0'
ZSH_HIGHLIGHT_STYLES[function]='fg=#7ad6f0'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#7ad6f0'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#7ad6f0,underline'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#7ad6f0'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#6fb2ee,italic'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#7ad6f0'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#9fb6f2'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#9fb6f2'

# --- reserved words / keywords ----------------------------------------------
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#b78ee2'

# --- strings -----------------------------------------------------------------
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#84ddb2'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#84ddb2'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#84ddb2'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#a4ebc8'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#5fccc6'

# --- escapes / variables inside double quotes --------------------------------
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#5fccc6'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#5fccc6'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#9fb6f2'

# --- comments ----------------------------------------------------------------
ZSH_HIGHLIGHT_STYLES[comment]='fg=#5f7299,italic'

# --- numbers / constants -----------------------------------------------------
ZSH_HIGHLIGHT_STYLES[numeric-argument]='fg=#eca06a'

# --- operators, redirection, separators --------------------------------------
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#6fb2ee'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#6fb2ee'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#6fb2ee'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#7ad6f0'

# --- globbing ----------------------------------------------------------------
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#5fccc6'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#5fccc6'

# --- options / parameters ----------------------------------------------------
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#a3b6d2'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#a3b6d2'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#9fb6f2'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#7ad6f0,underline'

# --- paths -------------------------------------------------------------------
ZSH_HIGHLIGHT_STYLES[path]='fg=#d4e4f5,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#6a82a8,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#d4e4f5'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#6a82a8'

# --- brackets ----------------------------------------------------------------
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#ec5a72,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#7ad6f0'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#b78ee2'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#84ddb2'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#e8cd86'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#6fb2ee'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'

# --- autosuggestions (zsh-autosuggestions plugin) ----------------------------
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#536b91'
