-- vim:foldmethod=marker:

-- icons {{{
vim.diagnostic.config({
    underline = true,
    -- virtual_text = true,
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
-- }}}

--- {{{ global lsp attach
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end
        if client.server_capabilities.definitionProvider then
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
--- }}}

---@type LazySpec
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    -- event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    keys = {
        { "gr", vim.lsp.buf.rename, desc = "reanme symbol" },
        { "[d", vim.diagnostic.goto_prev, desc = "diagnostics prev" },
        { "]d", vim.diagnostic.goto_next, desc = "diagnostics next" },
        { "ga", vim.lsp.buf.code_action, desc = "code action" },
        { "K", vim.lsp.buf.hover, desc = "show document" },
        -- { "<C-LeftMouse>", vim.lsp.buf.definition, desc = "definition" },
        -- { "gd", vim.lsp.buf.definition, desc = "definition" },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local server_config_override = require("plugins.lsp.servers")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        for server_name, config in pairs(server_config_override) do
            config = vim.tbl_deep_extend("force", config, { capabilities = capabilities }) ---@type lspconfig.Config
            -- TODO: lsp servers not in lspconfig
            lspconfig[server_name].setup(config)
        end
    end,
}
