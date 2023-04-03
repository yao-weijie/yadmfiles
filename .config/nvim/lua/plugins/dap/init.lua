local dap_ft = "python,c,cpp,rust"
local python_tasks = {
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

return {
    {
        "rcarriga/cmp-dap",
        cond = vim.g.loaded_cmp,
        ft = { "dap-repl", "dapui_watches", "dapui_hover" },
        config = function()
            require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap", menu = "[Dap]" },
                },
            })
        end,
    },
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
            { "jayp0521/mason-nvim-dap.nvim", opts = { automatic_setup = true } },
        },
        ft = vim.split(dap_ft, ",", {}),
        keys = {
            { "<F8>", "<cmd>DapContinue<CR>", desc = "start debug" },
            -- Shift-F8
            { "<F20>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
        },
        config = function()
            local dap = require("dap")
            local builtin_adapters = require("mason-nvim-dap.mappings.adapters")
            local builtin_conf = require("mason-nvim-dap.mappings.configurations")

            require("mason-nvim-dap").setup_handlers({
                function(source_name)
                    require("mason-nvim-dap.automatic_setup")(source_name)
                end,
                python = function(source_name)
                    dap.adapters[source_name] = builtin_adapters[source_name]
                    dap.configurations.python = python_tasks
                end,
                codelldb = function(source_name)
                    dap.adapters[source_name] = builtin_adapters[source_name]
                    for _, ft in ipairs({ "c", "cpp", "rust" }) do
                        dap.configurations[ft] = lldb_tasks
                    end
                end,
            })
        end,
    },
}
