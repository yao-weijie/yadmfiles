-- a fork of https://github.com/theniceboy/antovim.git

local fn = vim.fn

-- True False TRUE FALSE true false
local antovim_definitions = {
    { "true", "false" },
    { "yes", "no" },
    { "do", "undo" },
    { "get", "set" },
    { "increase", "decrease" },
    { "input", "output" },
    { "left", "right" },
    { "allow", "deny" },
    { "maximum", "minimum" },
    { "max", "min" },
    { "begin", "end" },
    { "high", "low" },
    { "global", "local" },
    { "on", "off" },
    { "todo", "done" },
}

local function antovim_swap()
    local dicts

    if vim.b.antovim_definitions_extra then
        dicts = vim.tbl_extend("force", antovim_definitions, vim.b.antovim_definitions_extra)
    else
        dicts = antovim_definitions
    end

    local cword = fn.expand("<cword>")

    local s_type = 0
    -- 全大写
    if cword == cword:upper() then
        s_type = 2
    -- 首字母大写
    elseif cword:sub(1, 1) == cword:sub(1, 1):upper() then
        s_type = 1
    end

    cword = cword:lower()

    for _, d in ipairs(dicts) do
        -- 1~n
        local idx = fn.index(d, cword) + 1

        if idx > 0 then
            local subs
            -- 最后一个
            if idx == #d then
                subs = d[1]
            else
                subs = d[idx + 1]
            end

            if s_type == 2 then
                subs = subs:upper()
            elseif s_type == 1 then
                subs = subs:sub(1, 1):upper() .. subs:sub(2, #subs)
            end

            vim.cmd("normal! ciw" .. subs)
            break
        end
    end
end

vim.api.nvim_create_user_command("AntoVim", antovim_swap, {})
vim.keymap.set("n", "gs", antovim_swap, { desc = "反义词" })

return {}
