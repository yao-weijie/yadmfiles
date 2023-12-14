return {
    "folke/trouble.nvim",
    keys = {
        { "<leader>d", "<cmd>Trouble document_diagnostics<CR>", desc = "diagnostics trouble" },
    },
    opts = {
        height = 10, -- height of the trouble list when position is top or bottom
        mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            refresh = "r", -- manually refresh
            jump = { "<Tab>" }, -- jump to the diagnostic or open / close folds
            toggle_mode = "w", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = { "zO", "zc" }, -- close all folds
            open_folds = { "zo" }, -- open all folds
            toggle_fold = { "o" }, -- toggle fold of current file
        },
        -- auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
    },
}
