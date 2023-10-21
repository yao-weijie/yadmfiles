return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = { "VeryLazy" },
    opts = {
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = {
            border = "single",
            winblend = 3,
            width = 90,
            height = 40,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        local create_cmd = vim.api.nvim_create_user_command
        local Terminal = require("toggleterm.terminal").Terminal
        local float_opts = {
            border = "none",
            winblend = 3,
            width = vim.o.columns,
            height = vim.o.lines,
        }

        local lazygit = Terminal:new({ cmd = "lazygit", hidden = false, float_opts = float_opts })
        create_cmd("LazyGit", function()
            lazygit:toggle()
        end, {})
        vim.keymap.set("n", "<leader>gl", "<cmd>LazyGit<CR>", {})

        local gitui = Terminal:new({ cmd = "gitui", hidden = false, float_opts = float_opts })
        create_cmd("GitUI", function()
            if vim.fn.executable("gitui") ~= 1 then
                vim.cmd([[MasonInstall gitui]])
            end
            gitui:toggle()
        end, {})
        vim.keymap.set("n", "<leader>gg", "<cmd>GitUI<CR>", {})
    end,
}
