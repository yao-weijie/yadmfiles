---@type LazySpec
return {
    "rareitems/printer.nvim",
    config = true,
    keys = {
        { "<leader>p", "<Plug>(printer_print)iw", desc = "printer cwd" },
    },
}
