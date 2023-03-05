return {
    "folke/trouble.nvim",
    keys = {
        -- Trouble可以显示null-ls linter的信息,所以不绑定buffer
        { "<leader>d", "<cmd>Trouble document_diagnostics<CR>", desc = "diagnostics trouble" },
    },
    opts = {
        height = 10, -- height of the trouble list when position is top or bottom
        mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        padding = false, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = { "<Tab>" }, -- jump to the diagnostic or open / close folds
            open_split = { "<C-x>", "<C-s>" }, -- open buffer in new split
            open_vsplit = { "<C-v>" }, -- open buffer in new vsplit
            open_tab = { "<C-t>" }, -- open buffer in new tab
            jump_close = { "<CR>" }, -- jump to the diagnostic and close the list
            toggle_mode = "w", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = { "zO", "zc" }, -- close all folds
            open_folds = { "zo" }, -- open all folds
            toggle_fold = { "o" }, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j", -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        -- auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
        use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
    },
}
