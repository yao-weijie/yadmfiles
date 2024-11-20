---@type LazySpec
return {
    "folke/lazydev.nvim",
    dependencies = {
        "Bilal2453/luvit-meta",
        -- "justinsgithub/wezterm-types",
    },
    version = "*",
    ft = { "lua" },
    enabled = function(root_dir)
        -- return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
    end,
    opts = {
        library = {
            "lazy.nvim",
            "luvit-meta/library",
            -- "nvim-xmake/library",
            -- { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
            { path = "wezterm-types", mods = { "wezterm" } }, -- put such files in local .lazy.lua file
        },
    },
}
