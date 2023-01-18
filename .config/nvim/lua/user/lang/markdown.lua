local builtins = require("null-ls").builtins
local toolset = {
    name = "markdown",
    server = {},
    treesitter = { "markdown", "markdown_inline" },
    sources = {},
}

return toolset
