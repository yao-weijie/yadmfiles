return {
    "folke/tokyonight.nvim",
    dependencies = { -- other themes
        -- "olimorris/onedarkpro.nvim",
    },
    priority = 1000, -- load first
    config = function()
        local dark_themes = {
            "tokyonight",
            "tokyonight-moon",
            "tokyonight-night",
            "tokyonight-storm",
        }
        local light_themes = {
            "tokyonight-day",
        }

        math.randomseed(os.clock())
        if vim.o.background == "dark" then
            vim.cmd.colorscheme("tokyonight-night")
        else
            vim.cmd.colorscheme("tokyonight-day")
        end

        vim.cmd([[
        " cmp group
        " gray
        highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
        " blue
        highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
        highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
        " light blue
        highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
        highlight! link CmpItemKindInterface CmpItemKindVariable
        highlight! link CmpItemKindText CmpItemKindVariable
        " pink
        highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
        highlight! link CmpItemKindMethod CmpItemKindFunction
        " front
        highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
        highlight! link CmpItemKindProperty CmpItemKindKeyword
        highlight! link CmpItemKindUnit CmpItemKindKeyword

        " CursorLine
        highlight! CursorLine gui=underline

        " Window separator
        highlight! WinSeparator guifg=gray
        ]])
    end,
}
