local builtins = require("null-ls").builtins
_G.toolset.lua = {
    server = { "lua_ls" },
    treesitter = { "lua", "luadoc" },
    sources = {
        builtins.formatting.stylua,
    },
}

return {}
