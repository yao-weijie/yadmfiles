local builtins = require("null-ls").builtins
local toolset = {
    name = "markdown",
    server = { "markdown" },
    treesitter = { "markdown", "markdown_inline" },
    sources = {},
}

return toolset
