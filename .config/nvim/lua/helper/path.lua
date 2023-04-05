local M = {}

M.join_path = function()
    --
end

local UNIT = {
    k = 1024,
    m = math.pow(1024, 2),
    g = math.pow(1024, 3),
}

---@param buf integer
---@param size string: k,m,g
---@return boolean
M.is_hugefile = function(buf, size)
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

return M
