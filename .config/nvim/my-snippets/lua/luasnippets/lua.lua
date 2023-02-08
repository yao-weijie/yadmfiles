local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conditions = require("luasnip.extras.conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local context = [[
snippet tris "tris description" b
    tris loaded
]]

local conds_b = function(line_to_cursor, matched_trigger, captures)
    return line_to_cursor:match(".*$")
end

local myparser = function(context)
    local idx = string.find(context, "\n")
    local header = string.sub(context, 0, idx - 1)
    local body = string.sub(context, idx + 1, #context - 1)

    local trig, dscr, cond = string.match(header, [[snippet ([%a%d]+) [\'\"]?([%a%s]+)[\'\"]?[%s]?([ibw]*)$]])

    return ls.parser.parse_snipmate({ trig = trig, dscr = dscr }, body, { condition = conditions.line_end })
end

local line_b = function(line_to_cursor)
    return line_to_cursor:match("^[%a]*")
end

-- stylua: ignore
return {
    s({trig="trigger", dscr="description"}, fmt([[
        {1}
    ]], {
        i(1, "trigger"),
    }), {
        condition = line_begin,
        show_condition=line_b
    }),

    -- myparser(context),
    -- ls.parser.parse_snipmate(context)
}
