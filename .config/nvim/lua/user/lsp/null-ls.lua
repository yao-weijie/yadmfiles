local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    vim.notify("null_ls not found")
    return
end

-- sources added in lua/user/lang/*.lua
null_ls.setup({})
require("mason-null-ls").setup({})

vim.api.nvim_create_user_command("LspFormat", function()
    local format_ignore = {
        -- "plugins.lua",
    }
    local fname = vim.fn.expand("%:p:t")
    if vim.tbl_contains(format_ignore, fname) then
        return
    end

    vim.lsp.buf.format({
        -- 加上这个好像下面自动格式化会有点问题
        -- async = true,
        filter = function(client)
            return client.name == "null-ls"
        end,
    })
end, {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    command = "LspFormat",
})

require("which-key").register({
    ["<leader>="] = { "<cmd>LspFormat<CR>", "format file" },
}, {})
