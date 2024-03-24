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
    -- {
    --     "arnamak/stay-centered.nvim",
    --     config = function()
    --         vim.o.scrolloff = math.floor(vim.fn.winheight(0) / 2)
    --     end,
    -- },
    {
        "aserowy/tmux.nvim",
        keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
        opts = {
            resize = {
                -- enables default keybindings (A-hjkl) for normal mode
                enable_default_keybindings = false,
            },
        },
    },
    -- { "kevinhwang91/nvim-bqf", ft = "qf" },
}
