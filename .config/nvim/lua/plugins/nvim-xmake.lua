---@type LazySpec
return {
    dir = "~/.config/nvim/dev/nvim-xmake",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    opts = {
        extra_sources = {
            { name = "buffer" },
            { name = "luasnip" },
            { name = "nvim_lsp" },
        },
    },
    -- config = function()
    --     --
    -- end,
}
