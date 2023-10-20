vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

require("helper.lazy").setup({
    spec = {
        -- 经过这种import 方式导入插件的lua 文件必须返回一个table
        { import = "plugins.ui" },
        { import = "plugins.edit" },
        { import = "plugins.lsp" },
        { import = "plugins.dap" },
        { import = "plugins.tools" },
        { import = "plugins.lang" },
        { import = "autoload" },
    },
    dev = {
        path = "~/Projects/neovim/",
    },
})
