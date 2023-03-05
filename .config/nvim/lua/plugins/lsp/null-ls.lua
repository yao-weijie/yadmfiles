vim.api.nvim_create_user_command("LspFormat", function()
    local format_ignore = {
        -- "plugins.lua",
    }
    local fname = vim.fn.expand("%:p:t")
    if vim.tbl_contains(format_ignore, fname) then
        return
    end

    local async = false
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
        async = true
    end

    vim.lsp.buf.format({
        async = async,
        filter = function(client)
            return client.name == "null-ls"
        end,
    })
end, {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, { command = "LspFormat" })
vim.keymap.set("n", "<leader>=", "<cmd>LspFormat<CR>", { desc = "format file" })
