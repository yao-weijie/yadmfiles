local rime_status = function()
    if vim.g.rime_available then
        return "ㄓ"
    else
        return "EN"
    end
end

local tabsize = function()
    return "tab:" .. vim.bo.shiftwidth
end

local buffers = {
    "buffers",
    mode = 2,
    max_length = function()
        return vim.o.columns
    end,
}

return {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy" },
    opts = {
        options = {
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            globalstatus = true,
            disabled_filetypes = {
                tabline = {
                    "NvimTree",
                    "neo-tree",
                },
            },
            ignore_focus = {
                "NvimTree",
                -- "neo-tree",
            },
        },

        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diagnostics" },
            lualine_c = {
                rime_status,
            },

            lualine_x = {
                tabsize,
                "encoding",
                "fileformat",
            },
            lualine_y = {
                "filetype",
            },
            lualine_z = {
                "progress",
                "filesize",
            },
        },
        tabline = {
            lualine_a = { buffers },
            lualine_z = { "tabs" },
        },
        extensions = {
            "aerial",
            "fzf",
            "lazy",
            "man",
            "mason",
            "neo-tree",
            "nvim-dap-ui",
            "nvim-tree",
            "quickfix",
            "toggleterm",
            "trouble",
        },
    },
    keys = {
        { "<leader>1", "<cmd>LualineBuffersJump 1<CR>", desc = "buffer 1" },
        { "<leader>2", "<cmd>LualineBuffersJump 2<CR>", desc = "buffer 2" },
        { "<leader>3", "<cmd>LualineBuffersJump 3<CR>", desc = "buffer 3" },
        { "<leader>4", "<cmd>LualineBuffersJump 4<CR>", desc = "buffer 4" },
        { "<leader>5", "<cmd>LualineBuffersJump 5<CR>", desc = "buffer 5" },
        { "<leader>6", "<cmd>LualineBuffersJump 6<CR>", desc = "buffer 6" },
        { "<leader>7", "<cmd>LualineBuffersJump 7<CR>", desc = "buffer 7" },
        { "<leader>8", "<cmd>LualineBuffersJump 8<CR>", desc = "buffer 8" },
        { "<leader>9", "<cmd>LualineBuffersJump 9<CR>", desc = "buffer 9" },
    },
}
