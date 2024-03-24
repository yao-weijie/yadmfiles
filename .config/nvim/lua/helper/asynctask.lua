local M = {}

-- fork from https://github.com/deathmaz/fzf-lua-asynctasks/blob/main/lua/fzf-lua-asynctasks/init.lua

local default_action = function(choice)
    local command = "AsyncTask " .. choice[1]
    vim.api.nvim_exec(command, false)
end

local default_opts = {
    prompt = "AsyncTask❯ ",
    actions = {
        ["default"] = default_action,
    },
    winopts = {
        height = 0.4,
        width = 0.5,
    },
}

M.fzf_select = function()
    local fzf_lua_installed, fzf_lua = pcall(require, "fzf-lua")
    if not fzf_lua_installed then
        print("fzf lua is not installed")
        return
    end

    local opts = fzf_lua.config.normalize_opts({}, default_opts)
    local rows = vim.fn["asynctasks#source"](math.floor(vim.go.columns * 0.5))
    fzf_lua.fzf_exec(function(cb)
        for _, e in ipairs(rows) do
            local color = fzf_lua.utils.ansi_codes
            local line = color.green(e[1]) .. " " .. color.cyan(e[2]) .. ": " .. color.yellow(e[3])
            cb(line)
        end
        cb()
    end, opts)
end

-- dressing 代理
M.ui_select = function()
    local rows = vim.fn["asynctasks#source"](math.floor(vim.go.columns * 0.5))
    vim.ui.select(rows, {
        prompt = "AsyncTask❯ ",
        format_item = function(choice)
            return table.concat(choice, "\t")
        end,
    }, default_action)
end

M.select = function(backend)
    if backend == "fzf" then
        M.fzf_select()
    else
        M.ui_select()
    end
end

--------------------------------------------------------------------------------
-- fork from https://github.com/skywind3000/asyncrun.vim/blob/master/lua/asyncrun_toggleterm.lua

M.asyncrun_destroy = function()
    if M._asyncrun_term ~= nil then
        if vim.g.asynctasks_term_reuse ~= 1 then
            -- TODO: handle multiple terminals
            error("Terminal existed is not support . please set g.asynctasks_term_reuse = 1")
        else
            vim.notify("Delete existing terminal", "info")
        end
        M._asyncrun_term:shutdown()
    end

    M._asyncrun_term = nil
end

M.asyncrun_toggle = function()
    if M._asyncrun_term ~= nil then
        M._asyncrun_term:toggle()
    end
end

M.asyncrun_runner = function(opts)
    M.asyncrun_destroy()
    M._asyncrun_term = require("toggleterm.terminal").Terminal:new({
        cmd = opts.cmd,
        dir = opts.dir,
        close_on_exit = false,
        hidden = false,
        float_opts = M._asyncrun_term_opts.float_opts,
        on_open = function(term)
            if M._asyncrun_term_opts.start_in_insert then
                vim.cmd("startinsert!")
            else
                vim.cmd("stopinsert!")
            end
        end,
        on_exit = function()
            vim.notify("AsyncTask Done!")
        end,
    })
    if not opts.silent then
        M.asyncrun_toggle()
    end
end

M.toggleterm_setup = function(opts)
    M._asyncrun_term_opts = opts

    if M._asyncrun_term_opts.mapping then
        vim.keymap.set("n", M._asyncrun_term_opts.mapping, M.asyncrun_toggle, {})
    end
end

return M
