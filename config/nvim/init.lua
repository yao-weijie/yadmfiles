vim.cmd.source(vim.fn.stdpath("config") .. "/vimrc")

if vim.fn.has("nvim-0.10") ~= 1 then
    vim.notify("user config requires neovim >= 0.10")
    return
end

require("helper.lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "lang" },
    },
})
