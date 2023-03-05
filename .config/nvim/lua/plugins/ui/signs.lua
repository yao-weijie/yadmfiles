local dap_signs = {
    DapBreakpoint = {
        text = "🔴",
        texthl = "",
        linehl = "",
        numhl = "",
    },
    DapBreakpointRejected = {
        text = "",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
    },
    DapStopped = {
        text = "➜ ",
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
    },
}
for name, val in pairs(dap_signs) do
    vim.fn.sign_define(name, val)
end

local git_signs = {
    add = { text = "│", hl = "GitSignsAdd", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { text = "│", hl = "GitSignsChange", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { text = "_", hl = "GitSignsDelete", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { text = "‾", hl = "GitSignsDelete", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { text = "~", hl = "GitSignsChange", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
}
for name, val in pairs(git_signs) do
    vim.fn.sign_define(name, val)
end

local diagnostic_signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local diagnostic_config = {
    virtual_text = true,
    signs = {
        active = diagnostic_signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(diagnostic_config)
