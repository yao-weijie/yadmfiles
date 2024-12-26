vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        -- active = diagnostic_signs,
        text = {
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.ERROR] = "",
        },
    },
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})
vim.api.nvim_create_user_command("LspEnableDiagnostics", function()
    vim.diagnostic.enable(true)
end, {})
vim.api.nvim_create_user_command("LspDisableDiagnostics", function()
    vim.diagnostic.enable(false)
end, {})

-- globally lsp LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client ~= nil and client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end
        if client ~= nil and client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end
    end,
})
vim.api.nvim_create_autocmd("LspDetach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- Do something with the client
        vim.cmd("setlocal tagfunc< omnifunc<")
    end,
})

---@type LazySpec
return {
    { import = "plugins.lsp" },
}
