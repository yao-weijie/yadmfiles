local create_cmd = vim.api.nvim_create_user_command

create_cmd("BufDistableAutoFormat", function()
    vim.b.autoformat_enabled = false
end, {})
create_cmd("BufEnableAutoFormat", function()
    vim.b.autoformat_enabled = true
end, {})

create_cmd("DistableAutoFormat", function()
    vim.g.autoformat_enabled = false
end, {})
create_cmd("EnableAutoFormat", function()
    vim.g.autoformat_enabled = true
end, {})

create_cmd("Format", ":lua require('conform').format()", { desc = "Format with conform" })

return {
    "stevearc/conform.nvim",
    version = "*",
    opts = {
        formatters_by_ft = {
            ["_"] = { "trim_whitespace", "trim_newlines" },
        },
        format_on_save = function(bufnr)
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
