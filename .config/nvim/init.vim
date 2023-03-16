source ~/.config/nvim/vimrc

if has("nvim")
    lua require("helper.lazy").setup()
endif
