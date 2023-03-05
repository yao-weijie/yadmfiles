local builtins = require("null-ls").builtins
_G.toolset["c-cpp"] = {
    server = { "clangd", "cmake" },
    adapters = { "codelldb" },
    treesitter = { "c", "cpp", "cmake" },
    sources = {
        -- C, C++, Java, JavaScript, JSON, C#
        builtins.formatting.clang_format,
    },
}
