local create_cmd = vim.api.nvim_create_user_command

-- vim.g.autoformat_enabled = true
-- vim.b.autoformat_enabled = true

create_cmd("BufDisableAutoFormat", function()
    vim.b.autoformat_enabled = false
end, {})
create_cmd("BufEnableAutoFormat", function()
    vim.b.autoformat_enabled = true
end, {})

create_cmd("DisableAutoFormat", function()
    vim.g.autoformat_enabled = false
end, {})
create_cmd("EnableAutoFormat", function()
    vim.g.autoformat_enabled = true
end, {})

create_cmd("Format", ":lua require('conform').format()", { desc = "Format with conform" })

-- vim.api.nvim_create_autocmd({ "BufRead" }, {
--     pattern = "xmake.lua",
--     command = "BufDisableAutoFormat",
-- })

---@type LazySpec
return {
    "stevearc/conform.nvim",
    version = "*",
    opts = {
        formatters_by_ft = {
            ["_"] = { "trim_whitespace", "trim_newlines" },
        },
        format_on_save = function(bufnr)
            if vim.bo.readonly then
                return
            end

            if vim.b.autoformat_enabled == true then
                return true
            end
            if vim.b.autoformat_enabled == false then
                return false
            end

            if vim.g.autoformat_enabled == true then
                return true
            end
            if vim.g.autoformat_enabled == false then
                return false
            end

            return { timeout_ms = 500, lsp_fallback = false }
        end,
    },
}
