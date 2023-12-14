return {
    "skywind3000/asynctasks.vim",
    dependencies = {
        "akinsho/toggleterm.nvim",
        {
            "skywind3000/asyncrun.vim",
            cmd = { "AsyncRun" },
            config = function() --
                -- asyncrun
                vim.g.asyncrun_save = 2
                vim.g.asyncrun_open = 10
                vim.g.asyncrun_rootmarks = vim.g.ROOT_MARKERS
            end,
        },
    },
    config = function()
        -- asynctask
        -- quickfix, terminal
        vim.g.asynctasks_term_pos = "toggleterm2"
        vim.g.asynctasks_term_reuse = 1
        vim.g.asynctasks_term_close = 1
        vim.g.asynctasks_term_focus = 1
        vim.g.asynctasks_term_rows = 10
        vim.g.asynctasks_term_cols = 50
        vim.g.asynctasks_profile = "debug"
    end,
    keys = {
        { "<F5>", "<cmd>AsyncTask file-run<CR>", desc = "file-run" },
        { "<F6>", "<cmd>AsyncTask file-build<CR>", desc = "file-build" },
        -- <S-F5> && <S-F6> in terminal
        { "<F17>", "<cmd>AsyncTask project-run<CR>", desc = "project-run" },
        { "<F18>", "<cmd>AsyncTask project-build<CR>", desc = "project-build" },
        -- if has gui_running
        { "<S-F5>", "<cmd>AsyncTask project-run<CR>", desc = "project-run" },
        { "<S-F6>", "<cmd>AsyncTask project-build<CR>", desc = "project-build" },
    },
    cmd = { "AsyncTask" },
}
