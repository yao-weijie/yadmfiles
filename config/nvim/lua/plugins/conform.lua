-- vim:foldmethod=marker:
local create_cmd = vim.api.nvim_create_user_command

vim.g.autoformat = true

create_cmd("BufDisableAutoFormat", function()
    vim.b.autoformat = false
end, {})
create_cmd("BufEnableAutoFormat", function()
    vim.b.autoformat = true
end, {})

create_cmd("DisableAutoFormat", function()
    vim.g.autoformat = false
end, {})
create_cmd("EnableAutoFormat", function()
    vim.g.autoformat = true
end, {})

---@type LazySpec
return {
    "stevearc/conform.nvim",
    version = "*",
    opts = {
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr:integer):nil|conform.FormatterConfigOverride>
        formatters = { --{{{
            latexindent = {
                append_args = { "-g", "/dev/null" },
            },
            ruff_isort = {
                command = vim.fn.exepath("ruff"),
                args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME" },
            },
        }, --}}}
        ---@type table<string, conform.FiletypeFormatter>
        formatters_by_ft = { --{{{
            ["_"] = { "trim_whitespace", "trim_newlines" },
            python = { "ruff_isort", "ruff_format" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            lua = { "stylua" },
            rust = { "rustfmt" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            tex = { "latexindent" },
            json5 = { "fixjson" },
            json = { "fixjson" },
            -- prettierd
            markdown = { "prettierd" },
            yaml = { "prettierd" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            jsx = { "prettierd" },
            vue = { "prettierd" },
            html = { "prettierd" },
            css = { "prettierd" },
        }, --}}}
        format_on_save = function(bufnr)
            if
                vim.bo.readonly --
                or vim.b.autoformat == false
                or vim.g.autoformat == false
            then
                return
            end

            local cbopts = { timeout_ms = 500, lsp_fallback = false }
            if _G.pathlib.is_hugefile("1m", bufnr) or vim.fn.line("$") > 1000 then
                cbopts.timeout_ms = 2000
            end

            return cbopts
        end,
    },
    config = function(_, opts)
        require("conform").setup(opts)
        create_cmd("Format", require("conform").format, { desc = "Format with conform" })
    end,
}
