vim.g.punc_shape = "half"
vim.keymap.set("i", "<C-r>", function()
    if vim.g.punc_shape == "half" then
        vim.keymap.set("i", ",", "，", {})
        vim.keymap.set("i", ".", "。", {})
        vim.keymap.set("i", "(", "（", {})
        vim.keymap.set("i", ")", "）", {})
        vim.keymap.set("i", "\\", "、", {})
        vim.keymap.set("i", "?", "？", {})
        vim.keymap.set("i", "!", "！", {})
        vim.g.punc_shape = "full"
    else
        vim.keymap.del("i", ",", {})
        vim.keymap.del("i", ".", {})
        vim.keymap.del("i", "(", {})
        vim.keymap.del("i", ")", {})
        vim.keymap.del("i", "\\", {})
        vim.keymap.del("i", "?", {})
        vim.keymap.del("i", "!", {})
        vim.g.punc_shape = "half"
    end
end, { desc = "toggle punc shape" })

return {}
