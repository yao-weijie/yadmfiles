if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    tmux a -t default || exec tmux new -s default && exit;
fi

source /etc/profile
source ~/.shell_env
source ~/.shell_alias
eval "$(starship init zsh)"

##############################################################################
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
autoload -Uz compinit && compinit

# load from repository
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/history-search-multi-word
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light skywind3000/z.lua
# use .autoenv.zsh and .autoenv_leave.zsh
zinit light Tarrasch/zsh-autoenv

# load sub plugins from oh-my-zsh
zinit snippet OMZP::git
zinit snippet OMZP::extract
zinit snippet OMZP::tmux

ENABLE_CORRECTION="true"
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::termsupport.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::grep.zsh

bindkey -e emacs

##############################################################################
# ignore case sensitive when completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
