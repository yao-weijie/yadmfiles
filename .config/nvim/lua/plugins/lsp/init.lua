return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "tamago324/nlsp-settings.nvim",
        require("plugins.lsp.lspsaga"),
        require("plugins.lsp.trouble"),
        require("plugins.lsp.lsp-signature"),
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("plugins.lsp.handlers").setup()
    end,
    keys = {
        { "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "reanme symbol" },
        { "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", mode = { "n", "v" }, desc = "code_action" },
    },
}
