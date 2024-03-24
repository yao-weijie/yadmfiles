return {
    "ibhagwan/fzf-lua",
    -- dir = "~/workspace/neovim/fzf-lua/",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = { "VeryLazy" },
    enabled = _G.pathlib.executable("fzf"),
    opts = {
        "default",
        -- "fzf-native",
        winopts = {
            preview = {
                border = "noborder",
                vertical = "up:50%",
                horizontal = "right:50%",
                delay = 50,
            },
        },
        files = {
            path_shorten = 3,
        },
        diagnostics = {
            split = "belowright new",
        },
    },
    keys = {
        { "<leader>f/", "<cmd>FzfLua <CR>", desc = "FzfLua self" },
        { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "files" },
        { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "buffers" },
        { "<leader>fl", "<cmd>FzfLua live_grep<CR>", desc = "live grep" },
        { "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "help" },
        { "<leader>fH", "<cmd>FzfLua highlights<CR>", desc = "highlights" },
        { "<leader>fm", "<cmd>FzfLua oldfiles<CR>", desc = "mru" }, -- mru: most recent used
        { "<leader>fc", "<cmd>FzfLua commands<CR>", desc = "commands" },
        { "<leader>fj", "<cmd>FzfLua jumps<CR>", desc = "jumplist" },
        { "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "keymaps" },
        { "<leader>fq", "<cmd>FzfLua quickfix<CR>", desc = "quickfix" },
        { "<leader>fw", "<cmd>FzfLua grep_cword<CR>", desc = "cword" },
        { "<leader>fa", "<cmd>lua require('helper.asynctask').fzf_select()<CR>", desc = "asynctask" },

        { "<leader>d", "<cmd>FzfLua lsp_document_diagnostics<CR>", desc = "lsp_document_diagnostics" },
        { "<leader>fd", "<cmd>FzfLua lsp_definitions<CR>", desc = "lsp_definition" },
        { "<leader>fr", "<cmd>FzfLua lsp_references<CR>", desc = "lsp_references" },
        { "<leader>fi", "<cmd>FzfLua lsp_implementations<CR>", desc = "lsp_implementations" },
        { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "lsp_document_symbols" },
        { "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc = "lsp_workspace_symbols" },

        { "<C-f>", "<cmd>FzfLua grep_curbuf<CR>", desc = "lines" },
    },
}
