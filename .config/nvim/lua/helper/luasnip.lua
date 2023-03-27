local M = {}

local make_condition = require("luasnip.extras.conditions").make_condition

M.line_begin = require("luasnip.extras.conditions.expand").line_begin
M.line_end = require("luasnip.extras.conditions.show").line_end

M.in_mathzone = make_condition(function()
    return vim.api.nvim_call_function("vimtex#syntax#in_mathzone", {}) == 1
end)

return M
