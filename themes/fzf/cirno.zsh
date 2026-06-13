# Cirno - fzf color theme (zsh)
# https://github.com/brickfrog/cirno
# Install: source this file from ~/.zshrc (after any fzf setup)
#
# Appends the Cirno --color string to FZF_DEFAULT_OPTS.
# Touhou ice-fairy palette: midnight navy, starlight blue, ice-cyan, one red ribbon.

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=bg:#0e1525,bg+:#16203a \
--color=fg:#d4e4f5,fg+:#d4e4f5:bold \
--color=hl:#7ad6f0,hl+:#ace6f7 \
--color=info:#b78ee2,border:#3d5277 \
--color=prompt:#7ad6f0,pointer:#ec5a72 \
--color=marker:#84ddb2,spinner:#e8cd86 \
--color=header:#6fb2ee,gutter:#0e1525"
