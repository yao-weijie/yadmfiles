local opts = {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        expand = { "o", "<2-LeftMouse>", "<CR>" },
        open = "O",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    layouts = {
        {
            elements = {
                -- Can be float or integer > 1
                { id = "stacks", size = 0.3 },
                { id = "breakpoints", size = 0.3 },
                { id = "watches", size = 0.3 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "scopes", size = 0.4 },
                { id = "console", size = 0.4 },
                { id = "repl", size = 0.2 },
            },
            size = 15,
            position = "bottom",
        },
    },
    controls = {
        element = "scopes",
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 2 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    },
}

return {
    "rcarriga/nvim-dap-ui",
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup(opts)

        local debug_open = function()
            dapui.open({})
        end
        local debug_close = function()
            dap.repl.close()
            dapui.close({})
        end

        dap.listeners.after.event_initialized["dapui_config"] = debug_open
        dap.listeners.before.event_terminated["dapui_config"] = debug_close
        dap.listeners.before.event_exited["dapui_config"] = debug_close
        dap.listeners.before.disconnect["dapui_config"] = debug_close
    end,
}
