return {
    {
        "ggandor/leap.nvim",
        keys = { "s", "S" },
        opts = {
            max_phase_one_targets = nil,
            highlight_unlabeled_phase_one_targets = false,
            max_highlighted_traversal_targets = 10,
            case_sensitive = true,
            equivalence_classes = { " \t\r\n" },
            substitute_chars = {},
            safe_labels = { "s", "f", "j", "k", "l", "h", "u", "o", "m", "n" },
            labels = { "s", "f", "j", "k", "l", "h", "u", "i", "o", "m", "n", "w", "e", "r" },
            special_keys = {
                repeat_search = "<enter>",
                next_phase_one_target = "<enter>",
                next_target = { ";" },
                prev_target = { "," },
                next_group = "<space>",
                prev_group = "<tab>",
                multi_accept = "<enter>",
                multi_revert = "<backspace>",
            },
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings()

            vim.keymap.set("n", "<leader>s", function()
                local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
                    return vim.api.nvim_win_get_config(win).focusable
                end, vim.api.nvim_tabpage_list_wins(0))
                require("leap").leap({ target_windows = focusable_windows_on_tabpage })
            end)
        end,
    },
    {
        "ggandor/flit.nvim",
        keys = { "f", "F", "t", "T" },
        opts = {
            keys = { f = "f", F = "F", t = "t", T = "T" },
            -- A string like "nv", "nvo", "o", etc.
            labeled_modes = "v",
            multiline = true,
            -- Like `leap`s similar argument (call-specific overrides).
            -- E.g.: opts = { equivalence_classes = {} }
            opts = {},
        },
    },
}
