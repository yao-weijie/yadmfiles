" vim config, no dependences, vi not supported
source ~/.config/nvim/lua/user/basic/options.vim
source ~/.config/nvim/lua/user/basic/keymaps.vim
source ~/.config/nvim/lua/user/basic/autocmd.vim
colorscheme desert

if has("nvim")
    lua require("user.plugins")
    lua require("user.conf")
    lua require("user.lang")
    colorscheme nightfox
endif
