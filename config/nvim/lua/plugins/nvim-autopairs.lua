---@type LazySpec
return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {
        check_ts = true,
        fast_wrap = {
            map = "<M-e>", -- default
            chars = { "{", "[", "(", '"', "'" },
            -- pattern = [=[[%'%"%>%]%)%}%,]]=], -- default
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            end_key = ";",
        },
        map_c_h = true,
    },
    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        npairs.setup(opts)

        -- add spaces between parentheses
        npairs.add_rules({
            Rule(" ", " "):with_pair(function(opt)
                local pair = opt.line:sub(opt.col - 1, opt.col)
                return vim.tbl_contains({ "()", "[]", "{}" }, pair)
            end),
            -- stylua: ignore start
            Rule("( ", " )")
                :with_pair(function() return false end)
                :with_move(function(opt) return opt.prev_char:match(".%)") ~= nil end)
                :use_key(")"),
            Rule("[ ", " ]")
                :with_pair(function() return false end)
                :with_move(function(opt) return opt.prev_char:match(".%]") ~= nil end)
                :use_key("]"),
            Rule("{ ", " }")
                :with_pair(function() return false end)
                :with_move(function(opt) return opt.prev_char:match(".%}") ~= nil end)
                :use_key("}"),
            -- stylua: ignore start
        })
    end,
}
