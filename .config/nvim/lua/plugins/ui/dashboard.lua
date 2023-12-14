return {
    "nvimdev/dashboard-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
    opts = {
        theme = "doom",
        hide = {
            tabline = false,
        },
        config = {
            center = {
                {
                    desc = "Find Files          ",
                    key = "f",
                    -- action = "Telescope find_files",
                    action = "FzfLua files",
                },
                {
                    desc = "Old  Files          ",
                    key = "m",
                    -- action = "Telescope oldfiles",
                    action = "FzfLua oldfiles",
                },
                {
                    desc = "Grep Files          ",
                    key = "l",
                    -- action = "Telescope live_grep",
                    action = "FzfLua live_grep",
                },
                {
                    desc = "Help Tags           ",
                    key = "h",
                    -- action = "Telescope help_tags",
                    action = "FzfLua help_tags",
                },
                {
                    desc = "Quit                ",
                    key = "q",
                    action = "q",
                },
            },
        },
    },
}
