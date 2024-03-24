vim.cmd([[
    highlight! MySpectreSearch guifg=white guibg=#db4b4b
    highlight! MySpectreReplace guifg=gray guibg=lightgreen
]])

return {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>R", "<cmd>Spectre<CR>", desc = "search and replace" },
    },
    opts = {
        highlight = {
            ui = "String",
            search = "MySpectreSearch",
            replace = "MySpectreReplace",
        },
        mapping = {
            -- 删除选中
            ["toggle_line"] = {
                map = "dd",
                cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                desc = "toggle current item",
            },
            -- 前往文件
            ["enter_file"] = {
                map = "gf",
                cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                desc = "goto current file",
            },
            -- 查看菜单（忽略大小写、忽略隐藏文件）
            ["show_option_menu"] = {
                map = "ga",
                cmd = "<cmd>lua require('spectre').show_options()<CR>",
                desc = "show option",
            },
            -- 开始替换
            ["run_replace"] = {
                map = "R",
                cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                desc = "replace all",
            },
            -- 显示差异
            ["change_view_mode"] = {
                map = "D",
                cmd = "<cmd>lua require('spectre').change_view()<CR>",
                desc = "change result view mode",
            },
            ["send_to_qf"] = {
                map = "<leader>Q",
                cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                desc = "send all item to quickfix",
            },
            ["run_current_replace"] = {
                map = "r",
                cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
                desc = "replace current line",
            },
            ["toggle_live_update"] = {
                map = "tu",
                cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
                desc = "update change when vim write file.",
            },
            ["toggle_ignore_case"] = {
                map = "tc",
                cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
                desc = "toggle ignore case",
            },
            ["toggle_ignore_hidden"] = {
                map = "th",
                cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
                desc = "toggle search hidden",
            },

            -- unused
            ["replace_cmd"] = {
                map = "<leader>c",
                cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
                desc = "input replace vim command",
            },
        },
    },
}
