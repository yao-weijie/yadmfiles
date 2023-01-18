vim.g.Lf_HideHelp = 1
vim.g.Lf_ShowDevIcons = 1
vim.g.Lf_WindowPosition = "popup"
vim.g.Lf_RootMarkers = vim.g.ROOT_MARKERS
vim.g.Lf_WorkingDirectoryMode = "Ac"
vim.g.Lf_StlSeparator = { left = "", right = "" }

vim.g.Lf_ShortcufF = ""

vim.g.Lf_GtagsAutoGenerate = 1
vim.g.Lf_Gtagslabel = "native-pygments"

require("which-key").register({
    ["<leader>F"] = "Leaderf fuzzy search",
    -- ["<leader>F"] = { "<cmd>LeaderfFile<CR>", "file" },
    ["<leader>F/"] = { "<cmd>Leaderf self<CR>", "Leaderf self" },
    ["<leader>Fb"] = { "<cmd>LeaderfBuffer<CR>", "buffer" },
    ["<leader>Fm"] = { "<cmd>LeaderfMru<CR>", "mru" },
    ["<leader>Ff"] = { "<cmd>LeaderfFile<CR>", "file" },
    ["<leader>Fl"] = { "<cmd>LeaderfLine<CR>", "current file line" },
    ["<leader>Ft"] = { "<cmd>LeaderfBufTagAll<CR>", "buf tags" },
}, {})
vim.cmd([[
    cnoremap <expr> lf getcmdtype() == ':' ? 'Leaderf ' : 'lf'
]])
