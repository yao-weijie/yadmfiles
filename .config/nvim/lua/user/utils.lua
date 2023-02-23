local M = {}

M.create_file = function()
    vim.ui.input("File path", function(path)
        vim.cmd(":e " .. path)
        vim.notify(path)
    end)
end

M.join_path = function(...)
    local args = { ... }
    if #args == 0 then
        return
    end

    local sep = "/"
    if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        sep = "\\"
    end

    local path = vim.call("join", args, sep)
    path = vim.fn.expand(path)
    return path
end

local load_ignores = {
    "init.lua",
}

-- TODO
M.load_folder = function(folder_path)
    for _, fname in pairs(vim.fn.readdir(folder_path)) do
        if not vim.tbl_contains(load_ignores, fname) then
            local fpath = "user.lang." .. vim.fn.fnamemodify(fname, ":r")

            local status_ok, _ = pcall(require, fpath)
            if not status_ok then
                vim.notify("Failed loading " .. fpath, vim.log.levels.ERROR)
            end
        end
    end
end

return M
