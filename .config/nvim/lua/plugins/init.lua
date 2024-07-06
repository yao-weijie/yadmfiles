---@type LazySpec
return {
    "tpope/vim-repeat",
    {
        "rareitems/printer.nvim",
        config = true,
        keys = {
            { "<leader>p", "<Plug>(printer_print)iw", desc = "printer cwd" },
        },
    },
    { "williamboman/mason.nvim", config = true },
}
