return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>b", "<cmd>Neotree git_status<CR>", desc = "neo-tree git_status" },
    },
    opts = {
        close_if_last_window = true,
        source_selector = {
            winbar = true,
            sources = { -- table
                {
                    source = "filesystem", -- string
                    display_name = " 󰉓 Files ", -- string | nil
                },
                {
                    source = "buffers", -- string
                    display_name = " 󰈚 Buffers ", -- string | nil
                },
                {
                    source = "git_status", -- string
                    display_name = " 󰊢 Git ", -- string | nil
                },
            },
        },
        window = {
            width = 30,
            mappings = {
                ["<C-x>"] = "open_split",
                ["<C-v>"] = "open_vsplit",
                ["<C-t>"] = "open_tabnew",

                a = "add",
                c = "copy_to_clipboard",
                x = "cut_to_clipboard",
                v = "paste_from_clipboard",
                r = "rename",
                d = "delete",

                f = "filter_on_submit",
                F = "clear_filter",

                -- ["."] = "toggle_hidden",
                -- y =
                -- Y =
                -- gy =

                H = "navigate_up",
                L = "set_root",
                ["<Space>"] = "toggle_node",
            },
        },
        filesystem = {
            filtered_items = {
                hide_by_name = {
                    "build",
                    "node_modules",
                },
                hide_by_pattern = {
                    -- "",
                },
                always_show = {
                    ".gitignore",
                },
                never_show = {
                    "__pycache__",
                },
                never_show_by_pattern = {},
            },
        },
    },
}
