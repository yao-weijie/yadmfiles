---@type table<string, conform.FiletypeFormatter>
return {
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
}
