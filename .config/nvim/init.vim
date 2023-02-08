source ~/.config/nvim/lua/user/basic/init.vim

if has("nvim")
    lua require("user.plugins")
    lua require("user.conf")
    lua require("user.lang")
endif
