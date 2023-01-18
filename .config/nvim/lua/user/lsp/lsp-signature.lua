local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then
    vim.notify("lsp_signature not found!")
    return
end

vim.g.winline = vim.fn.winline()
vim.g.winheight = vim.fn.winheight(0)

vim.cmd([[
    augroup _cursorpos
        autocmd!
        " autocmd VimEnter * lua vim.g.winline = vim.fn.winline() vim.g.winheight = vim.fn.winheight(0)
        autocmd WinEnter,InsertEnter * lua vim.g.winline = vim.fn.winline() vim.g.winheight = vim.fn.winheight(0)
    augroup end
]])

local function cal_offset_y(float_opts)
    local pumheight = vim.o.pumheight
    local winline = vim.g.winline
    local winheight = vim.g.winheight
    local float_height = float_opts.height

    -- print(pumheight, winline, winheight, float_height)

    -- window top
    if float_height < winline then
        -- if vim.bo.filetype == "python" then
        --     return 2
        -- end
        return 0
    end

    if winline - 1 < pumheight then
        return pumheight
    end

    -- window bottom
    if winheight - winline < pumheight then
        return -pumheight
    end

    return 0
end

lsp_signature.setup({
    verbose = false,

    bind = false,
    handler_opts = {
        -- border = "single",
        border = nil,
    },
    max_height = 10,
    max_width = 80,
    wrap = true,
    doc_lines = 5,

    floating_window = true,
    floating_window_above_cur_line = true,
    floating_window_off_x = 0,
    -- floating_window_off_y = cal_offset_y,
    floating_window_off_y = 0,
    close_timeout = 4000,
    fix_pos = false,
    zindex = 50,
    padding = "",

    hint_enable = false,
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
})
