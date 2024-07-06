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

---@type LazySpec
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "williamboman/mason-lspconfig.nvim", version = "*", config = true },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                local configs = {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    ---@param client vim.lsp.Client
                    ---@param bufnr integer
                    on_attach = function(client, bufnr)
                        -- vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
                        -- client.server_capabilities.semanticTokensProvider = nil --禁用lsp 语义高亮
                    end,
                }

                local lsp_default_configs = require("lspconfig.server_configurations." .. server_name).default_config
                configs = vim.tbl_deep_extend("force", configs, lsp_default_configs)

                if _G.pathlib.file_exist(("~/.config/nvim/lua/pkg-settings/%s.lua"):format(server_name)) then
                    local spec_configs = require(("pkg-settings.%s"):format(server_name))
                    configs = vim.tbl_deep_extend("force", configs, spec_configs)
                end

                require("lspconfig")[server_name].setup(configs)
            end,
        })
    end,
}
