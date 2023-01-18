local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
    vim.notify("dapui not found")
    return
end

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
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
            -- You can change the order of elements in the sidebar
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                -- Can be float or integer > 1
                -- layout from bottom to top
                { id = "stacks", size = 0.3 },
                { id = "breakpoints", size = 0.3 },
                { id = "watches", size = 0.3 },
            },
            size = 40,
            position = "left", -- Can be "left", "right", "top", "bottom"
        },
        {
            elements = {
                -- layout from left to right
                { id = "scopes", size = 0.4 },
                { id = "console", size = 0.4 },
                { id = "repl", size = 0.2 },
            },
            size = 15,
            position = "bottom", -- Can be "left", "right", "top", "bottom"
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
})
