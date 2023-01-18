local config_dir = vim.fn.stdpath("config") .. "/lua/user/conf"
local unload_plugins = {
    "init",
}

local helper_set = {}
for _, v in pairs(unload_plugins) do
    helper_set[v] = true
end

for _, fname in pairs(vim.fn.readdir(config_dir)) do
    if vim.endswith(fname, ".lua") then
        local cut_suffix_fname = fname:sub(1, #fname - #".lua")
        if helper_set[cut_suffix_fname] == nil then
            local file = "user.conf." .. cut_suffix_fname
            local status_ok, _ = pcall(require, file)
            if not status_ok then
                vim.notify("Failed loading " .. fname, vim.log.levels.ERROR)
            end
        end
    end
end
