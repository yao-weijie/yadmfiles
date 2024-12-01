-- vim.cmd([[
--     autocmd FileType sh setlocal noexpandtab
-- ]])

return {
    { "neovim/nvim-lspconfig", opts = { servers = { bashls = {} } } },
}
