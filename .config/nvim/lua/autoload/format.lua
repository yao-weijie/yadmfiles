local function auto_format()
    if vim.fn.filewritable(vim.fn.expand("%")) == 0 then
        return vim.notify("File not writable!")
    end

    local async = false
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    -- 大于100KB 或者大于1k 行, 异步格式化
    if ok and stats and (stats.size > max_filesize or vim.fn.line("$") > 1000) then
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
