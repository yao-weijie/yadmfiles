vim.g.custom_antovim_definitions = {
    { "on", "off" },
    { "start", "begin", "end" },
    { "succed", "fail" },
    { "yes", "no" },
}

require("which-key").register({
    ["gs"] = { "<cmd>Antovim<CR>", "反义词" },
}, {})
