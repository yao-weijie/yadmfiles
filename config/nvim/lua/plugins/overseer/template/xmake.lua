local constants = require("overseer.constants")
local log = require("overseer.log")
local overseer = require("overseer")
local TAG = constants.TAG

---@param opts overseer.SearchParams
---@return nil|string
local function find_xmake_file(opts)
    return vim.fs.find("xmake.lua", { upward = true, type = "file", path = opts.dir })[1]
end

---@type overseer.TemplateFileDefinition
local tmpl = {
    name = "make",
    priority = 60,
    -- tags = { TAG.BUILD },
    params = {
        args = { optional = true, type = "list", delimiter = " " },
        cwd = { optional = true },
    },
    builder = function(params)
        return {
            cmd = { "xmake" },
            args = params.args,
            cwd = params.cwd,
        }
    end,
}

---@type overseer.TemplateProvider
return {
    name = "xmake",
    cache_key = function(opts)
        return find_xmake_file(opts)
    end,
    condition = {
        callback = function(opts)
            if vim.fn.executable("xmake") == 0 then
                return false, 'Command "xmake" not found'
            end
            if not find_xmake_file(opts) then
                return false, "No xmake.lua file found"
            end
            return true
        end,
    },
    generator = function(opts, cb)
        local xmake_dir = vim.fs.dirname(assert(find_xmake_file(opts)))
        local ret = {}

        local commands = {
            { args = { "build" }, tags = { TAG.BUILD } },
            { args = { "clean" }, tags = { TAG.CLEAN } },
            { args = { "run" }, tags = { TAG.RUN } },
            { args = { "test" }, tags = { TAG.TEST } },
            { args = { "install" } },
            { args = { "uninstall" } },
            { args = { "check" } },
        }
        cb(ret)
    end,
}
