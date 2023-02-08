local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    vim.notify("toggleterm not found!")
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = false,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 3,
    start_in_insert = true,
    insert_mappings = true,
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
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    local keymap = vim.keymap.set
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

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
local create_cmd = vim.api.nvim_create_user_command
local function check_cmd(term)
    if vim.fn.executable(term.cmd) == 0 then
        local msg = string.format("%s not found!", term.cmd)
        vim.notify(msg, vim.log.levels.ERROR)
    end
end

local lazygit = Terminal:new({ cmd = "lazygit", hidden = false, float_opts = float_opts })
local function _LAZYGIT_TOGGLE()
    check_cmd(lazygit)
    lazygit:toggle()
end
create_cmd("LazyGit", _LAZYGIT_TOGGLE, {})

local gitui = Terminal:new({ cmd = "gitui", hidden = false, float_opts = float_opts })
local function _GITUI_TOGGLE()
    check_cmd(gitui)
    gitui:toggle()
end
create_cmd("GitUI", _GITUI_TOGGLE, {})

local btop = Terminal:new({ cmd = "btop", hidden = false, float_opts = float_opts })
local function _BTOP_TOGGLE()
    check_cmd(btop)
    btop:toggle()
end
create_cmd("Btop", _BTOP_TOGGLE, {})

local ranger = Terminal:new({ cmd = "ranger", hidden = false, float_opts = float_opts })
local function _RANGER_TOGGLE()
    check_cmd(ranger)
    ranger:toggle()
end
create_cmd("Ranger", _RANGER_TOGGLE, {})
