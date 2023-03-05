local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    dev = {
        path = "~/Projects/dev/",
        fallback = true, -- 如果本地没有就用github 上的
    },
    git = {
        log = { "-10" },
    },
})

-- init.lua 加载优先级高于同级目录下其他所有文件
-- 一些基础性的插件可以放在这里
-- 为了ft_spec 里不报错,null-ls 也放在这里
return {
    { "folke/lazy.nvim" },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
            require("plugins.lsp.null-ls")
        end,
    },
    {
        "williamboman/mason.nvim",
        commit = "24846a00941ec020c8addc7f52040a1b2fc12174",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim", config = true },
            { "jay-babu/mason-null-ls.nvim", config = true },
            { "jayp0521/mason-nvim-dap.nvim", opts = { automatic_setup = true } },
        },
        config = true,
    },
    { "nvim-lua/plenary.nvim", lazy = true },
    { "kevinhwang91/nvim-bqf", ft = "qf" },
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
        dir = "~/Projects/dev/leetcode.nvim",
        opts = {
            leetcode_china = true,
        },
    },
}
