local M = {}

local default_opts = {
    language = "python",
    code_dir = "~/.config/lcode/code/",
    file_pattern = ".*/*.py",
}

M.setup = function(opts)
    opts = vim.tbl_extend("force", default_opts, opts or {})
end

return M
