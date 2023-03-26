local dap_ft = "python,c,cpp,rust"
return {
    {
        "rcarriga/cmp-dap",
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
        },
        config = function()
            -- dap signs defined in plugins/ui/signs
            require("mason-nvim-dap").setup_handlers({
                function(source_name)
                    require("mason-nvim-dap.automatic_setup")(source_name)
                end,
            })
        end,
    },
}
