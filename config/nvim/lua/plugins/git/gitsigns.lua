---@type LazySpec
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    version = "*",
    opts = {
        current_line_blame = true,
        -- yadm = { enable = true },
        -- worktrees = {},
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
}
