local on_attach = function(client, bufnr)
    --
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- clangd
capabilities.offsetEncoding = { "utf-16" }
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    -- snippet禁用无效,要在cmp里设置
    snippetSupport = false,
}

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "folke/neodev.nvim", version = "*", config = true },
        "hrsh7th/cmp-nvim-lsp",
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
        { "williamboman/mason-lspconfig.nvim", config = true },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    flags = lsp_flags,
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
