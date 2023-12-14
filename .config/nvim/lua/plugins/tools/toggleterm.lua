return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = { "VeryLazy" },
    opts = {
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = {
            -- width = 80,
            -- height = 40,
            width = function(_term)
                local width = math.ceil(vim.o.columns / 2)
                _term.float_opts.col = vim.o.columns - width
                return width
            end,
            height = function(_term)
                local height = math.ceil(vim.o.lines / 2)
                _term.float_opts.row = 0
                return height
            end,
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
            if not vim.pathlib.executable("gitui") then
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
