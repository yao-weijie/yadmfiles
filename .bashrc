source /etc/profile
[[ -f ~/.shell_env ]] && source ~/.shell_env
[[ -f ~/.shell_alias ]] && source ~/.shell_alias

$(executable "starship") && eval "$(starship init bash)"

z_root="$HOME/.local/share/zinit/plugins/skywind3000---z.lua"
[[ -d $z_root ]] && eval "$(luajit $z_root/z.lua --init bash)"

[[ -f /usr/bin/fzf ]] && source /usr/share/doc/fzf/examples/key-bindings.bash
[[ -f ~/.cargo/bin/lcode ]] && eval "$(lcode --generate bash)"
[[ -f ~/.shell_local ]] && source ~/.shell_local
alias reload="source ~/.bashrc && clear"
