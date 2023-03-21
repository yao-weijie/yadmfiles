local M = {}

local conds = require("luasnip.extras.expand_conditions")
local make_condition = require("luasnip.extras.conditions").make_condition

M.in_mathzone = make_condition(function()
    return vim.api.nvim_call_function("vimtex#syntax#in_mathzone", {}) == 1
end)

M.get_env = function()
    return
end

return M
