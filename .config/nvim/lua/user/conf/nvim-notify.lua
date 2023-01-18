local status_ok, notify = pcall(require, "notify")
if not status_ok then
    vim.notify("notify module not found!")
    return
end

notify.setup({
    background_colour = "Normal",
    minimum_width = 20,
    max_width = 100,
    max_height = nil,
})
vim.notify = notify
