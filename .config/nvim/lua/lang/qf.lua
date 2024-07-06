---@type LazySpec
return {
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
    config = function()
        vim.cmd("packadd cfilter")

        -- cfilter is very powerfull
        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = { "qf" },
        --     callback = function(file)
        --         local opts = { buffer = file.buf }
        --         vim.keymap.set("n", "J", "<cmd>cnext<CR>", opts)
        --         vim.keymap.set("n", "K", "<cmd>cprevious<CR>", opts)
        --     end,
        -- })
    end,
}
