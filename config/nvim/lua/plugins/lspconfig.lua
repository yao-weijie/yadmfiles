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
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "gr", vim.lsp.buf.rename, desc = "reanme symbol" },
        {
            "[d",
            function()
                vim.diagnostic.jump({ count = -1, float = true })
            end,
            desc = "diagnostics prev",
        },
        {
            "]d",
            function()
                vim.diagnostic.jump({ count = 1, float = true })
            end,
            desc = "diagnostics next",
        },
        { "ga", vim.lsp.buf.code_action, desc = "code action" },
        { "K", vim.lsp.buf.hover, desc = "show document" },
        -- { "<C-LeftMouse>", vim.lsp.buf.definition, desc = "definition" },
        -- { "gd", vim.lsp.buf.definition, desc = "definition" },
    },
    opts = {
        servers = {
            lua_ls = {},
            vimls = {},
        },
    },
    config = function(_, opts)
        local lspconfig = require("lspconfig")
        local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        for server, config in pairs(opts.servers) do
            if config.capabilities ~= nil then
                config.capabilities = vim.tbl_extend("force", config.capabilities, cmp_capabilities)
            else
                config.capabilities = cmp_capabilities
            end
            local default_cmd = require("lspconfig.configs." .. server).default_config.cmd[1]
            if vim.fn.executable(default_cmd) == 1 then
                lspconfig[server].setup(config)
            else
                vim.notify(server .. " is not executable", vim.log.levels.WARN)
            end
        end
    end,
}
