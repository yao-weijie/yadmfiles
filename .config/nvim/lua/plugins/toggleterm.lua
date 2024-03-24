return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = { "VeryLazy" },
    opts = {
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = {
            width = 120,
            height = 30,
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        local create_cmd = vim.api.nvim_create_user_command
        local Terminal = require("toggleterm.terminal").Terminal
        local float_opts = {
            border = "none",
            width = function()
                return vim.o.columns
            end,
            height = function()
                return vim.o.lines
            end,
        }

        local lazygit = Terminal:new({ cmd = "lazygit", hidden = false, float_opts = float_opts })
        create_cmd("LazyGit", function()
            lazygit:toggle()
        end, {})

        local gitui = Terminal:new({ cmd = "gitui", hidden = false, float_opts = float_opts })
        create_cmd("GitUI", function()
            if not _G.pathlib.executable("gitui") then
                vim.cmd([[MasonInstall gitui]])
            end
            gitui:toggle()
        end, {})
    end,
    keys = {
        { "<leader>gl", "<cmd>LazyGit<CR>" },
        { "<leader>gg", "<cmd>GitUI<CR>" },
    },
}
