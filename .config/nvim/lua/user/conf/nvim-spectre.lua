local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
    vim.notify("spectre not found!")
    return
end

spectre.setup({
    color_devicons = true,
    open_cmd = "vnew",
    live_update = false, -- auto excute search again when you write any file in vim
    line_sep_start = "-----------------------------------------",
    result_padding = "  ",
    line_sep = "-----------------------------------------",
    highlight = {
        ui = "String",
        search = "DiffDelete",
        replace = "DiffAdd",
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
            map = "o",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "goto current file",
        },
        -- 查看菜单（忽略大小写、忽略隐藏文件）
        ["show_option_menu"] = {
            map = "<leader>o",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show option",
        },
        -- 开始替换
        ["run_replace"] = {
            map = "<leader>r",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all",
        },
        -- 显示差异
        ["change_view_mode"] = {
            map = "<leader>v",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode",
        },
    },
})
require("which-key").register({
    ["<C-r>"] = { "<cmd>Spectre<CR>", "global replace with rg" },
}, {})
