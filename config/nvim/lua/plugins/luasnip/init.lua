---@type LazySpec
return {
    "L3MON4D3/LuaSnip",
    version = "*",
    enabled = true,
    dependencies = {
        "honza/vim-snippets",
    },
    build = "make install_jsregexp",
    event = { "InsertEnter", "BufNewFile" },
    config = function()
        require("luasnip").setup({})
        -- snippets/<ft>.snippets and snippets/<ft>/*.snippets
        require("luasnip.loaders.from_snipmate").lazy_load()
        -- luasnippets/<ft>.lua and luasnippets/<ft>/*.lua
        -- require("luasnip.loaders.from_lua").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { "~/.config/nvim/snippets" },
        })
    end,
}
