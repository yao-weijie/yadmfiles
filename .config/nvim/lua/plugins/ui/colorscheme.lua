local function set_highlight()
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
        highlight! CursorLine gui=underline cterm=underline

        " ColorColumn
        highlight! ColorColumn guibg=gray

        " PmenuSel
        highlight! MyCmpSel guibg=#569CD6 guifg=black

        " Window separator
        highlight! WinSeparator guifg=gray
        highlight! NvimTreeWinSeparator guifg=gray
    ]])
end

return {
    "folke/tokyonight.nvim",
    dependencies = { -- other themes
        -- "olimorris/onedarkpro.nvim",
    },
    priority = 1000, -- load first
    config = function()
        -- vim.api.nvim_create_autocmd({ "WinLeave" }, { command = "setlocal nocursorline" })
        -- vim.api.nvim_create_autocmd({ "WinEnter" }, { command = "setlocal cursorline" })
        -- vim.api.nvim_create_autocmd({ "FileType" }, {
        --     pattern = { "alpha", "leaderf", "TelescopePrompt" },
        --     command = "setlocal nocursorline",
        -- })
        vim.api.nvim_create_autocmd({ "ColorScheme" }, { callback = set_highlight })

        vim.cmd.colorscheme("tokyonight")
    end,
}
