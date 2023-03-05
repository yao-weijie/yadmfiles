return {
    "goolord/alpha-nvim",
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
            dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
            dashboard.button("p", "  Find project", ":Telescope project<CR>"),
            dashboard.button("m", "  Recently used files", ":Telescope oldfiles<CR>"),
            dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
            dashboard.button("q", "  Quit Neovim", ":q<CR>"),
        }
        require("alpha").setup(dashboard.opts)
    end,
}
