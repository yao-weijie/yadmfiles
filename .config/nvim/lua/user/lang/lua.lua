local builtins = require("null-ls").builtins
local toolset = {
    name = "lua",
    server = { "sumneko_lua" },
    treesitter = { "lua" },
    sources = {
        builtins.formatting.stylua,
    },
}

return toolset
