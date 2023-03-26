local builtins = require("null-ls").builtins
_G.toolset.rust = {
    server = { "rust_analyzer" },
    adapters = { "codelldb" },
    treesitter = { "rust" },
    sources = {
        builtins.formatting.rustfmt,
    },
}

return {}
