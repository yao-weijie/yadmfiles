vim.opt.completeopt = "menu,menuone,noselect"
local keymap = vim.keymap.set

return {
    "nvimdev/epo.nvim",
    event = "InsertEnter",
    opts = {
        fuzzy = true,
        signature = true,
    },
}
