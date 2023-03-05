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

local neotest_icons = {
    expanded = "",
    child_prefix = "",
    child_indent = "",
    final_child_prefix = "",
    non_collapsible = "",
    collapsed = "",

    running = "",
    passed = "",
    failed = "",
    skipped = "",
    unknown = "",
}
