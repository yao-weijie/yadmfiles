---@type LazySpec
return {
    "yao-weijie/nvim-xmake",
    dir = "~/workspace/neovim/nvim-xmake",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    opts = {
        extra_sources = {
            { name = "buffer" },
            { name = "luasnip" },
            -- { name = "nvim_lsp" },
        },
    },
    config = function(_, opts)
        require("xmake").setup(opts)
    end,
}
