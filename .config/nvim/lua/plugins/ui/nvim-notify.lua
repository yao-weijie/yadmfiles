return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                background_colour = "Normal",
                minimum_width = 20,
                max_width = nil,
                max_height = nil,
            },
        },
    },
    priority = 900,
    config = true,
}
