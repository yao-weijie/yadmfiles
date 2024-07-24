---@type LazySpec
return {
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
    init = function()
        -- cfilter is very powerfull
        vim.cmd("packadd cfilter")
    end,
    opts = {},
}
