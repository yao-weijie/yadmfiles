---@type LazySpec
return {
    "folke/lazydev.nvim",
    dependencies = {
        "Bilal2453/luvit-meta",
        "justinsgithub/wezterm-types",
    },
    version = "*",
    ft = { "lua" },
    -- enabled = function()
    --     return vim.g.lazydev_enabled and true or false
    -- end,
    opts = {
        library = {
            "lazy.nvim",
            "luvit-meta/library",
            -- "nvim-xmake/library",
            { path = "wezterm-types", mods = { "wezterm" } },
        },
    },
    config = function(_, opts)
        if require("lspconfig.util").root_pattern("xmake.lua") then
            table.insert(opts.library, "nvim-xmake/library")
        end
        require("lazydev").setup(opts)
    end,
}
