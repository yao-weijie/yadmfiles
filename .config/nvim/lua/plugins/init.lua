-- init.lua 加载优先级高于同级目录下其他所有文件
-- 一些基础性的插件可以放在这里
-- 为了ft_spec 里不报错,null-ls 也放在这里
return {
    { "folke/lazy.nvim" },
    { "jose-elias-alvarez/null-ls.nvim", config = require("helper.format") },
    {
        "williamboman/mason.nvim",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim", config = true },
            { "jay-babu/mason-null-ls.nvim", config = true },
            { "jayp0521/mason-nvim-dap.nvim", opts = { automatic_setup = true } },
        },
        config = true,
    },
    { "nvim-lua/plenary.nvim", lazy = true },
}
