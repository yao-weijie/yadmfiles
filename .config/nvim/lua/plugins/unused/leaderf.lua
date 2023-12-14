return {
    "Yggdroot/LeaderF",
    event = { "VeryLazy" },
    -- need to pip install pynvim
    build = ":LeaderfInstallCExtension",
    cond = vim.fn.has("python3") == 1,
    init = function()
        vim.g.Lf_ShortcutF = ""
        vim.g.Lf_ShortcutB = ""
        vim.g.Lf_ShowDevIcons = 1
        vim.g.Lf_WindowPosition = "popup"
        vim.g.Lf_PreviewInPopup = 1
        vim.g.Lf_ShowRelativePath = 1
        vim.g.Lf_RootMarkers = vim.g.ROOT_MARKERS
        vim.g.Lf_StlSeparator = { left = "", right = "" }
        vim.g.Lf_StlColorscheme = "powerline"

        vim.g.Lf_GtagsAutoGenerate = 1
        vim.g.Lf_Gtagslabel = "native-pygments"
    end,
    keys = {
        { "<leader>F/", "<cmd>Leaderf self<CR>", desc = "Leaderf self" },

        -- 这几个和telescope 功能基本重叠,可以不映射
        { "<leader>Ff", "<cmd>Leaderf file<CR>", desc = "file" },
        { "<leader>Fb", "<cmd>Leaderf buffer<CR>", desc = "buffer" },
        { "<leader>Fl", "<cmd>Leaderf line<CR>", desc = "current file line" },
        { "<leader>Fh", "<cmd>Leaderf help<CR>", desc = "help tags" },
        { "<leader>Fm", "<cmd>Leaderf mru<CR>", desc = "mru" },
        { "<leader>Fc", "<cmd>Leaderf command<CR>", desc = "command" },
        { "<leader>Fj", "<cmd>Leaderf jumps<CR>", desc = "jump list" },

        -- 代替内置的C-t
        { "<C-t>", "<cmd>Leaderf bufTag<CR>", desc = "current buf tags" },
        { "<leader>Ft", "<cmd>Leaderf bufTagAll<CR>", desc = "all buf tags" },

        { "<leader>FF", "<cmd>Leaderf function<CR>", desc = "function" },
        { "<leader>Fd", "<Plug>LeaderfGtagsDefinition", desc = "gtags definition" },
        { "<leader>Fr", "<Plug>LeaderfGtagsReference", desc = "gtags reference" },
    },
}
