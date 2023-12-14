return {
    "stevearc/aerial.nvim",
    version = "*",
    keys = {
        { "<leader>o", "<cmd>AerialToggle<CR>", desc = "aerial outline" },
    },
    opts = {
        layout = {
            min_width = 30,
            default_direction = "right",
            placement = "edge",
        },
        attach_mode = "global",

        -- 太淡了
        highlight_on_jump = 1000,

        -- Show box drawing characters for the tree hierarchy
        show_guides = true,
    },
}
