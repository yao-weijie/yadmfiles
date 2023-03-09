local dap_ft = "python,c,cpp"

return {
    {
        "Weissle/persistent-breakpoints.nvim",
        ft = vim.split(dap_ft, ","),
        keys = {
            { "<leader>b" },
            { "<2-LeftMouse>" },
        },
        config = function()
            require("persistent-breakpoints").setup({ load_breakpoints_event = { "BufReadPost" } })
            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = dap_ft,
                callback = function()
                    local opts = { desc = "toggle breakpont", buffer = true }
                    vim.keymap.set("n", "<leader>b", "<cmd>PBToggleBreakpoint<CR>", opts)
                    vim.keymap.set("n", "<2-LeftMouse>", "<cmd>PBToggleBreakpoint<CR>", opts)
                end,
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text", config = true },
            require("plugins.dap.dap-ui"),
        },
        ft = vim.split(dap_ft, ","),
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
