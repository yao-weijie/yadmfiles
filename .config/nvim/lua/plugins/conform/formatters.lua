---@type table<string, conform.FormatterConfigOverride|fun(bufnr:integer):nil|conform.FormatterConfigOverride>
return {
    latexindent = {
        append_args = { "-g", "/dev/null" },
    },
    ruff_isort = {
        command = vim.fn.exepath("ruff"),
        args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME" },
    },
}
