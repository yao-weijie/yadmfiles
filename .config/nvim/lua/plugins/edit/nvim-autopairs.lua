return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {
        check_ts = true,
        disable_filetype = {
            "TelescopePrompt",
            "spectre_panel",
            "dap-repl",
            "guihua",
            "guihua_rust",
            "clap_input",
        },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 1, -- Offset from pattern match
            end_key = ";",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
        map_c_h = true,
    },
    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        npairs.setup(opts)
        local Rule = require("nvim-autopairs.rule")

        -- other settings
        -- autopairs is started before cmp
        require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

        -- add spaces between parentheses
        npairs.add_rules({
            Rule(" ", " "):with_pair(function(opts)
                local pair = opts.line:sub(opts.col - 1, opts.col)
                return vim.tbl_contains({ "()", "[]", "{}" }, pair)
            end),
            Rule("( ", " )")
                :with_pair(function()
                    return false
                end)
                :with_move(function(opts)
                    return opts.prev_char:match(".%)") ~= nil
                end)
                :use_key(")"),
            Rule("{ ", " }")
                :with_pair(function()
                    return false
                end)
                :with_move(function(opts)
                    return opts.prev_char:match(".%}") ~= nil
                end)
                :use_key("}"),
            Rule("[ ", " ]")
                :with_pair(function()
                    return false
                end)
                :with_move(function(opts)
                    return opts.prev_char:match(".%]") ~= nil
                end)
                :use_key("]"),
        })
    end,
}
