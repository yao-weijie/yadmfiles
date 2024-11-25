---@type LazySpec
return {
    "nvimdev/indentmini.nvim",
    opts = {},
    event = { "BufEnter" },
    config = function(_, opts)
        require("indentmini").setup(opts)
        vim.cmd.highlight("IndentLineCurrent guifg=red")
    end,
}
