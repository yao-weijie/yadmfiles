local opts = {
    auto_reload_on_write = true,
    hijack_netrw = true,
    disable_netrw = true,
    hijack_cursor = true, -- keep the curosr on the first letter of filename
    hijack_unnamed_buffer_when_opening = true,
    open_on_tab = true,
    sort_by = "name",

    view = {
        width = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",

        mappings = {
            custom_only = true,
            list = {
                -- open file
                { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
                { key = "<C-x>", action = "split" },
                { key = "<C-v>", action = "vsplit" },
                { key = "<C-t>", action = "tabnew" },
                { key = "<C-p>", action = "preview" },

                -- file
                { key = "a", action = "create" },
                { key = "c", action = "copy" },
                { key = "x", action = "cut" },
                { key = "v", action = "paste" },
                { key = "d", action = "trash" },
                { key = "D", action = "remove" },
                { key = "r", action = "rename" },

                -- filters
                { key = "f", action = "live_filter" },
                { key = "F", action = "clear_live_filter" },

                -- copy path
                { key = "y", action = "copy_path" },
                { key = "Y", action = "copy_absolute_path" },

                -- change dir
                { key = "H", action = "dir_up" },
                { key = "L", action = "cd" },
                { key = "h", action = "parent_node" },
                { key = "l", action = "last_sibling" },

                -- show and ignore
                { key = ".", action = "toggle_dotfiles" },
                { key = "i", action = "toggle_git_ignored" },
                { key = "b", action = "toggle_no_buffer" },
                { key = "R", action = "refresh" },

                -- git files
                { key = "[g", action = "prev_git_item" },
                { key = "]g", action = "next_git_item" },

                -- exit
                { key = "q", action = "close" },
                { key = "<esc>", action = "close" },

                -- help
                { key = "g?", action = "toggle_help" },
            },
        },
    },

    renderer = {
        group_empty = true,
        indent_markers = { enable = true },
        icons = {
            webdev_colors = true,
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
            },
        },
    },

    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    system_open = {
        cmd = "",
        args = {},
    },

    diagnostics = { enable = false },
    filters = {
        dotfiles = true,
        custom = {
            "lazy-lock.json",
            "__pycache__",
        },
        exclude = {
            ".gitignore",
        },
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },

    trash = {
        cmd = "trash",
        require_confirm = true,
    },

    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = {
                enable = true,
                chars = "jkluio",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
    filesystem_watchers = {
        enable = false,
    },
}

return {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    keys = {
        { "<leader>E", "<cmd>NvimTreeToggle<CR>", desc = "toggle nvim-tree" },
    },
    config = function()
        require("nvim-tree").setup(opts)

        local api = require("nvim-tree.api")
        local Event = api.events.Event
        api.events.subscribe(Event.FileCreated, function(file)
            api.tree.reload()
            vim.cmd("edit " .. vim.fn.fnamemodify(file.fname, ":p"))
        end)

        api.events.subscribe(Event.FolderCreated, function(folder)
            api.tree.reload()
        end)
    end,
}
