local builtins = require("null-ls").builtins
_G.toolset["lua"] = {
    server = { "lua_ls" },
    treesitter = { "lua" },
    sources = {
        builtins.formatting.stylua,
    },
}

-- return {
--     "folke/neodev.nvim",
--     version = "*",
--     config = true,
-- }
