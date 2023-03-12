return require("helper.lazy").lazy_require("plugins/edit", {
    { "kylechui/nvim-surround", version = "*", config = true },
    "meain/vim-printer",
    "tpope/vim-repeat",
    "mbbill/undotree",
    { "ThePrimeagen/refactoring.nvim", event = { "VeryLazy" }, config = true },
})
