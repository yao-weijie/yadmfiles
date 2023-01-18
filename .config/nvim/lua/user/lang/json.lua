local builtins = require("null-ls").builtins
local toolset = {
    name = "json",
    server = { "jsonls" },
    treesitter = { "json", "json5" },
    sources = {
        -- builtins.formatting.fixjson,
        -- builtins.formatting.yamlfmt,
        -- builtins.formatting.prettierd,
    },
}

return toolset
