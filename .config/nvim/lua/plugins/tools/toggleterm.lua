return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = { "VeryLazy" },
    opts = {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = false,
        shade_filetypes = {},
        shade_terminals = false,
        shading_factor = 3,
        start_in_insert = true,
        insert_mappings = false,
        persist_size = false,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
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
            border = "curved",
            winblend = 3,
            width = vim.o.columns,
            height = vim.o.lines,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        }

        local lazygit = Terminal:new({ cmd = "lazygit", hidden = false, float_opts = float_opts })
        create_cmd("LazyGit", function()
            lazygit:toggle()
        end, {})
        local gitui = Terminal:new({ cmd = "gitui", hidden = false, float_opts = float_opts })
        create_cmd("GitUI", function()
            gitui:toggle()
        end, {})
        local btop = Terminal:new({ cmd = "btop", hidden = false, float_opts = float_opts })
        create_cmd("Btop", function()
            btop:toggle()
        end, {})
        local ranger = Terminal:new({ cmd = "ranger", hidden = false, float_opts = float_opts })
        create_cmd("Ranger", function()
            ranger:toggle()
        end, {})
    end,
}
