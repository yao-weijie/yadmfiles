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
        local Rule = require("nvim-autopairs.rule")
        local cmp = require("cmp")
        local handlers = require("nvim-autopairs.completion.handlers")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        npairs.setup(opts)

        cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done({
                filetypes = {
                    ["*"] = {
                        ["("] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                                cmp.lsp.CompletionItemKind.Class, -- 比默认配置多这个
                            },
                            handler = handlers["*"], -- 必须有
                        },
                    },
                    -- with texlab
                    tex = {
                        ["{"] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                            },
                            handler = handlers["*"], -- 必须有
                        },
                    },
                },
            })
        )

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
