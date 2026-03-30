eval "$(tv init zsh)"

# _tv_shell_history() {
#     emulate -L zsh
#     zle -I
#
#     _disable_bracketed_paste
#
#     local current_prompt
#     current_prompt=$LBUFFER
#
#     local output
#
#     output=$(history -n -1 0 | tail -n 10000 | tv --no-sort --height 50 --width 150 --no-status-bar --no-preview --no-remote --no-help-panel --input-header "History" --input "$current_prompt" "$@")
#
#     zle reset-prompt
#     if [[ -n $output ]]; then
#         RBUFFER=""
#         LBUFFER=$(echo "$output")
#     fi
#
#     _enable_bracketed_paste
# }
#
# zle -N tv-shell-history _tv_shell_history
#
# bindkey -M emacs '^R' tv-shell-history
# bindkey -M viins '^R' tv-shell-history
# bindkey -M vicmd '^R' tv-shell-history
