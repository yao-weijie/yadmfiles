_G.LangSetup({
    filetypes = { "c", "cpp" },
    conform = {
        formatter = { "clang_format" },
    },
    dap = {
        type = "codelldb",
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
                type = "codelldb",
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
require("Comment.ft").set("dts", { "// %s", "/* %s */" })
-- vim.opt.expandtab = false
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "dts",
    command = "setlocal noexpandtab",
})

return {}
