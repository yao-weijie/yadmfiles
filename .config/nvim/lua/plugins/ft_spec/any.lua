local builtins = require("null-ls").builtins
_G.toolset["any"] = {
    treesitter = { "help" },
    sources = {
        -- single file mode
        builtins.diagnostics.todo_comments,

        builtins.code_actions.gitsigns,
        builtins.code_actions.refactoring,

        builtins.formatting.trim_whitespace,
        builtins.formatting.trim_newlines,
    },
}
