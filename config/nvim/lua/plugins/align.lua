---@type LazySpec
return {
    "junegunn/vim-easy-align",
    -- config = function()
    --     vim.cmd([[
    --         xmap <leader>a <Plug>(EasyAlign)
    --         nmap <leader>a <Plug>(EasyAlign)
    --     ]])
    -- end,
    keys = {
        { "<leader>a", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "EasyAlign", remap = true },
    },
}
