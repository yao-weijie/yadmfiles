local opts = {
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

local dap_ft = "python,c,cpp,rust"
return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = vim.split(dap_ft, ",", {}),
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup(opts)

        local debug_open = function()
            dapui.open()
        end
        local debug_close = function()
            dapui.close()
        end

        dap.listeners.after.event_initialized["dapui_config"] = debug_open
        dap.listeners.before.event_terminated["dapui_config"] = debug_close
        dap.listeners.before.event_exited["dapui_config"] = debug_close
        dap.listeners.before.disconnect["dapui_config"] = debug_close
    end,
}
