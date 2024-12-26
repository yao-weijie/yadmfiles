-- builtin configs
local configs = {}

configs.python = {
    {
        type = "python",
        name = "Python: Launch file",
        request = "launch",
        program = "${file}",
    },
}

vim.g.dap_cpp_exec_filter = nil
vim.g.dap_cpp_exec_dir = "build"
local cxx_configs = {
    {
        type = "codelldb",
        name = "LLDB: Launch file",
        request = "launch",
        program = function()
            return require("dap.utils").pick_file({
                filter = vim.g.dap_cpp_exec_filter,
                path = vim.g.dap_cpp_exec_dir,
            })
        end,
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        stopOnEntry = false, -- stop on main()
        runInTerminal = true,
    },
    -- {
    --     type = "codelldb",
    --     name = "LLDB: Attach",
    --     request = "attach",
    -- },
}
configs.cpp = cxx_configs
configs.c = cxx_configs

return configs
