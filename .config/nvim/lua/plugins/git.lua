return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            yadm = { enable = true },
            worktrees = {
                {
                    toplevel = vim.env.HOME,
                    gitdir = vim.fn.expand("~/.local/share/yadm/repo.git"),
                },
            },
            -- keymapping
            on_attach = function(bufnr)
                local keymap = vim.keymap.set
                local opts = { buffer = bufnr }
                -- open lazygit and gitui with toggleterm
                -- <leader>gl LazyGit
                -- <leader>gg GitUI

                keymap("n", "gj", "<cmd>Gitsigns next_hunk<CR>", opts)
                keymap("n", "gk", "<cmd>Gitsigns prev_hunk<CR>", opts)
                keymap("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", opts)
                keymap("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", opts)
                keymap("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", opts)

                keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", opts)
                keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts)
                keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts)
                keymap("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts)
                keymap("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", opts)
                keymap("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", opts)

                keymap("n", "<leader>gD", "<cmd>lua require'gitsigns'.diffthis('~')<CR>", opts)

                keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
                keymap({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", opts)
            end,
        },
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewToggleFiles" },
        opts = {
            enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
            file_panel = {
                win_config = {
                    position = "left", -- One of 'left', 'right', 'top', 'bottom'
                    listing_style = "tree", -- One of 'list' or 'tree'
                    tree_options = { -- Only applies when listing_style is 'tree'
                        flatten_dirs = true, -- Flatten dirs that only contain one single dir
                        folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
                    },
                },
            },
            file_history_panel = {
                win_config = {
                    position = "bottom",
                    log_options = {
                        max_count = 256, -- Limit the number of commits
                        follow = false, -- Follow renames (only for single file)
                        all = false, -- Include all refs under 'refs/' including HEAD
                        merges = false, -- List only merge commits
                        no_merges = false, -- List no merge commits
                        reverse = false, -- List commits in reverse order
                    },
                },
            },
            keymaps = {
                disable_defaults = false, -- Disable the default key bindings
                -- The `view` bindings are active in the diff buffers, only when the current
                -- tabpage is a Diffview.
            },
        },
    },
}
