_G.toolset = _G.toolset or {}

for _, cmd in ipairs({ "Install", "Uninstall" }) do
    vim.api.nvim_create_user_command("Toolset" .. cmd, function(opts)
        for _, name in ipairs(opts.fargs) do
            -- lsp
            local servers = _G.toolset[name].server or {}
            for _, s in ipairs(servers) do
                vim.cmd(("Lsp%s %s"):format(cmd, s))
            end

            -- dap
            local adapters = _G.toolset[name].adapters or {}
            for _, d in ipairs(adapters) do
                vim.cmd(("Dap%s %s"):format(cmd, d))
            end

            -- sources
            local sources = _G.toolset[name].sources or {}
            for _, s in ipairs(sources) do
                vim.cmd(("NullLs%s %s"):format(cmd, s.name))
            end
        end
    end, {
        nargs = "+",
        complete = function(ArgLead, CmdLine, CursorPos)
            return vim.tbl_keys(_G.toolset)
        end,
    })
end

return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "jay-babu/mason-null-ls.nvim", lazy = true, config = true },
        config = true,
    },
}
