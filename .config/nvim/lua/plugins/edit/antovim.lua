return {
    "theniceboy/antovim",
    event = { "BufRead" },
    config = function()
        vim.g.custom_antovim_definitions = {
            { "on", "off" },
            { "start", "begin", "end" },
            { "succed", "fail" },
            { "yes", "no" },
        }
    end,
}
