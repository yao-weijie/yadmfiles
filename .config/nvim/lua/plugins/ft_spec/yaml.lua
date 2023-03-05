local builtins = require("null-ls").builtins
_G.toolset["yaml"] = {
    server = { "yamlls" },
    treesitter = { "yaml" },
    sources = {
        builtins.formatting.prettierd,
    },
}

vim.cmd([[
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
]])
