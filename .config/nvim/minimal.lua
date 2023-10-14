-- minimal config used for debug
-- vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

require("helper.lazy").setup({
    -- plugins and configs
    spec = {
        { "folke/lazy.nvim", version = "*" },
        {
            "nvim-treesitter/nvim-treesitter",
            dependencies = {
                "HiPhish/nvim-ts-rainbow2",
            },
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = { "c", "cpp", "vim", "lua", "luadoc" },
                    highlight = {
                        enable = true,
                    },
                    rainbow = {
                        enable = true,
                    },
                })
            end,
        },
    },
})
