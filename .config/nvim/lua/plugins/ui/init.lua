return {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/popup.nvim",
    "onsails/lspkind.nvim",
    "MunifTanjim/nui.nvim",
    "lukas-reineke/indent-blankline.nvim",
    {
        "echasnovski/mini.cursorword",
        config = function()
            require("mini.cursorword").setup({ delay = 100 })
        end,
    },
}
