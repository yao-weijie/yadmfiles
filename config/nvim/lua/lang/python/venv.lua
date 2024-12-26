local M = {}
local Job = require("plenary.job")

local cwd = vim.loop.cwd()

local function get_version(bin)
    -- Python x.xx.x
    local ret = vim.trim(vim.fn.system(bin .. " -V"))
    return ret:match("[%d.]*$")
end

-- CONDA_SHLVL 环境变量标志是否有conda环境激活
-- VIRTUAL_ENV 环境变量标志是否有venv激活
-- CONDA_DEFAULT_ENV 激活后的 conda 环境名称

local default_opts = {
    conda_root = {
        vim.fs.normalize("~/anaconda3"),
        vim.fs.normalize("~/miniconda3"),
    },
    sys_python = {
        -- "/usr/",
        "/usr/bin/python3",
        "/usr/bin/python2",
    },
    venv_pattern = {
        ".venv",
        "venv",
    },
}

---@class pyEnv
---@field type "conda"|"system"|"venv"
---@field bin string
---@field name string
---@field version string
---@field path string

PYTHON_ENVS = {} ---@type pyEnv[]
curr_env = nil ---@type pyEnv

M.setup = function(opts)
    opts = vim.tbl_extend("force", default_opts, opts or {})

    vim.schedule(function()
        local environ = vim.fn.environ()
        local curr_python_bin = vim.fn.system("which python")

        -- conda
        for _, root in ipairs(opts.conda_root) do
            local conda_bin = vim.fs.joinpath(root, "bin/conda")
            if _G.pathlib.executable(conda_bin) then
                local result = vim.fn.system({ conda_bin, "env", "list", "--json" })
                local envs_list = vim.json.decode(result).envs ---@type string[]
                for i, env_path in ipairs(envs_list) do
                    local env_name = (i == 1) and "base" or env_path:match("/([%w_-]+)$")
                    local bin = env_path .. "/bin/python"

                    local env = {
                        type = "conda",
                        name = env_name,
                        path = env_path,
                        bin = bin,
                        version = get_version(bin),
                    }
                    table.insert(PYTHON_ENVS, env)
                    if curr_python_bin == env.bin then
                        curr_env = env
                    end
                    -- if environ.CONDA_SHLVL == 1 and environ.CONDA_PYTHON_EXE == env.bin then
                    --     curr_env = env
                    -- end
                end
            end
        end

        -- venv
        for _, pattern in pairs(opts.venv_pattern) do
            local venv_root = _G.pathlib.join(cwd, pattern)
            local act_bin = _G.pathlib.join(venv_root, "bin/activate")
            local venv_bin = _G.pathlib.join(venv_root, "bin/python")
            if _G.pathlib.dir_exist(venv_root) and _G.pathlib.file_exist(act_bin) then
                local env = {
                    type = "venv",
                    name = pattern,
                    path = venv_root,
                    bin = venv_bin,
                    version = get_version(venv_bin),
                }
                table.insert(PYTHON_ENVS, env)
                if curr_python_bin == env.bin then
                    curr_env = env
                end
                -- if environ.VIRTUAL_ENV and environ.VIRTUAL_ENV == env.path then
                --     curr_env = env
                -- end
            end
        end

        -- system
        for _, bin in pairs(opts.sys_python) do
            if _G.pathlib.executable(bin) then
                local env = {
                    type = "system",
                    name = "python",
                    path = bin,
                    bin = bin,
                    version = get_version(bin),
                }
                table.insert(PYTHON_ENVS, env)
                if curr_python_bin == env.bin then
                    curr_env = env
                end
                -- if curr_env == nil then
                --     curr_env = env
                -- end
            end
        end
    end)
end

M.set_env = function(env)
    --
    curr_env = env
end

M.select_env = function()
    vim.ui.select(PYTHON_ENVS, {
        prompt = "Python Env ❯ ",
        format_item = function(choice)
            return table.concat(choice, "\t")
        end,
    }, M.set_env)
end

M.get_curr_env = function()
    --
end

return M
