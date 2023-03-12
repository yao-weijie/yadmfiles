return {
    "theniceboy/antovim",
    config = function()
        vim.keymap.set("n", "gs", "<cmd>Antovim<CR>", { desc = "反义词" })
        vim.g.custom_antovim_definitions = {
            { "on", "off" },
            { "start", "begin", "end" },
            { "succed", "fail" },
            { "yes", "no" },
        }
    end,
}
