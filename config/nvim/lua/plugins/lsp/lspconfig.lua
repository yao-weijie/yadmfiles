---@type LazySpec
return {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    keys = {
        { "gr", vim.lsp.buf.rename, desc = "reanme symbol" },
        {
            "[d",
            vim.diagnostic.goto_prev,
            desc = "diagnostics prev",
        },
        {
            "]d",
            vim.diagnostic.goto_next,
            desc = "diagnostics next",
        },
        { "ga", vim.lsp.buf.code_action, desc = "code action" },
        { "K", vim.lsp.buf.hover, desc = "show document" },
        -- { "<C-LeftMouse>", vim.lsp.buf.definition, desc = "definition" },
        -- { "gd", vim.lsp.buf.definition, desc = "definition" },
    },
    config = function()
        local servers = require("plugins.lsp.config.servers")
        local lspconfig = require("lspconfig")
        local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()
        for server, config in pairs(servers) do
            -- capabilities
            if config.capabilities ~= nil then
                config.capabilities = vim.tbl_extend("force", config.capabilities, cmp_capabilities)
            else
                config.capabilities = cmp_capabilities
            end

            -- if server is executable
            local default_cmd = require("lspconfig.configs." .. server).default_config.cmd[1]
            if vim.fn.executable(default_cmd) == 1 then
                lspconfig[server].setup(config)
            else
                vim.notify(server .. " is not executable", vim.log.levels.WARN)
            end
        end
    end,
}
