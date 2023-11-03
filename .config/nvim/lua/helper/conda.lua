local M = {}
local Job = require("plenary.job")

-- CONDA_SHLVL 环境变量标志是否有conda环境激活
-- VIRTUAL_ENV 环境变量标志是否有venv激活

local opts = {
    conda_root = {
        vim.fn.expand("~/anaconda3"),
        vim.fn.expand("~/miniconda3"),
    },
    sys_python = {
        "/usr/bin/python3",
    },
    venv_pattern = {
        ".venv",
        "venv",
    },
}

local env = {
    ---@type string
    type = "conda", -- system, conda, venv
    ---@type string
    bin = "",
    ---@type string
    name = "",
}

local envs = {}

for _, root in ipairs(opts.conda_root) do
    local bin = root .. "/bin/conda"
    if vim.fn.executable(bin) == 1 then
        local envs_tbl
        Job:new({
            command = bin,
            args = { "env", "list", "--json" },
            on_exit = function(j, _)
                local result = table.concat(j:result(), "\n")
                envs_tbl = vim.json.decode(result)["envs"]
            end,
        }):sync()

        for i, env in ipairs(envs_tbl) do
            --
        end
    end
end

return M
