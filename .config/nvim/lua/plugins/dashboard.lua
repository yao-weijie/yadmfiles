return {
    "nvimdev/dashboard-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
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
                    action = "FzfLua files",
                },
                {
                    desc = "Old  Files          ",
                    key = "m",
                    action = "FzfLua oldfiles",
                },
                {
                    desc = "Grep Files          ",
                    key = "l",
                    action = "FzfLua live_grep",
                },
                {
                    desc = "Help Tags           ",
                    key = "h",
                    action = "FzfLua help_tags",
                },
                {
                    desc = "FzfLua              ",
                    key = "?",
                    action = "FzfLua",
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
