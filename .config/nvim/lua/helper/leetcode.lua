local M = {}
local api = vim.api
local fn = vim.fn
local keymap = vim.keymap.set
local Job = require("plenary.job")

local log_levels = vim.log.levels
local notify_opts = { title = "Leetcode" }

local defaults = {
    leetcode_china = false,
    leetcode_bin = "leetcode",
    pattern = "*.*.leetcode.py",
    mappings = {
        test = "<leader>lt",
        submit = "<leader>ls",
    },
}

M.get_list = function()
    local problem_list_raw = {}
    local problem_tbl = {}
    Job:new({
        command = defaults.leetcode_bin,
        args = { "list" },
        -- TODO
        -- on_stdout = function()
        --
        -- end,
        on_exit = function(j, _)
            local result = table.concat(j:result(), "\n")
            if string.match(result, "error") then
                vim.notify(result, log_levels.ERROR, notify_opts)
                return
            end

            problem_list_raw = j:result()
        end,
    }):sync()

    for i, line in pairs(problem_list_raw) do
        local item = {}

        local done = string.match(line, "✔") ~= nil and true or false
        local lock = string.match(line, "🔒") ~= nil and true or false
        local no = tonumber(string.match(line, "(%d+)")) -- first match number
        local title, diffculty, pass_rate = string.match(line, "]%s(.*)[%s]+(%a+)[%s]+(%b())$")

        title = vim.trim(title)
        pass_rate = tonumber(string.sub(pass_rate, 2, 6))

        -- print(no, title, diffculty, pass_rate)
        item = {
            line = line,

            done = done,
            lock = lock,
            no = no,
            title = title,
            diffculty = diffculty,
            pass_rate = pass_rate,
        }
        -- table.insert(problem_tbl, i, item)
        problem_tbl[i] = item
    end
    return problem_tbl
end

M.edit = function(no)
    -- TODO
end

local function test_submit_cb(j, _)
    local result = table.concat(j:result(), "\n")
    if string.match(result, "error:") then
        vim.notify(result, log_levels.ERROR, notify_opts)
    else
        vim.notify(result, log_levels.INFO, notify_opts)
    end
end

M.test = function(no)
    Job:new({
        command = defaults.leetcode_bin,
        args = { "test", no },
        on_exit = test_submit_cb,
    }):sync()
end

-- 提交
M.submit = function(no)
    Job:new({
        command = defaults.leetcode_bin,
        args = { "exec", no },
        on_exit = test_submit_cb,
    }):sync()
end

-- 问题
M.pick = function(no)
    local result
    Job:new({
        command = defaults.leetcode_bin,
        args = { "pick", no },
        on_exit = function(j, _)
            result = table.concat(j:result(), "\n")
            if string.match(result, "NotFound") then
                vim.notify(result, log_levels.ERROR, notify_opts)
                return
            end
        end,
    }):sync()
    return result
end

M.update_db = function()
    local function job_sed(a, b)
        local s = ("s/%s/%s/g"):format(a, b)
        local fpath = fn.expand("~/.leetcode/leetcode.toml")
        Job:new({
            command = "sed",
            args = { "-i", s, fpath },
        }):sync()
    end

    local job_update = Job:new({
        command = defaults.leetcode_bin,
        args = { "data", "--update" },
        on_exit = function(j, _)
            local output = table.concat(j:result(), "\n")
            if string.match(output, "json from response, parse failed") then
                vim.notify(output, log_levels.ERROR, notify_opts)
            else
                vim.notify(output, log_levels.INFO, notify_opts)
            end
        end,
    })

    -- confirm changed to leetcode.com
    job_sed("cn", "com")
    job_update:sync(1000 * 10)
    if defaults.leetcode_china then
        job_sed("com", "cn")
    end
end
-- M.update_db()

--------------------------------------------------------------------------------

-- keymap("n", cfg.mappings.list, function()
-- 	local ls = M.get_list()
-- 	vim.ui.select(ls, {
-- 		format_item = function(item)
-- 			-- return item.line
-- 			return string.format("%s %s %s", item.no, string.sub(item.diffculty, 1, 1), item.title)
-- 		end,
-- 	}, function(item)
-- 		if item == nil then
-- 			return
-- 		end
-- 	end)
-- end, {})

local function get_no()
    return string.match(fn.expand("%:t"), "[%d]+")
end

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = defaults.pattern,
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        keymap("n", defaults.mappings.submit, function()
            M.submit(get_no())
        end, { buffer = bufnr, desc = "Leetcode submit" })
        keymap("n", defaults.mappings.test, function()
            M.test(get_no())
        end, { buffer = bufnr, desc = "Leetcode test" })
    end,
})

--------------------------------------------------------------------------------
M.setup = function(opts)
    opts = opts or {}
    defaults = vim.tbl_deep_extend("force", defaults, opts)
end

return M
