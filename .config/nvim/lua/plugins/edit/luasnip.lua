return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "honza/vim-snippets",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/nvim-cmp",
    },
    event = { "InsertEnter" },
    config = function()
        local luasnip, cmp = require("luasnip"), require("cmp")

        luasnip.setup()
        -- load snippet folders in runtimeapth
        vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/my-snippets")
        -- snippets/<ft>.snippets and snippets/<ft>/*.snippets
        require("luasnip.loaders.from_snipmate").lazy_load()
        -- luasnippets/<ft>.lua and luasnippets/<ft>/*.lua
        require("luasnip.loaders.from_lua").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-j>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    elseif cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
        })
    end,
}
