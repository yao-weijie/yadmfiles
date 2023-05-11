return {
    {
        "ggandor/leap.nvim",
        keys = {
            "s",
            "S",
            { "<leader>s", "<Plug>(leap-from-window)" },
        },
        lazy = false,
        opts = {
            max_phase_one_targets = nil,
            highlight_unlabeled_phase_one_targets = false,
            max_highlighted_traversal_targets = 15,
            case_sensitive = true,
            equivalence_classes = {
                " \t\r\n",
                -- 用于跳转到中文标点上, 好用!
                ",，",
                ".。",
                ":：",
                ";；",
                [['"“”]],
                "(（",
                ")）",
                "\\、",
            },
            substitute_chars = {},
            safe_labels = {},
            labels = vim.split("jkluiomnfdswec", "", {}),
            special_keys = {
                repeat_search = "<Enter>",
                next_phase_one_target = "<Enter>",
                next_target = { "n", ";" },
                prev_target = { "N", "," },
                next_group = "<Space>",
                prev_group = "<Tab>",
                multi_accept = "<Enter>",
                multi_revert = "<Backspace>",
            },
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings()
        end,
    },
    {
        "ggandor/flit.nvim",
        keys = { "f", "F", "t", "T" },
        opts = {
            keys = { f = "f", F = "F", t = "t", T = "T" },
            labeled_modes = "v",
            multiline = false,
        },
    },
}
