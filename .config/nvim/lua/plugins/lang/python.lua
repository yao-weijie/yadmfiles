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
