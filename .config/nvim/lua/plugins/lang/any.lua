local builtins = require("null-ls").builtins
_G.toolset.any = {
    treesitter = { "vimdoc" },
    sources = {
        -- single file mode
        -- builtins.diagnostics.todo_comments,

        builtins.code_actions.gitsigns,

        builtins.formatting.trim_whitespace,
        builtins.formatting.trim_newlines,
    },
}

return {}
