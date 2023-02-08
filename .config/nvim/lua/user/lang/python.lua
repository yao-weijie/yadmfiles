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

local function leetcode_matched()
    local fname = vim.fn.expand("%:t")
    if string.match(fname, [[[%d]+.*.leetcode.py]]) then
        return true
    else
        vim.notify("This is a Leetcode file!", 3)
        return false
    end
end

vim.keymap.set("n", "<leader>ls", function()
    if not leetcode_matched() then
        return
    end
    local no = string.match(vim.fn.expand("%:t"), "[%d]+")
    vim.cmd([[AsyncRun leetcode exec ]] .. no)
end, {})

vim.keymap.set("n", "<leader>lt", function()
    if not leetcode_matched() then
        return
    end
    local no = string.match(vim.fn.expand("%:t"), "[%d]+")
    vim.cmd([[AsyncRun leetcode test ]] .. no)
end, {})

return toolset
