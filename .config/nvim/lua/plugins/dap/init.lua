local dap_ft = "python,c,cpp"
return {
    {
        "Weissle/persistent-breakpoints.nvim",
        event = { "BufReadPost" },
        opts = { load_breakpoints_event = { "BufReadPost" } },
        keys = {
            { "<2-LeftMouse>", "<cmd>PBToggleBreakpoint<CR>", desc = "toggle breakpont" },
            { "<leader>b", "<cmd>PBToggleBreakpoint<CR>", desc = "toggle breakpont" },
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text", config = true },
            require("plugins.dap.dap-ui"),
        },
        ft = vim.split(dap_ft, ""),
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
            require("plugins.dap.adapters")
        end,
    },
}
