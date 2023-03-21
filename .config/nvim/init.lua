vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

require("helper.lazy").setup({
    spec = {
        { import = "plugins" },
    },
    dev = {
        path = "~/Projects/dev/",
        fallback = true, -- 如果本地没有就用github 上的
    },
})
