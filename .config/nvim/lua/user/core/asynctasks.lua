-- asyncrun
-- 全局设置，运行前是否保存文件，1是保存当前文件，2是保存所有修改过的文件
vim.g.asyncrun_save = 2
vim.g.asyncrun_mode = "quickfix"
vim.g.asyncrun_open = 10
vim.g.asyncrun_pos = "bottom"
vim.g.asyncrun_rootmarks = vim.g.ROOT_MARKERS

-- asynctask
-- quickfix, terminal
vim.g.asynctasks_mode = "quickfix"
vim.g.asynctasks_term_pos = "bottom"
vim.g.asynctasks_term_reuse = 1
vim.g.asynctasks_term_rows = 10
vim.g.asynctasks_term_cols = 50
vim.g.asynctasks_profile = "debug"

vim.api.nvim_create_user_command("AsyncTaskUI", function()
    local tasks = vim.call("asynctasks#list", "")

    if vim.tbl_isempty(tasks) then
        vim.notify("No task found!")
        return
    end

    vim.ui.select(tasks, {
        format_item = function(task)
            return string.format("<%s> <%s>: %s", task.scope, task.name, task.command)
        end,
    }, function(task)
        if task == nil then
            return
        end

        local cmd = "AsyncTask " .. task.name
        vim.cmd(cmd)
    end)
end, {})

require("which-key").register({
    ["<F5>"] = { "<cmd>AsyncTask file-run<CR>", "file-run" },
    ["<F6>"] = { "<cmd>AsyncTask file-build<CR>", "file-build" },
    -- <S-F5> && <S-F6>
    ["<F17>"] = { "<cmd>AsyncTask project-run<CR>", "project-run" },
    ["<F18>"] = { "<cmd>AsyncTask project-build<CR>", "project-build" },
}, {})
