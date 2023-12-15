return {
    { "folke/lazy.nvim", version = "*" },
    { "williamboman/mason.nvim", version = "*", config = true },
    {
        "arnamak/stay-centered.nvim",
        config = function()
            vim.o.scrolloff = math.floor(vim.fn.winheight(0) / 2)
        end,
    },
    -- {
    --     "karb94/neoscroll.nvim",
    --     keys = { "<C-u>", "<C-d>" },
    --     config = function()
    --         require("neoscroll").setup({
    --             mappings = { "<C-u>", "<C-d>" },
    --         })
    --         local t = {}
    --         -- Syntax: t[keys] = {function, {function arguments}}
    --         t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "75" } }
    --         t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "75" } }

    --         require("neoscroll.config").set_mappings(t)
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
