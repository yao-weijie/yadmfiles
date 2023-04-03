return {
    "goolord/alpha-nvim",
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.buttons.val = {
            -- 和telescope 配置一致
            dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
            dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
            dashboard.button("m", "  Recently used files", ":Telescope oldfiles<CR>"),
            dashboard.button("l", "  Find text", ":Telescope live_grep<CR>"),
            dashboard.button("J", "J  Jump list", ":Telescope jumplist<CR>"),
            dashboard.button("q", "  Quit Neovim", ":q<CR>"),
        }
        require("alpha").setup(dashboard.opts)
    end,
}
