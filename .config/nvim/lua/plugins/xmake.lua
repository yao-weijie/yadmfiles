return {
    "Mythos-404/xmake.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
    },
    branch = "v1",
    event = "BufReadPost xmake.lua",
    lazy = true,
    config = true,
}
