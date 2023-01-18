local curr_dir = vim.fn.stdpath("config") .. "/lua/user/lang/"

local toolsets = {}

local function setup_sources(sources)
    if sources == nil then
        return
    end
    local null_ls = require("null-ls")

    for _, source in ipairs(sources) do
        null_ls.register(source)
    end
end

local function install_toolset(name, inst_type)
    -- inst_type: Install, Uninstall
    local toolset = toolsets[name]
    local getPackageFromNullLs = require("mason-null-ls.mappings.source").getPackageFromNullLs
    local availableSources = require("mason-null-ls").get_available_sources({})
    -- lsp
    if toolset.server ~= nil then
        for _, s in ipairs(toolset.server) do
            vim.cmd(string.format("Lsp%s %s", inst_type, s))
        end
    end
    -- dap
    if toolset.dap_adapter ~= nil then
        for _, d in ipairs(toolset.dap_adapter) do
            vim.cmd(string.format("Dap%s %s", inst_type, d))
        end
    end
    -- null-ls
    if toolset.sources ~= nil then
        for _, s in ipairs(toolset.sources) do
            local pkg = getPackageFromNullLs(s.name)
            if vim.tbl_contains(availableSources, pkg) then
                vim.cmd(string.format("NullLs%s %s", inst_type, pkg))
            end
        end
    end
    -- treesitter
    if toolset.treesitter ~= nil then
        local inst_type_
        if inst_type == "Install" then
            inst_type_ = "Install!"
        else
            inst_type_ = "Uninstall"
        end
        for _, t in ipairs(toolset.treesitter) do
            vim.cmd(string.format("TS%s %s", inst_type_, t))
        end
    end
end

local function get_toolset_name(ArgLead, CmdLine, CursorPos)
    local set = {}
    for name, _ in pairs(toolsets) do
        table.insert(set, name)
    end
    return set
end

local create_command = vim.api.nvim_create_user_command
-- define ToolsetInstall, ToolsetUninstall
for _, cmd in ipairs({ "Install", "Uninstall" }) do
    create_command("Toolset" .. cmd, function(opts)
        for _, name in ipairs(opts.fargs) do
            install_toolset(name, cmd)
        end
    end, {
        nargs = "+",
        complete = get_toolset_name,
    })
end

local function setup(toolset)
    setup_sources(toolset.sources)
end

local ignore_files = {
    "init.lua",
    "README.md",
}

for _, fname in pairs(vim.fn.readdir(curr_dir)) do
    if not vim.tbl_contains(ignore_files, fname) then
        local fpath = "user.lang." .. vim.fn.fnamemodify(fname, ":r")
        local toolset = require(fpath)
        toolsets[toolset.name] = toolset
        setup(toolset)
    end
end
