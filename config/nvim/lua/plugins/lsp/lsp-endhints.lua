vim.g.enable_endhints = true

---@type LazySpec
return {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    enabled = function()
        return vim.g.enable_endhints
    end,
    opts = {}, -- required, even if empty
    config = function()
        require("lsp-endhints").setup({})
        vim.api.nvim_create_user_command("LspEnableHints", require("lsp-endhints").enable, {})
        vim.api.nvim_create_user_command("LspDisableHints", require("lsp-endhints").disable, {})
        vim.api.nvim_create_user_command("LspToggleHints", require("lsp-endhints").toggle, {})
    end,
}
