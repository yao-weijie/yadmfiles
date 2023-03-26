local builtins = require("null-ls").builtins
_G.toolset.sh = {
    server = { "bashls" },
    treesitter = { "bash" },
    sources = {
        builtins.diagnostics.zsh,
        builtins.formatting.shfmt,
    },
}

return {}
