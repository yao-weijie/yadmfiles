local function auto_format()
    if vim.fn.filewritable(vim.fn.expand("%")) == 0 then
        return vim.notify("File not writable!")
    end

    local async = false
    if require("helper.path").is_hugefile(0, "100k") or vim.fn.line("$") > 1000 then
        async = true
    end

    vim.lsp.buf.format({
        async = async,
        filter = function(client)
            return client.name == "null-ls"
        end,
    })
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        -- 大于1w 行禁用自动格式化
        if vim.fn.line("$") > 10000 then
            return
        end

        auto_format()
    end,
})
vim.api.nvim_create_user_command("LspFormat", auto_format, {})
vim.keymap.set("n", "<leader>=", auto_format, { desc = "format file" })

return {}
