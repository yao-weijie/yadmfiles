source ~/.config/nvim/lua/config/init.vim

if has("nvim")
    lua require("helper.lazy").setup()
endif
