local opts = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    operators = {},
    key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "ENTER",
        ["<tab>"] = "TAB",
    },
    window = {
        padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    triggers = "auto", -- automatically setup triggers
    -- triggers = { "<leader>", "[", "]", "g" }, -- or specify a list manually
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
    },
    disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
    },
}

return {
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    opts = opts,
    config = function(_, opts)
        require("which-key").setup(opts)
        require("which-key").register({
            ["g"] = "goto",
            ["["] = "prev",
            ["]"] = "next",
        })
    end,
}
