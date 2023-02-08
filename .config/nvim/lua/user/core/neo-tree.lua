local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
    vim.notify("neo-tree not found!")
    return
end

neo_tree.setup({
    sources = {
        "filesystem",
        "buffers",
        "git_status",
    },
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
})
