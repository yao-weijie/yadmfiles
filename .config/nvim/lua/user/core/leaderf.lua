vim.g.Lf_HideHelp = 1
vim.g.Lf_ShowDevIcons = 1
vim.g.Lf_WindowPosition = "popup"
vim.g.Lf_RootMarkers = vim.g.ROOT_MARKERS
vim.g.Lf_StlSeparator = { left = "", right = "" }


vim.g.Lf_GtagsAutoGenerate = 1
vim.g.Lf_Gtagslabel = "native-pygments"

-- require("which-key").register({
--     ["<leader>F"] = "Leaderf fuzzy search",
--     ["<leader>F/"] = { "<cmd>Leaderf self<CR>", "Leaderf self" },
--     ["<leader>Fb"] = { "<cmd>LeaderfBuffer<CR>", "buffer" },
--     ["<leader>Fm"] = { "<cmd>LeaderfMru<CR>", "mru" },
--     ["<leader>Ff"] = { "<cmd>LeaderfFile<CR>", "file" },
--     ["<leader>Fl"] = { "<cmd>LeaderfLine<CR>", "current file line" },
--     ["<leader>Ft"] = { "<cmd>LeaderfBufTag<CR>", "buf tags" },
--     ["<leader>FT"] = { "<cmd>LeaderfBufTagAll<CR>", "all buf tags" },
--     ["<leader>Fr"] = {
--         [[<cmd><C-U><C-R>=printf('Leaderf! gtags -r %s --auto-jump', expand('<cword>'))<CR><CR>]],
--         "gtags ref",
--     },
-- }, {})

vim.cmd([[
    cnoremap <expr> lf getcmdtype() == ':' ? 'Leaderf ' : 'lf'
]])
