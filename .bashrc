source /etc/profile
[[ -f ~/.shell_env ]] && source ~/.shell_env
[[ -f ~/.shell_alias ]] && source ~/.shell_alias

$(executable "starship") && eval "$(starship init bash)"

z_root="$HOME/.local/share/zinit/plugins/skywind3000---z.lua"
[[ -d $z_root ]] && eval "$(luajit $z_root/z.lua --init bash)"

[[ -f ~/.shell_local ]] && source ~/.shell_local
