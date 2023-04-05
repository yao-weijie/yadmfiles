local builtins = require("null-ls").builtins
_G.toolset.lua = {
    server = { "lua_ls" },
    treesitter = { "lua", "luap", "luadoc" },
    sources = {
        builtins.formatting.stylua,
    },
}

return {}
