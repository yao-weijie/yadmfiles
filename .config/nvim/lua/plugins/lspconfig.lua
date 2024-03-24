local diagnostic_signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        active = diagnostic_signs,
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
})

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
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    on_attach = function(client, bufnr)
                        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
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
