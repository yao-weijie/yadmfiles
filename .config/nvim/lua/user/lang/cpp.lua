local builtins = require("null-ls").builtins
local toolset = {
    name = "c-cpp",
    server = { "clangd", "cmake" },
    dap_adapter = { "codelldb" },
    treesitter = { "c", "cpp", "cmake" },
    sources = {
        builtins.formatting.clang_format,
    },
}

return toolset
