---@type LazySpec
return {
    "stevearc/overseer.nvim",
    -- version = "*",
    event = { "VeryLazy" },
    opts = {
        strategy = "terminal",
        -- strategy = "toggleterm",
        -- templates = { "builtin" },
        task_list = {
            min_width = { 50, 0.3 },
            bindings = {
                ["<C-l>"] = false,
                ["<C-h>"] = false,
                ["<C-k>"] = false,
                ["<C-j>"] = false,
                ["["] = "PrevTask",
                ["]"] = "NextTask",
                ["{"] = false,
                ["}"] = false,

                ["<C-s>"] = false,
                ["<C-x>"] = "OpenSplit",
                ["<C-v>"] = "OpenVsplit",
            },
        },
    },
    config = function(_, opts)
        require("overseer").setup(opts)
        require("overseer").register_template(require("plugins.overseer.template.asynctask"))
        -- require("overseer").register_template(require("plugins.overseer.template.xmake"))
    end,
}
