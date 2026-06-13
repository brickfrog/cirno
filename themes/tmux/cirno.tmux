#!/usr/bin/env bash
# Cirno - a Touhou ice-fairy theme for tmux (dark)
# https://github.com/brickfrog/cirno
# Install: chmod +x cirno.tmux && add `run-shell ~/path/to/cirno.tmux` to ~/.tmux.conf

# --- Palette ---------------------------------------------------------------
bg="#0a1120"        # mantle
crust="#070c18"     # crust
surface0="#16203a"
surface1="#1f2c4a"
surface2="#2b3c60"
overlay1="#536b91"
text="#d4e4f5"
subtext0="#a3b6d2"
subtext1="#bdcfe6"
ice="#7ad6f0"
gold="#e8cd86"
ribbon="#ec5a72"
dark="#0e1525"      # base, used as fg-on-ice

# --- Base ------------------------------------------------------------------
tmux set -g status on
tmux set -g status-interval 5
tmux set -g status-justify left
tmux set -g status-position bottom
tmux set -g status-style "bg=${bg},fg=${subtext0}"

# --- Left: session block on ice with dark text -----------------------------
tmux set -g status-left-length 40
tmux set -g status-left "#[fg=${dark},bg=${ice},bold] #S #[fg=${ice},bg=${bg},nobold]"

# --- Right: date / host on surface tints -----------------------------------
tmux set -g status-right-length 80
tmux set -g status-right "#[fg=${surface1},bg=${bg}]#[fg=${subtext1},bg=${surface1}] %Y-%m-%d #[fg=${surface2},bg=${surface1}]#[fg=${text},bg=${surface2}] %H:%M #[fg=${ice},bg=${surface2}]#[fg=${dark},bg=${ice},bold] #h "

# --- Windows ---------------------------------------------------------------
tmux set -g window-status-separator ""
tmux set -g window-status-format "#[fg=${subtext0},bg=${bg}] #I #W "
tmux set -g window-status-current-format "#[fg=${bg},bg=${ice}]#[fg=${dark},bg=${ice},bold] #I #W #[fg=${ice},bg=${bg},nobold]"
tmux set -g window-status-activity-style "fg=${ribbon},bg=${bg}"
tmux set -g window-status-bell-style "fg=${ribbon},bg=${bg},bold"

# --- Panes -----------------------------------------------------------------
tmux set -g pane-border-style "fg=${surface1}"
tmux set -g pane-active-border-style "fg=${ice}"

# --- Messages / command prompt ---------------------------------------------
tmux set -g message-style "fg=${dark},bg=${gold},bold"
tmux set -g message-command-style "fg=${dark},bg=${gold}"

# --- Copy mode -------------------------------------------------------------
tmux set -g mode-style "fg=${text},bg=${surface2}"

# --- Clock / misc ----------------------------------------------------------
tmux set -g clock-mode-colour "${ice}"
tmux set -g display-panes-active-colour "${ice}"
tmux set -g display-panes-colour "${overlay1}"
