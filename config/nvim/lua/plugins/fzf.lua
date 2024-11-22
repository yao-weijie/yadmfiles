---@type LazySpec
return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = function()
        return {
            -- "default",
            winopts = {
                -- split = "belowright new",
                preview = {
                    vertical = "up:50%",
                    horizontal = "right:50%",
                    delay = 50,
                },
            },
            files = {
                path_shorten = 5,
            },
            diagnostics = {
                split = "belowright new",
            },
            lsp = {
                finder = {
                    includeDeclaration = true, -- include current declaration in LSP context
                    providers = {
                        { "references", prefix = require("fzf-lua").utils.ansi_codes.blue("ref ") },
                        { "definitions", prefix = require("fzf-lua").utils.ansi_codes.green("def ") },
                        -- { "declarations", prefix = require("fzf-lua").utils.ansi_codes.magenta("decl") },
                        -- { "typedefs", prefix = require("fzf-lua").utils.ansi_codes.red("tdef") },
                        -- { "implementations", prefix = require("fzf-lua").utils.ansi_codes.green("impl") },
                        -- { "incoming_calls", prefix = require("fzf-lua").utils.ansi_codes.cyan("in  ") },
                        -- { "outgoing_calls", prefix = require("fzf-lua").utils.ansi_codes.yellow("out ") },
                    },
                },
            },
        }
    end,
    cmd = { "FzfLua" },
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

        -- { "<leader>d", "<cmd>FzfLua lsp_document_diagnostics<CR>", desc = "lsp_document_diagnostics" },
        { "<leader>fd", "<cmd>FzfLua lsp_definitions<CR>", desc = "lsp_definition" },
        { "<leader>fr", "<cmd>FzfLua lsp_references<CR>", desc = "lsp_references" },
        { "<leader>fi", "<cmd>FzfLua lsp_implementations<CR>", desc = "lsp_implementations" },
        { "<leader>fF", "<cmd>FzfLua lsp_finder<CR>", desc = "lsp_finder" },
        { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "lsp_document_symbols" },
        { "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc = "lsp_workspace_symbols" },

        { "<C-f>", "<cmd>FzfLua grep_curbuf<CR>", desc = "lines" },
    },
}
