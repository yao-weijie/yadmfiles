local saga_keys = {
    split = "<C-x>",
    vsplit = "<C-v>",
    tabe = "<C-t>",
    quit = "q",
}

---@type LazySpec
return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    event = { "BufRead" },
    keys = {
        { "gr", vim.lsp.buf.rename, desc = "reanme symbol" },
        { "[d", vim.diagnostic.goto_prev, desc = "diagnostics prev" },
        { "]d", vim.diagnostic.goto_next, desc = "diagnostics next" },
        -- { "<leader>d", vim.diagnostic.setqflist, desc = "diagnostics" }, -- open with quickfix

        { "ga", "<cmd>Lspsaga code_action<CR>", desc = "code_action" },
        { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "show document" },
        { "gh", "<cmd>Lspsaga finder<CR>", desc = "preview definition" },
        { "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "preview definition" },
        { "<C-LeftMouse>", "<cmd>Lspsaga finder<CR>", desc = "preview definition" },
        { "<C-t>", "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "t" }, desc = "term_toggle" },
    },
    opts = {
        symbol_in_winbar = {
            enable = false,
        },
        rename = {
            enable = false,
            keys = {
                quit = "q",
            },
        },
        finder = {
            keys = vim.tbl_extend("force", saga_keys, {
                shuttle = "[w",
            }),
        },
        definition = {
            keys = vim.tbl_extend("force", saga_keys, {
                edit = "o",
            }),
        },
        callhierarchy = {
            keys = vim.tbl_extend("force", saga_keys, {
                shuttle = "[w",
                edit = "<CR>",
            }),
        },
        lightbulb = {
            enable = false,
        },
        ui = {
            border = "single",
        },
    },
}
