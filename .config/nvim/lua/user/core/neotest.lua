local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
    vim.notify("neotest not found!")
    return
end

neotest.setup({
    icons = {
        expanded = "",
        child_prefix = "",
        child_indent = "",
        final_child_prefix = "",
        non_collapsible = "",
        collapsed = "",

        running = "",
        passed = "",
        failed = "",
        skipped = "",
        unknown = "",
    },
})

-- stylua: ignore start
local create_cmd = vim.api.nvim_create_user_command
create_cmd("NeotestNearest",       function() neotest.run.run({}) end,                      {})
create_cmd("DebugNeotestNearest",  function() neotest.run.run({ strategy = "dap" }) end,    {})
create_cmd("NeotestCurrentFile",   function() neotest.run.run(vim.fn.expand("%")) end,      {})
create_cmd("NeotestSummaryToggle", function() neotest.summary.toggle() end,                 {})
create_cmd("NeotestFailedNext",    function() neotest.jump.next({ status = "failed" }) end, {})
create_cmd("NeotestFailedPrev",    function() neotest.jump.prev({ status = "failed" }) end, {})
-- stylua: ignore end

require("which-key").register({
    ["<F7>"] = { "<cmd>NeotestCurrentFile<CR>", "test current file" },
    ["<leader>t"] = {
        name = "Noetest",
        n = { "<cmd>NeotestNearest<CR>", "test nearest case" },
        f = { "<cmd>NeotestCurrentFile<CR>", "test current file" },
        s = { "<cmd>NeotestSummaryToggle<CR>", "toggle test summary" },
        ["["] = { "<cmd>NeotestFailedPrev<CR>", "previous failed case" },
        ["]"] = { "<cmd>NeotestFailedNext<CR>", "next failed case" },
    },
}, {})

-- 文件名test_xxx.py
require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = "python",
        }),
    },
})
