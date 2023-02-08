local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("telescope not found!")
    return
end

local fd_cmd = vim.fn.executable("fdfind") == 1 and "fdfind" or "fd"

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
            find_command = { fd_cmd, "--type", "f", "--strip-cwd-prefix" },
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
                { "~/Projects", max_depth = 1 },
                { "~/Desktop/", max_depth = 2 },
            },
            hidden_files = false,
            theme = "dropdown",
            search_by = "title",
            sync_with_nvim_tree = false,
        },
        file_browser = {
            --
        },
    },
})

telescope.load_extension("project")
telescope.load_extension("fzf")
telescope.load_extension("file_browser")

require("which-key").register({
    ["<leader>f"] = {
        name = "Telescope",
        ["/"] = { "<cmd>Telescope<CR>", "pickers" },

        f = { "<cmd>Telescope find_files<CR>", "files" },
        F = { "<cmd>Telescope file_browser<CR>", "file browser" },
        b = { "<cmd>Telescope buffers<CR>", "buffers" },
        l = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "lines" },
        L = { "<cmd>Telescope live_grep<CR>", "live grep" },
        h = { "<cmd>Telescope help_tags<CR>", "help" },
        H = { "<cmd>Telescope highlights<CR>", "highlights" },
        m = { "<cmd>Telescope oldfiles<CR>", "mru" }, -- mru: most recent used
        c = { "<cmd>Telescope commands<CR>", "commands" },
        j = { "<cmd>Telescope jumplist<CR>", "jumplist" },
        o = { "<cmd>Telescope vim_options<CR>", "vim options" },
        k = { "<cmd>Telescope keymaps<CR>", "keymaps" },
        p = { "<cmd>Telescope project<CR>", "projects" },
        -- lsp support
        d = { "<cmd>Telescope lsp_definitions<CR>", "lsp_definition" },
        r = { "<cmd>Telescope lsp_references<CR>", "lsp_references" },
        i = { "<cmd>Telescope lsp_implementations<CR>", "lsp_implementations" },
        s = { "<cmd>Telescope lsp_document_symbols<CR>", "lsp_document_symbols" },
        S = { "<cmd>Telescope lsp_workspace_symbols<CR>", "lsp_workspace_symbols" },
    },
    ["<C-f>"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "lines" },
}, {})
vim.cmd([[
    cnoremap <expr> ;t getcmdtype() == ':' ? 'Telescope ' : ';t'
]])
