local builtins = require("null-ls").builtins
_G.toolset.python = {
    server = { "jedi_language_server", "ruff_lsp" },
    treesitter = { "python" },
    adapters = { "python" },
    sources = {
        -- configure with pyproject.toml in project root
        builtins.formatting.black,
        builtins.formatting.isort,
    },
}

local loaded_python_plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "python" },
    callback = function()
        if loaded_python_plugins then
            return
        end
        loaded_python_plugins = true

        require("helper.leetcode").setup({
            leetcode_china = true,
        })
        require("helper.conda").setup()
    end,
})

return {}
