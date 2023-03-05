local M = {}
local luapath = vim.fn.stdpath("config") .. "/lua/"

---@param relpath string 相对~/.config/nvim/lua/ 的相对路径,例如 "plugins/edit/"
---@param plugins table
---@return table
M.lazy_require = function(relpath, plugins)
    relpath = vim.endswith(relpath, "/") and relpath or relpath .. "/"
    plugins = plugins or {}
    local folder = vim.fn.expand(luapath .. relpath)
    for _, fname in ipairs(vim.fn.readdir(folder)) do
        if vim.endswith(fname, ".lua") and fname ~= "init.lua" then
            local f = string.gsub(fname, ".lua", "")
            local ok, plugs = pcall(require, relpath .. f)
            if not ok then
                vim.notify("load " .. relpath .. f .. " failed")
            end

            if type(plugs) == "boolean" then
                -- pass
            elseif vim.tbl_islist(plugs) then
                plugins = vim.fn.extend(plugins, plugs)
            else
                table.insert(plugins, plugs)
            end
        end
    end
    return plugins
end

return M
