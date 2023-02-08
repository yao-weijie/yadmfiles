local builtins = require("null-ls").builtins
local toolset = {
    name = "rust",
    server = { "rust_analyzer" },
    dap_adapter = { "codelldb" },
    treesitter = { "rust" },
    sources = {
        builtins.formatting.rustfmt,
    },
}

return toolset
