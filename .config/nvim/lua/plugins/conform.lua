local create_cmd = vim.api.nvim_create_user_command

vim.g.autoformat_enabled = true

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

---@type LazySpec
return {
    "stevearc/conform.nvim",
    version = "*",
    opts = {
        formatters_by_ft = {
            ["_"] = { "trim_whitespace", "trim_newlines" },
        },
        format_on_save = function(bufnr)
            if
                vim.bo.readonly --
                or vim.b.autoformat_enabled == false
                or vim.g.autoformat_enabled == false
            then
                return
            end

            return { timeout_ms = 500, lsp_fallback = false }
        end,
    },
    config = function(_, opts)
        require("conform").setup(opts)
        create_cmd("Format", require("conform").format, { desc = "Format with conform" })
    end,
}
