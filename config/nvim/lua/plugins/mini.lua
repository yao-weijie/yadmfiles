---@type LazySpec
return {
    "echasnovski/mini.nvim",
    version = "*",
    enabled = false,
    -- event = { "VeryLazy" },
    opts = {
        -- sub-plug: opts
        align = {
            mappings = {
                start = "<leader>a",
                start_with_preview = "<leader>A",
            },
        },
        -- cursorword = { delay = 100 },
        -- surround = {
        --     mappings = {
        --         add = "ys",
        --         delete = "ds",
        --         find = "",
        --         find_left = "",
        --         highlight = "",
        --         replace = "cs",
        --         update_n_lines = "",
        --         suffix_last = "",
        --         suffix_next = "",
        --     },
        -- },
    },
    config = function(_, opts)
        for plug, opt in pairs(opts) do
            require("mini." .. plug).setup(opt)
        end
    end,
}
