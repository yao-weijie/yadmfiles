local builtins = require("null-ls").builtins

local toolset = {
    name = "sh",
    server = { "bashls" },
    treesitter = { "bash" },
    sources = {
        builtins.formatting.shfmt,
        builtins.diagnostics.zsh,
    },
}

return toolset
