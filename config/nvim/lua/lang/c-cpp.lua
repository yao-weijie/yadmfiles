-- require('dap').adapters['lldb-cxx'] = {}
-- local dap_configurations_cpp = {}
-- require("dap").configurations.cpp = dap_configurations_cpp
-- require("dap").configurations.c = dap_configurations_cpp

---@type LazySpec
return {
    {
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp" },
        opts = {},
    },
    {
        "Civitasv/cmake-tools.nvim",
        ft = { "cmake" },
    },
    {
        "sakhnik/nvim-gdb",
    },
    {
        "mfussenegger/nvim-dap",
        opts = {
            adapters = {
                codelldb = {
                    type = "server",
                    port = "${port}",
                    executable = {
                        command = vim.fn.executable("lldb") == 1 and "lldb" or "codelldb",
                        args = { "--port", "${port}" },
                    },
                },
            },
            configurations = {
                cpp = {
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
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                neocmake = {},
                clangd = {
                    cmd = {
                        "clangd",

                        -- 读取项目本地.clangd 配置文件,或者~/.config/clangd/config.yaml
                        "--enable-config",

                        -- 同时开启的任务数量
                        "-j=8",
                        -- 在后台自动分析文件（基于complie_commands)
                        "--background-index",
                        -- 标记compelie_commands.json文件的目录位置
                        -- 补全依赖这个json文件,否则不能补全
                        "--compile-commands-dir=.vscode",
                        -- pch优化的位置disk/memory
                        "--pch-storage=disk",

                        -- 开启clang-tidy, enable disgnostic
                        "--clang-tidy",

                        -- iwyu: include what you use; never: never auto insert
                        "--header-insertion=iwyu",
                        -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
                        "--header-insertion-decorators=true",
                        -- detailed: 更详细的补全内容; bundled: 合并相似条目
                        "--completion-style=bundled",
                        "--all-scopes-completion=true",
                        "--function-arg-placeholders",
                    },
                    on_attach = function(client, bufnr)
                        -- require("clangd_extensions.inlay_hints").setup_autocmd()
                        -- require("clangd_extensions.inlay_hints").set_inlay_hints()
                    end,
                    settings = {
                        clangd = {
                            InlayHints = {
                                Designators = true,
                                Enabled = true,
                                ParameterNames = true,
                                DeducedTypes = true,
                            },
                            fallbackFlags = { "-std=c++17" },
                        },
                    },
                },
            },
        },
    },
}
