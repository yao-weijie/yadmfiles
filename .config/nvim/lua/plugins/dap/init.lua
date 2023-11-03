local dap_ft = "python,c,cpp,rust"

return {
    {
        "weissle/persistent-breakpoints.nvim",
        event = { "bufreadpre" },
        config = function()
            require("persistent-breakpoints").setup({ load_breakpoints_event = { "bufreadpost" } })
            vim.api.nvim_create_autocmd({ "filetype" }, {
                pattern = dap_ft,
                callback = function(file)
                    local opts = { desc = "toggle breakpoint", buffer = file.buf }
                    vim.keymap.set("n", "<2-leftmouse>", "<cmd>PBToggleBreakpoint<cr>", opts)
                    vim.keymap.set("n", "<leader>b", "<cmd>PBToggleBreakpoint<cr>", opts)
                end,
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "jayp0521/mason-nvim-dap.nvim" },
            { "thehamsta/nvim-dap-virtual-text", config = true },
        },
        ft = vim.split(dap_ft, ",", {}),
        keys = {
            { "<F8>", "<cmd>DapContinue<CR>", desc = "start debug" },
            -- Shift-F8
            { "<F20>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
            { "<S-F8>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
        },
        config = function()
            local mason_dap = require("mason-nvim-dap")
            local conf_root = "plugins/dap/adapters/"
            mason_dap.setup({
                automatic_setup = true,
                handlers = {
                    function(config)
                        mason_dap.default_setup(config)
                    end,
                    python = function(config)
                        config.adapters = require(conf_root .. "python").adapters
                        config.configurations = require(conf_root .. "python").configurations

                        mason_dap.default_setup(config)
                    end,
                    codelldb = function(config)
                        config.configurations = require(conf_root .. "codelldb").configurations
                        mason_dap.default_setup(config)
                    end,
                },
            })
            vim.api.nvim_create_user_command("DapRunToCursor", require("dap").run_to_cursor, {})
        end,
    },
}
