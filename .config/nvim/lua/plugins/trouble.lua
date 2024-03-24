return {
    "folke/trouble.nvim",
    version = "*",
    keys = {
        { "<leader>d", "<cmd>Trouble document_diagnostics<CR>", desc = "diagnostics trouble" },
    },
    opts = {
        height = 10,
        width = 50,
        padding = false,
        mode = "document_diagnostics",
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
    },
}
