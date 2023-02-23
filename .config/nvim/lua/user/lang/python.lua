local builtins = require("null-ls").builtins
local toolset = {
    name = "python",
    server = { "jedi_language_server", "ruff_lsp" },
    treesitter = { "python" },
    dap_adapter = { "python" },
    sources = {
        -- configure with pyproject.toml in project root
        builtins.formatting.black,
        builtins.formatting.isort,
    },
}

vim.g.pydocstring_formattter = "google"
vim.g.pydocstring_ignore_init = 1

return toolset
