local align_opts = {
    mappings = {
        start = "<leader>a",
        start_with_preview = "<leader>A",
    },
}

local surround_opts = {
    mappings = {
        add = "ys",
        delete = "ds",
        find = "",
        find_left = "",
        highlight = "",
        replace = "cs",
        update_n_lines = "",

        suffix_last = "",
        suffix_next = "",
    },
}

return {
    "echasnovski/mini.nvim",
    version = "*",
    event = { "VeryLazy" },
    config = function()
        require("mini.cursorword").setup({ delay = 100 })
        require("mini.align").setup(align_opts)
        -- require("mini.surround").setup(surround_opts)
    end,
}
