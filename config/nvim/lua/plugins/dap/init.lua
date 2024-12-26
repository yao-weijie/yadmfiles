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

---@type LazySpec
return {
    { import = "plugins.dap" },
}
