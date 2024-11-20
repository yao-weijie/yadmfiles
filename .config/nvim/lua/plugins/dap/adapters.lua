local M = {}

---https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
---@type ExecutableAdapter
M.debugpy = {
    type = "executable",
    command = "python3",
    args = {
        "-m",
        "debugpy.adapter",
    },
    -- type = "executable",
    -- command = vim.fn.exepath("debugpy-adapter"),
}

---@source https://github.com/vadimcn/codelldb/blob/master/MANUAL.md#parameterized-launch-configurations
---@type ServerAdapter
M.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

return M
