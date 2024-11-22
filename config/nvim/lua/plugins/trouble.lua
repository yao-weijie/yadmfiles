---@type LazySpec
return {
    "folke/trouble.nvim",
    version = "*",
    keys = {
        { "<leader>d", "<cmd>Trouble diagnostics<CR>", desc = "diagnostics trouble" },
    },
    event = { "VeryLazy" },
    ---@type trouble.Config
    opts = {
        height = 10,
        width = 50,
        padding = false,
        mode = "document_diagnostics",
        auto_fold = true,
        auto_jump = false,
        -- preview = {
        --     type = "main",
        -- },
    },
}
