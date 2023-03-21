local builtins = require("null-ls").builtins
_G.toolset["python"] = {
    server = { "jedi_language_server", "ruff_lsp", "pyre" },
    treesitter = { "python" },
    adapters = { "python" },
    sources = {
        -- configure with pyproject.toml in project root
        builtins.formatting.black,
        builtins.formatting.isort,
        builtins.diagnostics.mypy,
    },
}

vim.fn.setenv("PYRE_BINARY", vim.fn.stdpath("data") .. "/mason/bin/pyre")
