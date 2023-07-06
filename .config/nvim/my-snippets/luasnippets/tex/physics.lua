local extras = require("luasnip.extras")
local parse = require("luasnip.util.parser").parse_snippet

local in_mathzone = require("helper.luasnip").in_mathzone
local line_begin = require("helper.luasnip").line_begin
local line_end = require("helper.luasnip").line_end

local global_opts = { condition = in_mathzone, show_condition = in_mathzone }

local snippet_templates = {
    -- 2.1 Automatic bracing
    ----------------------------------------------------------------------------
    -- 2.2 Vector notation
    -- vector
    { trig = "vb", dscr = "vector", body = [[ \vb{$1} ]] },
    { trig = "vbi", dscr = "vector italic", body = [[ \vb*{$1} ]] },
    -- vector arrow
    { trig = "va", dscr = "vector arrow", body = [[ \va{$1} ]] },
    { trig = "vai", dscr = "vector arrow italic", body = [[ \va*{$1} ]] },
    -- vector unit
    { trig = "vu", dscr = "vector unit", body = [[ \vu{$1} ]] },
    { trig = "vui", dscr = "vector unit italic", body = [[ \vu*{$1} ]] },
    -- vector product
    { trig = "dp", dscr = "dot product · ", body = [[ \dp $1 ]] },
    { trig = "cp", dscr = "cross product ×", body = [[ \cp $1 ]] },
    -- gradient
    { trig = "grad", dscr = "∇ ", body = [[ \grad $1 ]] },
    { trig = "grad{", dscr = "∇ {  }", body = [[ \grad{ $1 } ]] },
    { trig = "grad(", dscr = "∇ (  )", body = [[ \grad( $1 ) ]] },
    { trig = "grad[", dscr = "∇ [  ]", body = [[ \grad[ $1 ] ]] },
    -- divergence
    { trig = "div", dscr = "∇ ·", body = [[ \div $1 ]] },
    { trig = "div{", dscr = "∇ ·{  }", body = [[ \div{ $1 } ]] },
    { trig = "div(", dscr = "∇ ·(  )", body = [[ \div( $1 ) ]] },
    { trig = "div[", dscr = "∇ ·[  ]", body = [[ \div[ $1 ] ]] },
    -- curl
    { trig = "curl", dscr = "∇ ×", body = [[ \curl $1 ]] },
    { trig = "curl{", dscr = "∇ ×{  }", body = [[ \curl{ $1 } ]] },
    { trig = "curl(", dscr = "∇ ×(  )", body = [[ \curl( $1 ) ]] },
    { trig = "curl[", dscr = "∇ ×[  ]", body = [[ \curl[ $1 ] ]] },
    -- laplacian
    { trig = "lap", dscr = "∇ 2", body = [[ \laplacian $1 ]] },
    { trig = "lap{", dscr = "∇ 2 {  }", body = [[ \laplacian{ $1 } ]] },
    { trig = "lap(", dscr = "∇ 2 (  )", body = [[ \laplacian( $1 ) ]] },
    { trig = "lap[", dscr = "∇ 2 [  ]", body = [[ \laplacian[ $1 ] ]] },
    ----------------------------------------------------------------------------
    -- 2.3 Operators
    { trig = "sin", dscr = "sin(x)", body = [[ \sin($1) ]] },
    -- 2.4 Quick quad text
    { trig = "qq", dscr = "--text--", body = [[ \qq{ $1 } ]] },
    { trig = "qqr", dscr = "text--", body = [[ \qq*{ $1 } ]] },
    -- 2.5 Derivatives
    -- differential 差分
    { trig = "dd", dscr = "dx", body = [[ \dd $1 ]] },
    { trig = "dd{", dscr = "-dx-", body = [[ \dd { $1 } ]] },
    { trig = "dd(", dscr = "d(x)", body = [[ \dd( $1 ) ]] },
    { trig = "ddn", dscr = "-dnx-", body = [[ \dd[$1]{ $2 } ]] },
    -- derivative 导数
    { trig = "dv", dscr = "d/dx", body = [[ \dv{ $1 }]] },
    { trig = "dvf", dscr = "df/dx", body = [[ \dv{$1}{$1}]] },
    { trig = "dvnf", dscr = "d^nf/dx^n", body = [[ \dv[$1]{$2}{$3} ]] },
    { trig = "dvx(", dscr = "d/dx ( f )", body = [[\dv{$1}($2)]] },
    -- 2.6 Dirac bracket notation
    -- 2.7 Matrix macros
}

local snips = {}
for _, item in ipairs(snippet_templates) do
    table.insert(snips, parse({ trig = item.trig, dscr = item.dscr }, item.body, global_opts))
end

return snips
