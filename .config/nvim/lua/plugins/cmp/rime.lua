return {
    "yao-weijie/cmp-rime",
    branch = "dev",
    dev = true,
    lazy = false,
    opts = {
        libpath = "/usr/lib/x86_64-linux-gnu/librime.so.1",
        -- enable = {
        --     comment = true,
        -- },
        -- preselect = true,
        -- number_select = 9,
    },
    keys = {
        { "<C-g>", "<cmd>lua require('cmp_rime').mapping.toggle()<CR>", mode = { "i", "n" } },
    },
    config = true,
    -- config = function(_, opts)
    --     --
    -- end,
}
