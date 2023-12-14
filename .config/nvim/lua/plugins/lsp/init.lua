local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    -- 禁用lsp 语义高亮
    -- client.server_capabilities.semanticTokensProvider = nil
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    -- snippet禁用无效,要在cmp里设置
    snippetSupport = false,
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "folke/neodev.nvim", version = "*", config = true, lazy = true },
        "hrsh7th/cmp-nvim-lsp",
        { "williamboman/mason-lspconfig.nvim", version = "*", config = true },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                local configs = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    root_dir = require("lspconfig").util.root_pattern(vim.g.ROOT_MARKERS),
                }

                if vim.pathlib.file_exist(("~/.config/nvim/lua/plugins/lsp/settings/%s.lua"):format(server_name)) then
                    local spec_configs = require(("plugins.lsp.settings.%s"):format(server_name))
                    configs = vim.tbl_deep_extend("force", configs, spec_configs)
                end

                require("lspconfig")[server_name].setup(configs)
            end,
        })
    end,
}
