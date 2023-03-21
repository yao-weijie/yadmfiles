local M = {}

M.setup = function(...)
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system(
            "git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git " .. lazypath
        )
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup(...)
end

---@param relpath string 相对~/.config/nvim/lua/ 的相对路径,例如 "plugins/edit/"
---@param plugins table
---@return table
M.lazy_require = function(relpath, plugins)
    relpath = vim.endswith(relpath, "/") and relpath or relpath .. "/"
    plugins = plugins or {}
    local luapath = vim.fn.stdpath("config") .. "/lua/"
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
                plugins = vim.list_extend(plugins, plugs)
            else
                table.insert(plugins, plugs)
            end
        end
    end
    return plugins
end

return M
