# Cirno - fish color script
# https://github.com/brickfrog/cirno
# Install: source ~/.config/fish/themes/cirno.fish   (sets universal fish_color_* vars)
#
# Unlike the .theme file (which is loaded via `fish_config theme`), this script
# sets the universal variables directly so it can be sourced from config.fish.
# Touhou ice-fairy palette: midnight navy, starlight blue, ice-cyan, one red ribbon.

# --- syntax colors -----------------------------------------------------------
set -U fish_color_normal d4e4f5
set -U fish_color_command 7ad6f0
set -U fish_color_keyword b78ee2
set -U fish_color_quote 84ddb2
set -U fish_color_redirection 6fb2ee
set -U fish_color_end 6fb2ee
set -U fish_color_error f4849a
set -U fish_color_param d4e4f5
set -U fish_color_option a3b6d2
set -U fish_color_comment 5f7299
set -U fish_color_selection --background=1f2c4a
set -U fish_color_search_match --background=2b3c60
set -U fish_color_operator 6fb2ee
set -U fish_color_escape 5fccc6
set -U fish_color_autosuggestion 536b91
set -U fish_color_cancel ec5a72 --reverse
set -U fish_color_valid_path --underline
set -U fish_color_history_current --bold 7ad6f0

# --- prompt helpers ----------------------------------------------------------
set -U fish_color_cwd 7ad6f0
set -U fish_color_cwd_root ec5a72
set -U fish_color_user 84ddb2
set -U fish_color_host 6fb2ee
set -U fish_color_host_remote e8cd86
set -U fish_color_status ec5a72

# --- pager colors ------------------------------------------------------------
set -U fish_pager_color_progress f2dda0
set -U fish_pager_color_background
set -U fish_pager_color_prefix 7ad6f0 --bold
set -U fish_pager_color_completion d4e4f5
set -U fish_pager_color_description 5f7299
set -U fish_pager_color_selected_background --background=1f2c4a
set -U fish_pager_color_selected_prefix ace6f7 --bold
set -U fish_pager_color_selected_completion d4e4f5
set -U fish_pager_color_selected_description bdcfe6
set -U fish_pager_color_secondary_background
set -U fish_pager_color_secondary_prefix 7ad6f0
set -U fish_pager_color_secondary_completion a3b6d2
set -U fish_pager_color_secondary_description 5f7299
