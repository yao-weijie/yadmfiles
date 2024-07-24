local M = {}

local make_condition = require("luasnip.extras.conditions").make_condition

M.line_begin = require("luasnip.extras.conditions.expand").line_begin
M.line_end = require("luasnip.extras.conditions.show").line_end

local parse_snippet = require("luasnip.util.parser").parse_snippet
local parse_snipmate = require("luasnip.util.parser").parse_snipmate

M.in_mathzone = make_condition(function()
    return vim.api.nvim_call_function("vimtex#syntax#in_mathzone", {}) == 1
end)

return M
