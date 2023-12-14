local builtins = require("null-ls").builtins
_G.toolset.json = {
    server = { "jsonls" },
    treesitter = { "json", "jsonc", "json5" },
    sources = {
        builtins.formatting.prettierd,
    },
}

vim.cmd([[
    autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2 cursorcolumn
]])

return {}
