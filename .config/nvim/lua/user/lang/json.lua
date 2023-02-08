local builtins = require("null-ls").builtins
local toolset = {
    name = "json",
    server = { "jsonls" },
    treesitter = { "json", "json5" },
    sources = {
        builtins.formatting.prettierd,
    },
}

vim.cmd([[
    autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
]])

return toolset
