vim.g.autoformat_enabled = true

local function auto_format()
    if not vim.g.autoformat_enabled then
        return
    end

    local async = false
    if vim.pathlib.is_hugefile(0, "100k") or vim.fn.line("$") > 1000 then
        async = true
    end

    vim.lsp.buf.format({
        async = async,
        filter = function(client)
            return client.name == "null-ls"
        end,
    })
end

local function toggle_autoformat()
    if vim.g.autoformat_enabled then
        vim.g.autoformat_enabled = false
        vim.notify("Autoformat disabled!")
    else
        vim.g.autoformat_enabled = true
        vim.notify("Autoformat enabled!")
    end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function()
        -- 大于1w 行禁用自动格式化
        if vim.fn.line("$") > 10000 then
            return
        end

        auto_format()
    end,
})
vim.api.nvim_create_user_command("LspFormat", auto_format, {})
vim.api.nvim_create_user_command("ToggleAutoFormat", toggle_autoformat, {})
vim.keymap.set("n", "<leader>=", auto_format, { desc = "format file" })

return {
    { "nvimtools/none-ls.nvim", config = true },
    {
        "jay-babu/mason-null-ls.nvim",
        version = "*",
        config = function()
            require("mason-null-ls").setup({
                handlers = {
                    function(source_name, methods)
                        require("mason-null-ls").default_setup(source_name, methods) -- to maintain default behavior
                    end,
                },
            })
        end,
    },
}
