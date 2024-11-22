local user_cmd = vim.api.nvim_create_user_command
local overseer = require("overseer")

local ft_run = {
    c = "$(VIM_FILEDIR)/build/$(VIM_FILENOEXT)",
    cpp = "$(VIM_FILEDIR)/build/$(VIM_FILENOEXT)",
    rust = "$(VIM_FILEDIR)/build/$(VIM_FILENOEXT)",
    python = "python -u $(VIM_FILENAME)",
    sh = "bash $(VIM_FILENAME)",
    zsh = "zsh $(VIM_FILENAME)",
    lua = "luajit $(VIM_FILENAME)",
}
