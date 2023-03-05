return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree", "NeoTreeFloatToggle" },
    opts = {
        source_selector = {
            winbar = true,
        },
        window = {
            position = "float",
            mappings = {
                ["o"] = "toggle_node",
                ["<space>"] = "toggle_node",
            },
        },
        filesystem = {
            group_empty_dirs = true,
            filtered_items = {
                hide_by_name = {
                    "node_modules",
                    "__pycache__",
                },
                hide_by_pattern = {
                    "*.pyc",
                },
                always_show = {
                    ".gitignore",
                    ".vscode",
                },
                never_show = {
                    ".DS_Store",
                },
            },
        },
        buffers = {
            window = {
                mappings = {
                    ["d"] = "buffer_delete",
                },
            },
        },
        git_status = {
            window = {
                mappings = {
                    ["gA"] = "git_add_all",
                },
            },
        },
    },
}
