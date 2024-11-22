---@type LazySpec
return {
    "smjonas/live-command.nvim",
    main = "live-command",
    opts = {
        commands = {
            Norm = { cmd = "norm" },
            Normal = { cmd = "normal" },
        },
    },
}
