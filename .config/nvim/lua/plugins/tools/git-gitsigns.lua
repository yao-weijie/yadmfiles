return {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BUfNewFile" },
    opts = {
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
        worktrees = {
            {
                toplevel = vim.env.HOME,
                gitdir = vim.env.HOME .. "/.local/share/yadm/repo.git",
            },
        },
        -- keymapping
        on_attach = function(bufnr)
            local keymap = vim.keymap.set
            local opts = { buffer = bufnr }

            keymap("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", opts)
            keymap("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", opts)
            keymap("n", "<leader>hj", "<cmd>Gitsigns next_hunk<CR>", opts)
            keymap("n", "<leader>hk", "<cmd>Gitsigns preview_hunk<CR>", opts)

            keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", opts)
            keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts)
            keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts)
            keymap("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts)
            keymap("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", opts)
            keymap("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", opts)

            keymap("n", "<leader>gD", '<cmd>lua require"gitsigns".diffthis("~")<CR>', opts)

            keymap({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", opts)
        end,
    },
}
