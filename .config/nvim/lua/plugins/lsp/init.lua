return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "folke/neodev.nvim", version = "*", config = true },
        {
            -- 通过yaml/json文件来设置lsp-server
            -- nlspsettings必须放在server启动之前
            "tamago324/nlsp-settings.nvim",
            opts = {
                config_home = vim.fn.stdpath("config") .. "/lua/plugins/lsp/settings",
                loader = "yaml",
                nvim_notify = { enable = true },
            },
        },
        require("plugins.lsp.lspsaga"),
        require("plugins.lsp.trouble"),
        require("plugins.lsp.lsp-signature"),
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- diagnostic signs defined in plugins/ui/signs

        local handlers = require("plugins.lsp.handlers")
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    on_attach = handlers.on_attach,
                    capabilities = handlers.capabilities,
                    flags = handlers.lsp_flags,
                    -- root_dir = require("lspconfig").util.root_pattern(vim.g.ROOT_MARKERS),
                })
            end,
        })
    end,
    keys = {
        { "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "reanme symbol" },
        { "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", mode = { "n", "v" }, desc = "code_action" },
    },
}
