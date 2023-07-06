local dap_ft = "python,c,cpp,rust"

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
                        config.adapters = require("plugins.dap.adapters.python").adapters
                        config.configurations = require("plugins.dap.adapters.python").configurations
                        mason_dap.default_setup(config)
                    end,
                    codelldb = function(config)
                        config.configurations = require("plugins.dap.adapters.codelldb").configurations
                        mason_dap.default_setup(config)
                    end,
                },
            })
            vim.api.nvim_create_user_command("DapRunToCursor", require("dap").run_to_cursor, {})
        end,
    },
}
