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
local conds = require("luasnip.extras.expand_conditions")
local make_condition = require("luasnip.extras.conditions").make_condition
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

local math = make_condition(function()
    return vim.fn.call("vimtex#syntax#in_mathzone", {}) == 1
end)

local global_opts = { condition = math, show_condition = math, delimiters = "<>" }

local snippet_templates = {
    -- 2.1 Automatic bracing
    ----------------------------------------------------------------------------
    -- 2.2 Vector notation
    -- vector
    { trig = "vb", dscr = "vector", body = [[ \vb{<>} ]] },
    { trig = "vbi", dscr = "vector italic", body = [[ \vb*{<>} ]] },
    -- vector arrow
    { trig = "va", dscr = "vector arrow", body = [[ \va{<>} ]] },
    { trig = "vai", dscr = "vector arrow italic", body = [[ \va*{<>} ]] },
    -- vector unit
    { trig = "vu", dscr = "vector unit", body = [[ \vu{<>} ]] },
    { trig = "vui", dscr = "vector unit italic", body = [[ \vu*{<>} ]] },
    -- vector product
    { trig = "dp", dscr = "dot product · ", body = [[ \dp <> ]] },
    { trig = "cp", dscr = "cross product ×", body = [[ \cp <> ]] },
    -- gradient
    { trig = "grad", dscr = "∇", body = [[ \grad <> ]] },
    { trig = "grad{", dscr = "∇{  }", body = [[ \grad{ <> } ]] },
    { trig = "grad(", dscr = "∇(  )", body = [[ \grad( <> ) ]] },
    { trig = "grad[", dscr = "∇[  ]", body = [[ \grad[ <> ] ]] },
    -- divergence
    { trig = "div", dscr = "∇·", body = [[ \div <> ]] },
    { trig = "div{", dscr = "∇·{  }", body = [[ \div{ <> } ]] },
    { trig = "div(", dscr = "∇·(  )", body = [[ \div( <> ) ]] },
    { trig = "div[", dscr = "∇·[  ]", body = [[ \div[ <> ] ]] },
    -- curl
    { trig = "curl", dscr = "∇×", body = [[ \curl <> ]] },
    { trig = "curl{", dscr = "∇×{  }", body = [[ \curl{ <> } ]] },
    { trig = "curl(", dscr = "∇×(  )", body = [[ \curl( <> ) ]] },
    { trig = "curl[", dscr = "∇×[  ]", body = [[ \curl[ <> ] ]] },
    -- laplacian
    { trig = "lap", dscr = "∇2", body = [[ \laplacian <> ]] },
    { trig = "lap{", dscr = "∇2 {  }", body = [[ \laplacian{ <> } ]] },
    { trig = "lap(", dscr = "∇2 (  )", body = [[ \laplacian( <> ) ]] },
    { trig = "lap[", dscr = "∇2 [  ]", body = [[ \laplacian[ <> ] ]] },
    ----------------------------------------------------------------------------
    -- 2.3 Operators
    { trig = "sin", dscr = "sin(x)", body = [[ \sin(<>) ]] },
    -- 2.4 Quick quad text
    { trig = "qq", dscr = "--text--", body = [[ \qq{ <> } ]] },
    { trig = "qqr", dscr = "text--", body = [[ \qq*{ <> } ]] },
    -- 2.5 Derivatives
    -- differential 差分
    { trig = "dd", dscr = "dx", body = [[ \dd <> ]] },
    { trig = "dd{", dscr = "-dx-", body = [[ \dd { <> } ]] },
    { trig = "dd(", dscr = "d(x)", body = [[ \dd( <> ) ]] },
    { trig = "ddn", dscr = "-dnx-", body = [[ \dd[<>]{ <> } ]], nodes = { i(1, "n"), i(2, "x") } },
    -- derivative 导数
    { trig = "dv", dscr = "d/dx", body = [[ \dv{ <> }]], nodes = { i(1, "x") } },
    { trig = "dvf", dscr = "df/dx", body = [[ \dv{<1>}{<2>}]], nodes = { i(1, "f"), i(2, "x") } },
    { trig = "dvnf", dscr = "d^nf/dx^n", body = [[ \dv[<1>]{<2>}{<3>} ]], nodes = { i(1, "n"), i(2, "f"), i(3, "x") } },
    { trig = "dvx(", dscr = "d/dx ( f )", body = [[\dv{<1>}(<2>)]], nodes = { i(1, "x"), i(2, "f") } },
    -- 2.6 Dirac bracket notation
    -- 2.7 Matrix macros
}

local function make_snippets()
    local snips = {}
    for _, tmp in ipairs(snippet_templates) do
        table.insert(
            snips,
            s({ trig = tmp.trig, dscr = tmp.dscr }, fmt(tmp.body, tmp.nodes or { i(1, "") }, global_opts))
        )
    end
    return snips
end

return make_snippets()
