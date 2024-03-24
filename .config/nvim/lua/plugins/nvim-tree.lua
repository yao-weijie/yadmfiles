local opts = {
    auto_reload_on_write = true,
    hijack_netrw = true,
    disable_netrw = true,
    hijack_cursor = true, -- keep the curosr on the first letter of filename
    hijack_unnamed_buffer_when_opening = true,
    open_on_tab = true,
    sort_by = "name",

    view = {
        -- width = 40,
        width = {
            min = 30,
            max = -1,
        },
        preserve_window_proportions = false,
        signcolumn = "no",

        float = {
            enable = true,
            open_win_config = {
                border = { "", "", "", "│", "┘", "─", "", "" },
                width = 35,
                height = 40,
                row = 1,
                col = 0,
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
            ".vscode",
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
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    version = "*",
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "toggle nvim-tree" },
    },
    config = function()
        opts.on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            local function keymap(lhs, rhs, desc)
                if type(lhs) == "string" then
                    vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = bufnr, noremap = true })
                elseif type(lhs) == "table" then
                    for i = 1, #lhs do
                        vim.keymap.set("n", lhs[i], rhs, { desc = desc, buffer = bufnr, noremap = true })
                    end
                end
            end

            -- open
            keymap({ "o", "<CR>", "<2-LeftMouse>" }, api.node.open.edit, "Open")
            keymap("<C-v>", api.node.open.vertical, "Open: Vertical Split")
            keymap("<C-x>", api.node.open.horizontal, "Open: Horizontal Split")
            keymap("<C-t>", api.node.open.tab, "Open: New Tab")
            keymap("<Tab>", api.node.open.preview, "preview")
            keymap("O", api.node.run.system, "System Open")

            -- fs
            keymap("a", api.fs.create, "create")
            keymap("c", api.fs.copy.node, "copy")
            keymap("x", api.fs.cut, "cut")
            keymap("v", api.fs.paste, "paste")
            keymap("d", api.fs.trash, "trash")
            keymap("D", api.fs.remove, "remove")
            keymap("r", api.fs.rename, "rename")
            keymap("y", api.fs.copy.filename, "copy filename")
            keymap("Y", api.fs.copy.relative_path, "copy relative path")
            keymap("gy", api.fs.copy.absolute_path, "copy absolute path")

            -- change node
            keymap("H", api.tree.change_root_to_parent, "cd up")
            keymap("L", api.tree.change_root_to_node, "cd")
            keymap("h", api.node.navigate.parent, "parent node")
            keymap("l", api.node.navigate.sibling.last, "last sibling")
            keymap("K", api.node.show_info_popup, "info")
            keymap("[g", api.node.navigate.git.prev, "prev git item")
            keymap("]g", api.node.navigate.git.next, "next git item")

            -- view
            keymap("i", api.tree.toggle_gitignore_filter, "toggle git ignore")
            keymap(".", api.tree.toggle_hidden_filter, "toggle dotfiles")
            keymap("f", api.live_filter.start, "filter")
            keymap("F", api.live_filter.clear, "clean filter")
            keymap("R", api.tree.reload, "refresh")
            keymap("b", api.tree.toggle_no_buffer_filter, "toggle no buffer")
            keymap({ "q", "<Esc>" }, api.tree.close, "quit")
            keymap("g?", api.tree.toggle_help, "help")
        end
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
