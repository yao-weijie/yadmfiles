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
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = true,
        signs = {
            active = signs,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

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
