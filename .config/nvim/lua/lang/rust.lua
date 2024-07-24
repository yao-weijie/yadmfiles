_G.LangSetup({
    filetypes = { "rust" },
    conform = {
        formatter = { "rustfmt" },
    },
    dap = {
        type = "codelldb_rust",
        adapter = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        },
        configurations = {
            {
                type = "codelldb_rust",
                name = "LLDB: Launch file",
                request = "launch",
                -- 编译输出目录在 cwd/build/,和asynctask中定义的一致
                program = "${workspaceFolder}/build/${fileBasenameNoExtension}",
                console = "integratedTerminal",
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                runInTerminal = true,
            },
        },
    },
})

return {}
