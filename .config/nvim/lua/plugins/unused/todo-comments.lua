-- 得要有个:才行, 比如 TODO:
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "VeryLazy" },
    keys = {
        { "<leader>D", "<cmd>TodoQuickFix<CR>", desc = "todo comments" },
    },
    config = true,
}
