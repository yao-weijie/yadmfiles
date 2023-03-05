return {
    "rcarriga/nvim-notify",
    priority = 900,
    opts = {
        background_colour = "Normal",
        minimum_width = 20,
        max_width = nil,
        max_height = nil,
    },
    config = function(_, opts)
        require("notify").setup(opts)
        vim.notify = require("notify")
    end,
}
