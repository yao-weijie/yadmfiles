# if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     tmux a -t default || exec tmux new -s default && exit
# fi

source /etc/profile
source ~/.shell_env
source ~/.shell_alias

# $(executable "starship") && eval "$(starship init zsh)"
eval "$(starship init zsh)"

bindkey -e emacs

autoload -Uz compinit && compinit

##############################################################################
[[ -f ~/.zinitrc ]] && source ~/.zinitrc
[[ -f ~/.shell_local ]] && source ~/.shell_local
alias reload="exec zsh && clear"
