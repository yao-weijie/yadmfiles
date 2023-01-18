local ts = require("vim.treesitter")

local M = {}

M.is_inline_math = function()
    return nil
end

M.is_multi_math = function()
    return nil
end

M.is_math = function()
    return M.is_inline_math() or M.is_multi_math()
end

return M
