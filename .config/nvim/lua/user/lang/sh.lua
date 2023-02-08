local builtins = require("null-ls").builtins

local toolset = {
    name = "sh",
    server = { "bashls" },
    treesitter = { "bash" },
    sources = {
        builtins.diagnostics.zsh,
        builtins.formatting.shfmt,
    },
}

return toolset
