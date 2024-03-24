return {
    "ray-x/lsp_signature.nvim",
    opts = {
        verbose = false,

        bind = false,
        handler_opts = {
            border = "none",
        },
        max_height = 10,
        max_width = 80,
        wrap = true,
        doc_lines = 0,

        floating_window = false,
        floating_window_above_cur_line = true,
        floating_window_off_x = 0,
        -- floating_window_off_y = cal_offset_y,
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
        -- extra_trigger_chars = nil,
        extra_trigger_chars = { "(", "," },

        timer_interval = 200,
        toggle_key = "<M-p>",

        select_signature_key = nil,
        move_cursor_key = nil,
    },
}
