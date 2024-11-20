local overseer = require("overseer")
local user_cmd = vim.api.nvim_create_user_command

vim.g.build_profile = "debug"

local ft_build_debug = {
    c = [[gcc      -g $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
    cpp = [[g++    -g $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
    rust = [[rustc -g $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
}
local ft_build_release = {
    c = [[gcc      -O2 $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
    cpp = [[g++    -O2 $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
    rust = [[rustc -O2 $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
}

local ft_build = {
    c = [[gcc $(g:_build_flag) $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
    cpp = [[g++ $(g:_build_flag) $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
    rust = [[rustc $(g:_build_flag) $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)]],
}

vim.g.build_profile = "debug" ---@type "debug"|"release"
if vim.g.build_profile == "debug" then
    vim.g._build_flag = "-g"
elseif vim.g.build_profile == "release" then
    vim.g._build_flag = "-O2"
else
    vim.g._build_flag = ""
end

-- local s = "gcc -g $(VIM_FILEPATH) -o $(VIM_FILEDIR)/build/$(VIM_FILENOEXT)"
-- for macro in s:gmatch("%$%([%u_]+%)") do
--     vim.print(macro)
-- end

for ft, v in pairs(ft_build_debug) do
    overseer.register_template({
        name = "file-build " .. ft,
        builder = function(params)
            os.execute("mkdir -p build/")
            local fname = vim.fn.expand("%:p")
            return {
                cmd = { "g++" },
                args = { fname },
                ---@type overseer.ComponentSkeleton
                components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
            }
        end,
        condition = {
            filetype = { ft },
            -- callback = function(search)
            --     return vim.bo.filetype == ft
            -- end,
        },
    })
end
