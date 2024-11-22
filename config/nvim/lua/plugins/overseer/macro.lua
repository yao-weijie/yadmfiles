-- :p    expand to full path
-- :h    head (last path component removed)
-- :t    tail (last path component only)
-- :r    root (one extension removed)
-- :e    extension only

local MACROS = {
    VIM_FILEPATH = function()
        return vim.fn.expand("%:p")
    end,
    VIM_FILENAME = function()
        return vim.fn.expand("%:t")
    end,
    VIM_FILEDIR = function()
        return vim.fn.expand("%:h")
    end,
    VIM_FILEEXT = function()
        return vim.fn.expand("%:e")
    end,
    VIM_FILENOEXT = function()
        return vim.fn.expand("%:t:r")
    end,
    VIM_PATHNOEXT = function()
        return vim.fn.expand("%:p:r")
    end,
    VIM_CWD = function()
        return vim.uv.cwd()
    end,
    VIM_RELDIR = function()
        return vim.fn.expand("%:h")
    end,
    VIM_RELNAME = function()
        local cwd = vim.uv.cwd()
        local fpath = vim.fn.expand("%:p")
        return fpath:sub(#cwd + 2)
    end,
    VIM_ROOT = function()
        local markers = vim.g.ROOT_MARKERS or { ".git", ".hg", ".svn", ".root", ".project", "Makefile" }
        vim.fs.find(markers, {
            path = vim.uv.cwd(),
        })
    end,
    VIM_CWORD = function()
        return vim.fn.expand("<cword>")
    end,
    VIM_CFILE = function()
        return vim.fn.expand("<cfile>")
    end,
    VIM_GUI = function()
        return vim.fn.has("gui_running") == 1
    end,
}

-- M.VIM_VERSION   -- Value of v:version
-- M.VIM_COLUMNS   -- How many columns in vim's screen
-- M.VIM_LINES     -- How many lines in vim's screen
-- M.VIM_SVRNAME   -- Value of v:servername for +clientserver usage

return MACROS
