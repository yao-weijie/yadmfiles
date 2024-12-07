local M = {}

---@param fname string
---@return table<string, string>
M.loadfile = function(fname)
    fname = fname or ".env"
    local envs = {}
    local envfile = vim.fs.find(fname, { type = "file" })[1]
    if #envfile == nil then
        vim.notify("no .env file found", vim.log.levels.ERROR)
        return {}
    end

    local lines = vim.fn.readfile(".env") ---@type string[]
    if lines == 0 then
        vim.notify("no env value in .env file", vim.log.levels.WARN)
        return {}
    end

    for _, line in ipairs(lines) do
        local key = line:match("^([%w_]+)=")
        if key == nil then
            vim.notify("load envfile .env failed, " .. line, vim.log.levels.ERROR)
            return {}
        else
            envs[key] = vim.trim(line:sub(#key + 2))
        end
    end

    return envs
end

return M
