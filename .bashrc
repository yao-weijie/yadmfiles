source /etc/profile
source "$HOME/.shell_env"
source "$HOME/.shell_alias"

eval "$(starship init bash)"
eval "$(luajit $HOME/.local/share/zinit/plugins/skywind3000---z.lua/z.lua --init bash)"

[[ -f ~/.shell_local ]] && source ~/.shell_local
