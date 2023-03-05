return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-project.nvim",
        },
        priority = 100,
        event = { "VeryLazy" },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    prompt_prefix = "🔍 ",
                    selection_caret = "->",
                    path_display = {
                        "smart_case",
                        shorten = {
                            len = 3,
                            exclude = { 1, -1 },
                        },
                    },
                    sorting_strategy = "ascending", -- put best matching results on the top
                    -- horizontal, center, vertical, flex, cursor, bottom_pane
                    layout_strategy = "flex",
                    layout_config = {
                        prompt_position = "top",
                        preview_cutoff = 30,
                        flex = {
                            flip_columns = 120,
                        },
                    },
                    -- themes: dropdown: float, ivy: on the bottom, cursor: follow cursor,
                    themes = "dropdown",
                    mappings = {
                        i = {
                            -- 和leaderf 相同的快捷键设置
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-n>"] = actions.cycle_history_next,
                        },
                        n = {
                            ["q"] = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = {
                            vim.fn.executable("fdfind") == 1 and "fdfind" or "fd",
                            "--type",
                            "f",
                            "--strip-cwd-prefix",
                        },
                    },
                    lsp_references = {
                        initial_mode = "normal",
                        layout_strategy = "vertical",
                    },
                    lsp_implementations = {
                        initial_mode = "normal",
                        layout_strategy = "vertical",
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    project = {
                        base_dirs = {
                            { "~/Projects", max_depth = 2 },
                            { "~/Desktop/", max_depth = 2 },
                        },
                        hidden_files = false,
                        theme = "dropdown",
                        search_by = "title",
                        sync_with_nvim_tree = false,
                    },
                },
            })

            telescope.load_extension("project")
            telescope.load_extension("fzf")
        end,
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "files" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "buffers" },
            { "<leader>fl", "<cmd>Telescope live_grep<CR>", desc = "live grep" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "help" },
            { "<leader>fH", "<cmd>Telescope highlights<CR>", desc = "highlights" },
            { "<leader>fm", "<cmd>Telescope oldfiles<CR>", desc = "mru" }, -- mru: most recent used
            { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "commands" },
            { "<leader>fj", "<cmd>Telescope jumplist<CR>", desc = "jumplist" },
            { "<leader>fo", "<cmd>Telescope vim_options<CR>", desc = "vim options" },
            { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "keymaps" },
            { "<leader>fp", "<cmd>Telescope project<CR>", desc = "projects" },

            { "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", desc = "lsp_definition" },
            { "<leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "lsp_references" },
            { "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", desc = "lsp_implementations" },
            { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "lsp_document_symbols" },
            { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "lsp_workspace_symbols" },

            { "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "lines" },
        },
    },
    {
        "Yggdroot/LeaderF",
        event = { "VeryLazy" },
        priority = 99,
        -- need to pip install pynvim
        build = ":LeaderfInstallCExtension",
        cond = vim.fn.has("python3") == 1,
        init = function()
            vim.g.Lf_ShortcutF = ""
            vim.g.Lf_ShortcutB = ""
            vim.g.Lf_HideHelp = 1
            vim.g.Lf_ShowDevIcons = 1
            vim.g.Lf_WindowPosition = "popup"
            vim.g.Lf_RootMarkers = vim.g.ROOT_MARKERS
            vim.g.Lf_StlSeparator = { left = "", right = "" }

            vim.g.Lf_GtagsAutoGenerate = 1
            vim.g.Lf_Gtagslabel = "native-pygments"
        end,
        keys = {
            { "<leader>Fb", "<cmd>LeaderfBuffer<CR>", desc = "buffer" },
            { "<leader>Fm", "<cmd>LeaderfMru<CR>", desc = "mru" },
            { "<leader>Ff", "<cmd>LeaderfFile<CR>", desc = "file" },
            { "<leader>Fl", "<cmd>LeaderfLine<CR>", desc = "current file line" },
            { "<leader>Ft", "<cmd>LeaderfBufTag<CR>", desc = "buf tags" },
            { "<leader>FT", "<cmd>LeaderfBufTagAll<CR>", desc = "all buf tags" },
            { "<leader>F/", "<cmd>Leaderf self<CR>", desc = "Leaderf self" },
            { "<leader>Fr", "<Plug>LeaderfGtagsReference<CR>", desc = "Leader gtsgs reference" },
        },
    },
}
