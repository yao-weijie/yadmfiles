vim.cmd([[
    autocmd FileType sh setlocal noexpandtab
]])

return {
    "nvimdev/indentmini.nvim",
    event = { "BufEnter" },
    config = true,
}
