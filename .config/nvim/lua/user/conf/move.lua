local status_ok, move = pcall(require, "move")
if not status_ok then
    vim.notify("move not found!")
    return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<A-j>", ":MoveLine(1)<CR>", opts)
keymap("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
keymap("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
keymap("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
keymap("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
keymap("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
keymap("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
keymap("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
