return require("helper.lazy").lazy_require("plugins/edit", {
    "meain/vim-printer",
    "tpope/vim-repeat",
    "mbbill/undotree",
    { "ThePrimeagen/refactoring.nvim", event = { "VeryLazy" }, config = true },
})
