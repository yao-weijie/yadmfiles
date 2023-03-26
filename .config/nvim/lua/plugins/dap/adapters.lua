local dap = require("dap")

-- load tasks
require("dap.ext.vscode").load_launchjs(
    -- file path tbl
    ".vscode/launch.json",
    -- nil,
    {
        python = { "python" },
        codelldb = { "c", "cpp" },
    }
)

--------------------------------------------------------------------------------
dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Python: Launch file",
        program = "${file}",
        console = "integratedTerminal",
    },
}

--------------------------------------------------------------------------------
-- debug编译型语言, 编译参数必须设置成debug模式,如果release模式会闪退
-- 参考asynctask的设置
dap.adapters.lldb = {
    type = "excutable",
    command = "lldb",
    name = "lldb",
}
local lldb = {
    {
        type = "codelldb",
        name = "LLDB: Launch",
        request = "launch",
        -- 编译输出目录在 cwd/build/,和asynctask中定义的一致
        program = "${workspaceFolder}/build/${fileBasenameNoExtension}",
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
    },
}
-- c,cpp简单测试过可用
dap.configurations.c = lldb -- c 好像看不到输出
dap.configurations.cpp = lldb
dap.configurations.rust = lldb
--------------------------------------------------------------------------------
return {}
