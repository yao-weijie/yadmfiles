local dap_ft = "python,c,cpp,rust"
local debugpy_adapter = {
    type = "executable",
    command = "python3",
    args = {
        "-m",
        "debugpy.adapter",
    },
}
local debugpy_tasks = {
    {
        type = "python",
        name = "Python: Launch file",
        request = "launch",
        program = "${file}",
        console = "integratedTerminal",
    },
}

-- by default support c,cpp,rust
local lldb_tasks = {
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
}

return {
    { "theHamsta/nvim-dap-virtual-text", ft = vim.split(dap_ft, ",", {}), config = true },
    {
        "Weissle/persistent-breakpoints.nvim",
        event = { "BufReadPre" },
        config = function()
            require("persistent-breakpoints").setup({ load_breakpoints_event = { "BufReadPost" } })
            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = dap_ft,
                callback = function(file)
                    local opts = { desc = "toggle breakpoint", buffer = file.buf }
                    vim.keymap.set("n", "<2-LeftMouse>", "<cmd>PBToggleBreakpoint<CR>", opts)
                    vim.keymap.set("n", "<leader>b", "<cmd>PBToggleBreakpoint<CR>", opts)
                end,
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "jayp0521/mason-nvim-dap.nvim" },
        },
        ft = vim.split(dap_ft, ",", {}),
        keys = {
            { "<F8>", "<cmd>DapContinue<CR>", desc = "start debug" },
            -- Shift-F8
            { "<F20>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
        },
        config = function()
            local mason_dap = require("mason-nvim-dap")
            mason_dap.setup({
                automatic_setup = true,
                handlers = {
                    function(config)
                        mason_dap.default_setup(config)
                    end,
                    python = function(config)
                        -- 需要通过DapInstall python
                        -- 但实际上并不用mason 安装的debugpy, 而是各个环境安装的debugpy
                        config.adapters = debugpy_adapter
                        config.configurations = debugpy_tasks
                        mason_dap.default_setup(config)
                    end,
                    codelldb = function(config)
                        -- config.adapters = lldb_adapter
                        config.configurations = lldb_tasks
                        mason_dap.default_setup(config)
                    end,
                },
            })
        end,
    },
}
