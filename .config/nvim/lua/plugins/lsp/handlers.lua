local M = {}

M.on_attach = function(client, bufnr)
    --
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.offsetEncoding = { "utf-16" }
M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    -- snippet禁用无效,要在cmp里设置
    snippetSupport = false,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = false,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}
M.lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

M.setup = function()
    -- diagnostic signs defined in plugins/ui/signs

    -- 通过yaml/json文件来设置lsp-server
    -- nlspsettings必须放在server启动之前
    require("nlspsettings").setup({
        config_home = vim.fn.stdpath("config") .. "/lua/plugins/lsp/settings",
        loader = "yaml",
        nvim_notify = { enable = true },
    })

    require("mason-lspconfig").setup_handlers({
        function(server_name)
            require("lspconfig")[server_name].setup({
                on_attach = M.on_attach,
                capabilities = M.capabilities,
                flags = M.lsp_flags,
                -- root_dir = require("lspconfig").util.root_pattern(vim.g.ROOT_MARKERS),
            })
        end,
    })
end

return M
