local M = {}

M.normalize = function(path)
    return vim.fs.normalize(path)
end

---@param path string
---@return boolean
M.file_exist = function(path)
    path = vim.fn.expand(path)
    return vim.fn.filereadable(path) == 1 and true or false
end

---@param path string
---@return boolean
M.dir_exist = function(path)
    return vim.fn.isdirectory(path) == 1 and true or false
end

---@param path string
---@return boolean
M.executable = function(path)
    return vim.fn.executable(path) == 1 and true or false
end

---@param path string
---@return boolean
M.filewritable = function(path)
    return vim.fn.filewritable(path) == 1 and true or false
end

---@vararg string
M.join = function(...)
    if vim.fs.joinpath then
        return vim.fs.joinpath(...)
    else
        return M.trim(table.concat({ ... }, "/"))
    end
end

local UNIT = {
    k = 1024,
    m = math.pow(1024, 2),
    g = math.pow(1024, 3),
}

---@param size string 10k, 10m, 10g etc.
---@param buf integer? bufnr
---@return boolean
M.is_hugefile = function(size, buf)
    buf = buf or 0
    size = size:lower()
    local n = tonumber(size:sub(1, -2))
    local base = size:sub(-1, -1)
    local max_filesize = n * UNIT[base]
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
        return true
    else
        return false
    end
end

---@param fname string
---@param type? string
---@param max? string
---@return any[]
M.readfile = function(fname, type, max)
    type = type or ""
    max = max or nil
    return vim.fn.readfile(M.normalize(fname), type)
end

_G.pathlib = M

return M
