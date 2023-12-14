return {
    "folke/noice.nvim",
    version = "*",
    event = { "VeryLazy" },
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {
        cmdline = {
            view = "cmdline",
            opts = {
                position = { row = -1 },
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
