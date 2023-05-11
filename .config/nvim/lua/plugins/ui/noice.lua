return {
    "folke/noice.nvim",
    event = { "VeryLazy" },
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                background_colour = "Normal",
                minimum_width = 20,
                max_width = 80,
                max_height = 20,
            },
        },
    },
    opts = {
        cmdline = {
            opts = {
                position = {
                    row = "10%",
                },
            },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            hover = { enabled = false },
            signature = { enabled = true },
        },
    },
}
