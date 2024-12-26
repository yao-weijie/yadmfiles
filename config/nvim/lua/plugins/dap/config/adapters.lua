return {
    ---https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
    python = {
        type = "executable",
        command = "python3",
        args = {
            "-m",
            "debugpy.adapter",
        },
    },
    ---https://github.com/vadimcn/codelldb/blob/master/MANUAL.md#parameterized-launch-configurations
    codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
        },
    },
}
