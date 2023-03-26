local builtins = require("null-ls").builtins
_G.toolset.markdown = {
    server = { "markdown" },
    treesitter = { "markdown", "markdown_inline" },
    sources = {
        -- builtins.diagnostics.markdownlint,
    },
}

return {}
