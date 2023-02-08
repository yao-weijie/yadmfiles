local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
    vim.notify("neoscroll not found!")
    return
end

neoscroll.setup({
    mappings = { "<C-u>", "<C-d>" },
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "75" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "75" } }

require("neoscroll.config").set_mappings(t)
