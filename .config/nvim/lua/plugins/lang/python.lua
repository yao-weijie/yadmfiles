local builtins = require("null-ls").builtins
_G.toolset.python = {
    server = { "jedi_language_server", "ruff_lsp" },
    treesitter = { "python" },
    adapters = { "python" },
    sources = {
        -- configure with pyproject.toml in project root
        builtins.formatting.black,
        builtins.formatting.isort,
        -- builtins.diagnostics.mypy,
    },
}

require("helper.leetcode").setup({
    leetcode_china = true,
})

return {
    "nvim-neotest/neotest-python",
    ft = { "python" },
    dependencies = { "nvim-neotest/neotest" },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                    python = "python",
                }),
            },
        })
    end,
}
