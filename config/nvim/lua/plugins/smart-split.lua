---@type LazySpec
return {
    "mrjones2014/smart-splits.nvim",
    config = true,
    lazy = false,
    keys = {
        { "<C-h>", "<cmd>SmartCursorMoveLeft<CR>" },
        { "<C-j>", "<cmd>SmartCursorMoveDown<CR>" },
        { "<C-k>", "<cmd>SmartCursorMoveUp<CR>" },
        { "<C-l>", "<cmd>SmartCursorMoveRight<CR>" },

        { "<M-h>", "<cmd>SmartResizeLeft<CR>" },
        { "<M-j>", "<cmd>SmartResizeDown<CR>" },
        { "<M-k>", "<cmd>SmartResizeUp<CR>" },
        { "<M-l>", "<cmd>SmartResizeRight<CR>" },
    },
}
