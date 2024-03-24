local M = {}
local Job = require("plenary.job")
local Path = _G.pathlib
local cwd = vim.loop.cwd()

-- CONDA_SHLVL 环境变量标志是否有conda环境激活
-- VIRTUAL_ENV 环境变量标志是否有venv激活

local function get_version(bin)
    -- Python x.xx.x
    local res = vim.trim(vim.fn.system(bin .. " -V"))
    return string.match(res, "[%d.]*$")
end

local opts = {
    conda_root = {
        vim.fn.expand("~/anaconda3"),
        vim.fn.expand("~/miniconda3"),
    },
    sys_python = {
        "/usr/bin/python3",
        "/usr/bin/python2",
    },
    venv_pattern = {
        ".venv",
        "venv",
    },
}

local PYTHON_ENVS = {}
local curr_env

M.setup = function()
    for _, root in ipairs(opts.conda_root) do
        local conda_bin = root .. "/bin/conda"
        if _G.pathlib.executable(conda_bin) then
            local envs_tbl
            Job:new({
                command = conda_bin,
                args = { "env", "list", "--json" },
                on_exit = function(j, _)
                    local result = table.concat(j:result(), "\n")
                    envs_tbl = vim.json.decode(result)["envs"]
                end,
            }):sync()

            for i, env_path in ipairs(envs_tbl) do
                local env_name
                if i == 1 then
                    env_name = "base"
                else
                    env_name = string.match(env_path, "[%w_-]*$")
                end
                local bin = env_path .. "/bin/python"
                table.insert(PYTHON_ENVS, {
                    type = "conda",
                    name = env_name,
                    path = env_path,
                    bin = bin,
                    version = get_version(bin),
                })
            end
        end
    end

    for _, bin in pairs(opts.sys_python) do
        table.insert(PYTHON_ENVS, {
            type = "system",
            name = "python",
            path = bin,
            bin = bin,
            version = get_version(bin),
        })
    end

    for _, pattern in pairs(opts.venv_pattern) do
        local venv_root = Path.join({ cwd, pattern })
        local act_bin = venv_root .. "/bin/activate"
        local venv_bin = venv_root .. "/bin/python"
        if Path.dir_exist(venv_root) and Path.file_exist(act_bin) then
            table.insert(PYTHON_ENVS, {
                type = "venv",
                name = pattern,
                path = venv_root,
                bin = venv_bin,
                version = get_version(venv_bin),
                act_bin = act_bin,
            })
        end
    end
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
