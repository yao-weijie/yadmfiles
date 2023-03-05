return require("utils").lazy_require("plugins/git", {
    { "akinsho/git-conflict.nvim", lazy = true },
    { "rbong/vim-flog", lazy = true },
    { "tpope/vim-fugitive", lazy = true },
})
