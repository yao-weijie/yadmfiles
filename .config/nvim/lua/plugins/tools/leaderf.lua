return {
    "Yggdroot/LeaderF",
    event = { "VeryLazy" },
    priority = 99,
    -- need to pip install pynvim
    build = ":LeaderfInstallCExtension",
    cond = vim.fn.has("python3") == 1,
    init = function()
        vim.g.Lf_ShortcutF = ""
        vim.g.Lf_ShortcutB = ""
        vim.g.Lf_HideHelp = 1
        vim.g.Lf_ShowDevIcons = 1
        vim.g.Lf_WindowPosition = "popup"
        vim.g.Lf_RootMarkers = vim.g.ROOT_MARKERS
        vim.g.Lf_StlSeparator = { left = "", right = "" }

        vim.g.Lf_GtagsAutoGenerate = 1
        vim.g.Lf_Gtagslabel = "native-pygments"
    end,
    keys = {
        { "<leader>Fb", "<cmd>LeaderfBuffer<CR>", desc = "buffer" },
        { "<leader>Fm", "<cmd>LeaderfMru<CR>", desc = "mru" },
        { "<leader>Ff", "<cmd>LeaderfFile<CR>", desc = "file" },
        { "<leader>Fl", "<cmd>LeaderfLine<CR>", desc = "current file line" },
        { "<leader>Ft", "<cmd>LeaderfBufTag<CR>", desc = "buf tags" },
        { "<leader>FT", "<cmd>LeaderfBufTagAll<CR>", desc = "all buf tags" },
        { "<leader>F/", "<cmd>Leaderf self<CR>", desc = "Leaderf self" },
        { "<leader>Fr", "<Plug>LeaderfGtagsReference<CR>", desc = "Leader gtsgs reference" },
    },
}
