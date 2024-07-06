---@type LazySpec
return {
    {
        "folke/lazydev.nvim",
        version = "*",
        ft = "lua",
        enabled = true,
        opts = {
            library = {
                -- { path = "nvim-xmake/library", words = { "target" } },
                "nvim-xmake/library",
                "luvit-meta/library",
                -- { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
}
