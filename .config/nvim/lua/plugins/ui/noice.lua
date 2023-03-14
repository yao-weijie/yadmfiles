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
    opts = {
        popupmenu = {
            backend = "cmp",
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            hover = { enabled = false },
            signature = { enabled = false },
        },
    },
}
