vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    -- colorscheme override
    command = "source ~/.config/nvim/colors/mycolor.vim",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "dashboard",
        "alpha",
        "leaderf",
        "TelescopePrompt",
    },
    command = "setlocal nocursorline",
})

---@type LazySpec
return {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- load first
    config = function()
        vim.cmd.colorscheme("onedark")
    end,
}
