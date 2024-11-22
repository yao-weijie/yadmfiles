-- A task build tool, written in vim.
-- https://github.com/skywind3000/asynctasks.vim

local overseer = require("overseer")
local constants = require("overseer.constants")
local TAG = constants.TAG
local fn, uv = vim.fn, vim.uv

local sep = uv.os_uname().sysname == "Windows_NT" and "\\" or "/"

vim.g.overseer_asynctask_rootmarks = vim.g.overseer_asynctask_rootmarks or { ".git", ".root", ".svn", ".hg" }
vim.g.overseer_asynctasks_config_name = vim.g.overseer_asynctasks_config_name or "tasks.ini"
vim.g.overseer_asynctasks_rtp_config = vim.g.overseer_asynctasks_rtp_config or "tasks.ini"
vim.g.overseer_asynctasks_template = {}

---@type table<string, fun():string>
local MACROS = { -- {{{
    VIM_FILEPATH = function()
        return fn.expand("%:p")
    end,
    VIM_FILENAME = function()
        return fn.expand("%:t")
    end,
    VIM_FILEDIR = function()
        return fn.expand("%:h")
    end,
    VIM_FILEEXT = function()
        return fn.expand("%:e")
    end,
    VIM_FILENOEXT = function()
        return fn.expand("%:t:r")
    end,
    VIM_PATHNOEXT = function()
        return fn.expand("%:p:r")
    end,
    VIM_CWD = function()
        return uv.cwd()
    end,
    VIM_RELDIR = function()
        return fn.expand("%:h")
    end,
    VIM_RELNAME = function()
        local cwd = uv.cwd()
        local fpath = fn.expand("%:p")
        return fpath:sub(#cwd + 2)
    end,
    VIM_ROOT = function()
        local cwd = uv.cwd()
        local root = vim.fs.root(cwd, vim.g.overseer_asynctask_rootmarks)
        return root and root or cwd
    end,
    VIM_CWORD = function()
        return fn.expand("<cword>")
    end,
    VIM_CFILE = function()
        return fn.expand("<cfile>")
    end,
    --- extra macros
    VIM_ARCH = function()
        return uv.os_uname().machine
    end,
    VIM_SYSNAME = function()
        return uv.os_uname().sysname
    end,
}
-- }}}

---@class asynctask.group
---@field command table<string|number, string>
---@field default_command string?
---@field before_command string?
---@field cwd string?
---@field output string|'quickfix'|'terminal'?

local asynctask_keys = {
    "command",
    "cwd",
    "output",
    "pos",
    "errorformat",
    "save",
    "option",
    "focus",
    "close",
    "program",
    "notify",
    "strip",
    "scroll",
    "encoding",
    "once",
    "listed",
}
for _, k in ipairs(asynctask_keys) do
    asynctask_keys[k] = true
end

---@param fpath string
---@return table<string, asynctask.group>
local function load_asynctask_file(fpath)
    local lines = fn.readfile(fpath)
    local tasks, group_name = {}, nil
    for _, line in ipairs(lines) do
        line = string.gsub(line, "[%s]*#.*$", "")
        line = vim.trim(line)
        if line ~= "" then
            if line:match("^%[.*%]$") then
                group_name = line:match("^%[(.*)%]$")
                tasks[group_name] = {}
                if group_name ~= "+" then
                    tasks[group_name]["command"] = {}
                end
            else
                local k, v = line:match("^(.*)=(.*)$")
                if group_name == "+" then
                    if asynctask_keys[k] == nil and (not k:match("^command")) then
                        tasks[group_name][k] = v
                    end
                else
                    if k == "command" then
                        tasks[group_name]["default_command"] = v
                    elseif k:match("^command") then
                        local fts = k:match("^command:(.*)")
                        tasks[group_name]["command"][fts] = v
                    else
                        tasks[group_name][k] = v
                    end
                end
            end
        end
    end
    return tasks
end

--- match $(VIM_CWD) like macros
---@param cmd_str string
---@return string
local function parse_cmd_macros(cmd_str)
    local ret = cmd_str ---@type string
    for m in cmd_str:gmatch("%$%(([%u_]+)%)") do
        ret = ret:gsub("%$%(" .. m .. "%)", MACROS[m]())
    end
    return ret
end

---match $(-arg1:default)
---@param cmd_str string
---@return overseer.Params
local function parse_cmd_args(cmd_str)
    local params = {}
    for word in cmd_str:gmatch("%$%(%-([%w%s_:]+)%)") do
        local arg = fn.split(word, ":")[1]
        local default = word:sub(#arg + 2)
        params[arg] = {
            type = "string",
            default = default or "",
        }
    end

    return params
end

---@param cmd_str string
---@param params overseer.Params
local function replace_cmd_args(cmd_str, params)
    for k, v in pairs(params) do
        cmd_str = cmd_str:gsub("%$%(%-" .. k .. ":?.*%)", v, 1)
    end
    return cmd_str
end

---@type overseer.TemplateFileDefinition
local tmpl = {
    name = "AsyncTask",
    desc = "an overseer wrap over vim plugin https://github.com/skywind3000/asynctasks.vim",
    builder = function(params)
        return {
            cmd = { MACROS.VIM_FILEPATH() },
        }
    end,
}

---@param opts overseer.SearchParams
---@return nil|string
local function get_asynctask_file(opts)
    return vim.fs.find(".tasks", { upward = true, type = "file", path = opts.dir })[1]
end

---@type overseer.TemplateProvider
return {
    name = "asynctask",
    -- cache_key = function(opts)
    --     return get_asynctask_file(opts)
    -- end,
    generator = function(opts, cb)
        local asynctasks = load_asynctask_file(fn.stdpath("config") .. sep .. vim.g.overseer_asynctasks_config_name)
        local internal_variables = asynctasks["+"] or {}
        asynctasks["+"] = nil
        -- vim.print(internal_variables)

        local ret = {}
        for group_name, asynctask_group in pairs(asynctasks) do
            if asynctask_group.command ~= nil then
                for fts, cmd_str in pairs(asynctask_group.command) do
                    local task_opts = {
                        desc = group_name,
                        builder = function(params)
                            local cmd = parse_cmd_macros(cmd_str)
                            cmd = replace_cmd_args(cmd, params)

                            if asynctask_group.pre_command ~= nil then
                                vim.fn.system(parse_cmd_macros(asynctask_group.pre_command))
                            end

                            return {
                                cmd = cmd,
                                cwd = parse_cmd_macros(asynctask_group.cwd),
                            }
                        end,
                        condition = { filetype = fn.split(fts, ",") },
                    }
                    local params = parse_cmd_args(cmd_str)
                    if vim.tbl_count(params) > 0 then
                        task_opts.params = params
                    end

                    if group_name:match("build") then
                        task_opts.tags = { TAG.BUILD }
                    elseif group_name:match("run") then
                        task_opts.tags = { TAG.RUN }
                    end
                    if asynctask_group.cwd ~= nil then
                        task_opts.cwd = parse_cmd_args(asynctask_group.cwd)
                    end

                    table.insert(ret, overseer.wrap_template(tmpl, task_opts))
                end
            end

            if asynctask_group.default_command ~= nil then
                local cmd_str = asynctask_group.default_command
                local task_opts = {
                    desc = group_name,
                    builder = function(params)
                        local cmd = parse_cmd_macros(cmd_str)
                        cmd = replace_cmd_args(cmd, params)

                        if asynctask_group.before_command ~= nil then
                            vim.fn.system(parse_cmd_macros(asynctask_group.before_command))
                        end

                        return { cmd = cmd }
                    end,
                }

                if group_name:match("build") then
                    task_opts.tags = { TAG.BUILD }
                elseif group_name:match("run") then
                    task_opts.tags = { TAG.RUN }
                end

                if asynctask_group.cwd ~= nil then
                    task_opts.cwd = parse_cmd_args(asynctask_group.cwd)
                end

                table.insert(ret, overseer.wrap_template(tmpl, task_opts))
            end
        end
        cb(ret)
    end,
}
-- vim:foldmethod=marker:
