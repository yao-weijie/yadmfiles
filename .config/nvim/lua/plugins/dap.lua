-- dap signs
local dap_signs = {
    DapBreakpoint = {
        text = "🔴",
        texthl = "",
        linehl = "",
        numhl = "",
    },
    DapBreakpointRejected = {
        text = "",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
    },
    DapStopped = {
        text = "➜ ",
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
    },
}
for name, val in pairs(dap_signs) do
    vim.fn.sign_define(name, val)
end

local dapui_opts = {
    controls = {
        element = "scopes",
        -- element = "console",
        -- element = "repl",
    },
    mappings = {
        expand = { "o", "<2-LeftMouse>", "<CR>" },
        open = "O",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    force_buffers = true,
    layouts = {
        {
            elements = {
                -- Can be float or integer > 1
                -- 从下往上排列的
                { id = "stacks", size = 0.4 },
                { id = "watches", size = 0.3 },
                { id = "breakpoints", size = 0.3 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "scopes", size = 0.5 },
                { id = "console", size = 0.5 },
                -- { id = "repl", size = 0.2 },
            },
            size = 15,
            position = "bottom",
        },
    },
    render = {
        indent = 2,
    },
}

return {
    {
        "rcarriga/nvim-dap-ui",
        version = "*",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup(dapui_opts)

            ---@param session Session
            local debug_open = function(session)
                dapui.open()
                vim.keymap.set("n", "<leader><Down>", "<cmd>DapContinue<CR>", {})
                vim.keymap.set("n", "<Down>", "<cmd>DapStepOver<CR>", {})
                vim.keymap.set("n", "<Right>", "<cmd>DapStepInto<CR>", {})
                vim.keymap.set("n", "<Left>", "<cmd>DapStepOut<CR>", {})
                vim.keymap.set("n", "<Up>", "<cmd>DapTerminate<CR>", {})
            end
            ---@param session Session
            local debug_close = function(session)
                local windows = require("dapui.windows")
                if windows.layouts[1] and windows.layouts[1]:is_open() then
                    dapui.close()
                    vim.keymap.del("n", "<leader><Down>", {})
                    vim.keymap.del("n", "<Down>", {})
                    vim.keymap.del("n", "<Right>", {})
                    vim.keymap.del("n", "<Left>", {})
                    vim.keymap.del("n", "<Up>", {})
                end
                if session.config.type == "codelldb" then
                    vim.cmd("buffer")
                    session:close()
                end
            end

            dap.listeners.after.event_initialized["dapui_config"] = debug_open
            dap.listeners.before.event_terminated["dapui_config"] = debug_close
            dap.listeners.before.event_exited["dapui_config"] = debug_close
            dap.listeners.before.disconnect["dapui_config"] = debug_close
        end,
    },
    {

        "mfussenegger/nvim-dap",
        version = "*",
        dependencies = {
            { "thehamsta/nvim-dap-virtual-text", config = true },
            { "weissle/persistent-breakpoints.nvim", opts = { load_breakpoints_event = { "BufReadPost" } } },
        },
        lazy = false,
        keys = {
            { "<F8>", "<cmd>DapContinue<CR>", desc = "start debug" },
            -- Shift-F8
            { "<F20>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
            { "<S-F8>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
        },
    },
}
