return {
    { "folke/lazy.nvim" },
    { "williamboman/mason.nvim", config = true },
    {
        "karb94/neoscroll.nvim",
        keys = { "<C-u>", "<C-d>" },
        config = function()
            require("neoscroll").setup({
                mappings = { "<C-u>", "<C-d>" },
            })
            local t = {}
            -- Syntax: t[keys] = {function, {function arguments}}
            t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "75" } }
            t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "75" } }

            require("neoscroll.config").set_mappings(t)
        end,
    },
    {
        "aserowy/tmux.nvim",
        keys = { "<C-h>", "<C-j>", "<-C-k>", "<C-l>" },
        opts = {
            resize = {
                -- enables default keybindings (A-hjkl) for normal mode
                enable_default_keybindings = false,
            },
        },
    },
    {
        "voldikss/vim-translator",
        cmd = { "TranslateW" },
        keys = {
            { "<leader><C-t>", "<cmd>TranslateW<CR>", mode = { "n", "v" }, desc = "translate" },
        },
        config = function()
            vim.g.translator_target_lang = "zh"
            vim.g.translator_default_engines = { "bing", "haici" }
        end,
    },
    { "kevinhwang91/nvim-bqf", ft = "qf" },
}
