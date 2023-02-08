local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    vim.notify("gitsigns not found!")
    return
end

gitsigns.setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = { enable = true },
    -- keymapping
    on_attach = function(bufnr)
        require("which-key").register({

            ["<leader>gj"] = { "<cmd>Gitsigns next_hunk<CR>" },
            ["<leader>gk"] = { "<cmd>Gitsigns prev_hunk<CR>" },
            ["<leader>hj"] = { "<cmd>Gitsigns next_hunk<CR>" },
            ["<leader>hk"] = { "<cmd>Gitsigns preview_hunk<CR>" },

            ["<leader>gd"] = { "<cmd>Gitsigns diffthis<CR>" },
            ["<leader>gs"] = { "<cmd>Gitsigns stage_hunk<CR>" },
            ["<leader>gr"] = { "<cmd>Gitsigns reset_hunk<CR>" },
            ["<leader>gu"] = { "<cmd>Gitsigns undo_stage_hunk<CR>" },
            ["<leader>gS"] = { "<cmd>Gitsigns stage_buffer<CR>" },
            ["<leader>gR"] = { "<cmd>Gitsigns reset_buffer<CR>" },

            -- ["<leader>hb"] = { '<cmd>lua require"gitsigns".blame_line{full=true}<CR>' },
            -- ["<leader>hD"] = { '<cmd>lua require"gitsigns".diffthis("~")<CR>' },
            -- ["<leader>td"] = { "<cmd>Gitsigns toggle_deleted<CR>" },
        }, { buffer = bufnr })

        require("which-key").register({
            ["ih"] = { ":<C-U>Gitsigns select_hunk<CR>" },
        }, { mode = { "o", "x" }, buffer = bufnr })
    end,
})
