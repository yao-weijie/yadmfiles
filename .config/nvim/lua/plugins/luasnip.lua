return {
    "L3MON4D3/LuaSnip",
    version = "*",
    dependencies = {
        "honza/vim-snippets",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/nvim-cmp",
    },
    build = "make install_jsregexp",
    event = { "InsertEnter" },
    config = function()
        require("luasnip").setup()
        -- load snippet folders in runtimeapth
        -- vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/my-snippets") -- put in vimrc
        -- snippets/<ft>.snippets and snippets/<ft>/*.snippets
        require("luasnip.loaders.from_snipmate").lazy_load()
        -- luasnippets/<ft>.lua and luasnippets/<ft>/*.lua
        require("luasnip.loaders.from_lua").lazy_load()
    end,
}
