---@type LazySpec
return {
    "folke/snacks.nvim",
    version = "*",
    priority = 999, -- after than colorscheme plugin
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            preset = {
                pick = "fzf-lua",
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
                    {
                        icon = " ",
                        key = "l",
                        desc = "Find Text",
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                    },
                    {
                        icon = " ",
                        key = "m",
                        desc = "Recent Files",
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = " ",
                        key = "c",
                        desc = "Config",
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    {
                        icon = "󰒲 ",
                        key = "L",
                        desc = "Lazy",
                        action = ":Lazy",
                        enabled = package.loaded.lazy ~= nil,
                    },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                { section = "keys", indent = 2, padding = 1 },
                { section = "startup" },
            },
        },
        notifier = {
            enabled = true,
            style = "minimal",
        },
        bigfile = {
            enabled = true,
            size = 2 * 1024 * 1024, -- 2MiB
        },
        -- quickfile = { enabled = true },
    },
    keys = {
        {
            "<leader>q",
            function()
                Snacks.bufdelete()
            end,
            desc = "buf delete",
        },
    },
}
