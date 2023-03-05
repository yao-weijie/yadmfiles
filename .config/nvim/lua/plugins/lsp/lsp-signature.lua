vim.cmd([[
    autocmd WinEnter,InsertEnter * lua vim.w.winline = vim.fn.winline() vim.w.winheight = vim.fn.winheight(0)
]])

local function cal_offset_y(float_opts)
    local pumheight = vim.o.pumheight
    local winline = vim.w.winline
    local winheight = vim.w.winheight
    local float_height = float_opts.height

    if float_height == nil and winline - 1 < pumheight then
        return pumheight
    end

    if winline - 1 < pumheight and winline < float_height then
        return pumheight
    end

    -- window bottom
    if winheight - winline < pumheight then
        return -pumheight
    end

    return 0
end

return { 
    "ray-x/lsp_signature.nvim",
    opts = {
        verbose = false,

        bind = false,
        handler_opts = {
            border = "single",
        },
        max_height = 10,
        max_width = 80,
        wrap = true,
        doc_lines = 0,

        floating_window = true,
        floating_window_above_cur_line = true,
        floating_window_off_x = 0,
        floating_window_off_y = cal_offset_y,
        close_timeout = 4000,
        fix_pos = true,
        zindex = 50,
        padding = "",

        hint_enable = true,
        hint_prefix = "🐼 ",
        hint_scheme = "String",
        hi_parameter = "IncSearch",

        always_trigger = false,
        auto_close_after = nil,
        extra_trigger_chars = nil,
        -- extra_trigger_chars = { "(", "," },

        timer_interval = 200,
        toggle_key = "<M-p>",

        select_signature_key = nil,
        move_cursor_key = nil,
    }
}

