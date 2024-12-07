-- - `${file}`: Active filename
-- - `${fileBasename}`: The current file's basename
-- - `${fileBasenameNoExtension}`: The current file's basename without extension
-- - `${fileDirname}`: The current file's dirname
-- - `${fileExtname}`: The current file's extension
-- - `${relativeFile}`: The current file relative to |getcwd()|
-- - `${relativeFileDirname}`: The current file's dirname relative to |getcwd()|
-- - `${workspaceFolder}`: The current working directory of Neovim
-- - `${workspaceFolderBasename}`: The name of the folder opened in Neovim
-- - `${command:pickProcess}`: Open dialog to pick process using |vim.ui.select|
-- - `${command:pickFile}`: Open dialog to pick file using |vim.ui.select|
-- - `${env:Name}`: Environment variable named `Name`, for example: `${env:HOME}`.

---@class DapConfig:dap.Configuration
---@field type string
---@field name string
---@field request "launch"|"attach"
---@field program? string|fun():string|dap.Abort
---@field console? "integratedTerminal"|"internalConsole"|"externalTerminal" default:integratedTerminal
---@field cwd? string
---@field env? table
---@field stopOnEntry? boolean

---@class debugpyConfig:DapConfig

---@class lldbConfig:DapConfig

return {
    ---@type debugpyConfig[]
    python = {
        {
            type = "debugpy",
            name = "Python: Launch file",
            request = "launch",
            program = "${file}",
        },
    },
    ---@type lldbConfig[]
    ["c,cpp"] = {
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
}
