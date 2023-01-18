local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("telescope not found!")
    return
end

local fd_cmd = vim.fn.executable("fdfind") == 1 and "fdfind" or "fd"

telescope.setup({
    mappings = telescope.default_mappings,
    defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "->",
        path_display = {
            "smart_case",
            shorten = {
                len = 5,
                exclude = { 1, -1 },
            },
        },
        -- generic_sorter = require("mini.fuzzy").get_telescope_sorter,
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
    },
    pickers = {
        find_files = {
            find_command = { fd_cmd, "--type", "f", "--strip-cwd-prefix" },
        },
        lsp_references = {
            initial_mode = "normal",
            layout_strategy = "vertical",
            -- theme = "ivy",
        },
        lsp_implementations = {
            initial_mode = "normal",
            layout_strategy = "vertical",
            -- theme = "ivy",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        project = {
            base_dirs = {
                { "~/Projects", max_depth = 1 },
                { "~/Desktop/", max_depth = 2 },
            },
            hidden_files = false,
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = false,
        },
    },
})

telescope.load_extension("project")
telescope.load_extension("fzf")

require("which-key").register({
    ["<leader>f"] = {
        name = "Telescope",
        ["/"] = { "<cmd>Telescope<CR>", "pickers" },

        f = { "<cmd>Telescope find_files<CR>", "files" },
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
}, {})
vim.cmd([[
    cnoremap <expr> ;t getcmdtype() == ':' ? 'Telescope ' : ';t'
]])
