local M = {}

M.adapters = {
    type = "executable",
    command = "python3",
    args = {
        "-m",
        "debugpy.adapter",
    },
}
M.configurations = {
    {
        type = "python",
        name = "Python: Launch file",
        request = "launch",
        program = "${file}",
        console = "integratedTerminal",
    },
}

return M
