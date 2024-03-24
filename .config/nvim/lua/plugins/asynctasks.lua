return {
    "skywind3000/asynctasks.vim",
    event = { "VimEnter" },
    dependencies = {
        "akinsho/toggleterm.nvim",
        {
            "skywind3000/asyncrun.vim",
            version = "*",
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
        -- ~/.config/nvim/autoload/asyncrun/runner/toggleterm3.vim
        vim.g.asynctasks_term_pos = "toggleterm3"
        vim.g.asynctasks_term_reuse = 1
        vim.g.asynctasks_term_close = 1
        vim.g.asynctasks_term_focus = 1
        vim.g.asynctasks_term_rows = 10
        vim.g.asynctasks_term_cols = 50
        vim.g.asynctasks_profile = "debug"
        vim.g.asynctasks_template = {
            generic = _G.pathlib.readfile("~/.config/nvim/templates/tasks/generic.ini"),
            openwrt = _G.pathlib.readfile("~/.config/nvim/templates/tasks/openwrt.ini"),
        }
        vim.api.nvim_create_user_command("AsyncTaskSelect", require("helper.asynctask").ui_select, {})

        require("helper.asynctask").toggleterm_setup({
            mapping = "\\",
            start_in_insert = false,
            float_opts = {
                width = function(_term)
                    local width = math.ceil(vim.o.columns / 2)
                    _term.float_opts.col = width
                    return width
                end,
                height = function(_term)
                    local height = math.ceil(vim.o.lines / 2)
                    _term.float_opts.row = height
                    return height
                end,
            },
        })
        vim.keymap.set("n", "<C-b>", "<cmd>lua require('helper.asynctask').fzf_select()<CR>", {})
        -- { "<leader>fa", "<cmd>lua require('helper.asynctask').fzf_select()<CR>", desc = "asynctask" },
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
}
