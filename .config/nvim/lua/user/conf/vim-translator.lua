vim.g.translator_target_lang = "zh"
vim.g.translator_default_engins = { "bing", "youdao" }

require("which-key").register({
    ["<leader><C-t>"] = { "<cmd>TranslateW --engines=bing,haici<CR>", "translate" },
}, { mode = { "n", "v" } })
