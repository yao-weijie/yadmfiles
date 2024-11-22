return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
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
    },
    config = function(_, opts)
        local neotest = require("neotest")
        neotest.setup(opts)
        -- stylua: ignore start
        local create_cmd = vim.api.nvim_create_user_command
        create_cmd("NeotestNearest",       function() neotest.run.run({}) end,                      {})
        create_cmd("NeotestNearestDebug",  function() neotest.run.run({ strategy = "dap" }) end,    {})
        create_cmd("NeotestCurrentFile",   function() neotest.run.run(vim.fn.expand("%")) end,      {})
        create_cmd("NeotestSummaryToggle", function() neotest.summary.toggle() end,                 {})
        create_cmd("NeotestFailedNext",    function() neotest.jump.next({ status = "failed" }) end, {})
        create_cmd("NeotestFailedPrev",    function() neotest.jump.prev({ status = "failed" }) end, {})
        -- stylua: ignore end
        -- vim.cmd("autocmd FileType neotest-summary,neotest-output nnoremap <buffer> q:q<CR> ")
        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = { "neotest-summary", "neotest-output" },
            command = "nnoremap <buffer> q :q<CR>",
        })
    end,
    keys = {
        { "<F7>", "<cmd>NeotestCurrentFile<CR>", desc = "test current file" },
        { "<leader>tn", "<cmd>NeotestNearest<CR>", desc = "test nearest case" },
        { "<leader>tf", "<cmd>NeotestCurrentFile<CR>", desc = "test current file" },
        { "<leader>ts", "<cmd>NeotestSummaryToggle<CR>", desc = "toggle test summary" },
        { "<leader>t[", "<cmd>NeotestFailedPrev<CR>", desc = "previous failed case" },
        { "<leader>t]", "<cmd>NeotestFailedNext<CR>", desc = "next failed case" },
    },
}
