local builtins = require("null-ls").builtins
local toolset = {
    name = "yaml",
    server = { "yamlls" },
    treesitter = { "yaml" },
    sources = {
        -- builtins.formatting.fixjson,
        -- builtins.formatting.yamlfmt,
        builtins.formatting.prettierd,
    },
}

return toolset
