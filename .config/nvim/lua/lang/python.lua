_G.LangSetup({
    filetypes = { "python" },
    conform = {
        formatter = { "ruff_format" },
    },
    dap = {
        type = "debugpy",
        adapter = {
            type = "executable",
            command = "python3",
            args = {
                "-m",
                "debugpy.adapter",
            },
        },
        configurations = {
            {
                type = "debugpy",
                name = "Python: Launch file",
                request = "launch",
                program = "${file}",
                console = "integratedTerminal",
            },
        },
    },
})

return {}
