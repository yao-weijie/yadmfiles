local align_opts = {
    mappings = {
        start = "<leader>a",
        start_with_preview = "<leader>A",
    },
}

return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.cursorword").setup({ delay = 100 })
        require("mini.align").setup(align_opts)
    end,
}
