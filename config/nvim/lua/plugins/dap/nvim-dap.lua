---@type LazySpec
return {
    "mfussenegger/nvim-dap",
    -- version = "*",
    dependencies = {
        { "thehamsta/nvim-dap-virtual-text", config = true },
        { "weissle/persistent-breakpoints.nvim", opts = { load_breakpoints_event = { "BufReadPost" } } },
    },
    lazy = false,
    -- event = { "VeryLazy" },
    config = function()
        require("dap").adapters = require("plugins.dap.config.adapters")
        for ft, ft_config in pairs(require("plugins.dap.config.configurations")) do
            require("dap").configurations[ft] = ft_config
        end
        require("dap.ext.vscode").load_launchjs(".vscode/launch.json", {
            python = { "python" },
            codelldb = { "c", "cpp", "rust" },
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "python", "c", "cpp" },
            callback = function(event)
                local opt = { buffer = event.buf }
                vim.keymap.set("n", "<leader>b", require("persistent-breakpoints.api").toggle_breakpoint, opt)
                vim.keymap.set("n", "<2-LeftMouse>", require("persistent-breakpoints.api").toggle_breakpoint, opt)
                vim.api.nvim_buf_create_user_command(event.buf, "DapRunToCursor", require("dap").run_to_cursor, {})
            end,
        })
    end,
    keys = {
        { "<F8>", "<cmd>DapContinue<CR>", desc = "start debug" },
        -- Shift-F8
        { "<F20>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
        { "<S-F8>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
    },
}
