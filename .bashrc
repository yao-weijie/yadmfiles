source /etc/profile
source ~/.shell_env
source ~/.shell_alias

eval "$(starship init bash)"
eval "$(luajit $HOME/.local/share/zinit/plugins/skywind3000---z.lua/z.lua --init bash)"
