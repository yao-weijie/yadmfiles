local status_ok, tmux = pcall(require, "tmux")
if not status_ok then
    vim.notify("tmux not found!")
    return
end

tmux.setup({
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    copy_sync = {
        -- enables copy sync and overwrites all register actions to
        -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
        enable = true,
    },
    navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,

        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,

        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,

        -- sets resize steps for x axis
        resize_step_x = 5,

        -- sets resize steps for y axis
        resize_step_y = 5,
    },
})
