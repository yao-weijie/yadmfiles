-- minimal config used for debug
-- vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

require("helper.lazy").setup({
    -- plugins and configs
    spec = {
        { "folke/lazy.nvim", version = "*" },
    },
})
