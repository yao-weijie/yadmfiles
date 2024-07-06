vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

require("helper.lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "lang" },
    },
})
