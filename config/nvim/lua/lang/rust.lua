-- _G.LangSetup({
--     filetypes = { "rust" },
--     -- dap = {
--     --     configurations = {
--     --         {
--     --             type = "codelldb_rust",
--     --             name = "LLDB: Launch file",
--     --             request = "launch",
--     --             -- 编译输出目录在 cwd/build/,和asynctask中定义的一致
--     --             program = "${workspaceFolder}/build/${fileBasenameNoExtension}",
--     --             console = "integratedTerminal",
--     --             cwd = "${workspaceFolder}",
--     --             stopOnEntry = false,
--     --             runInTerminal = true,
--     --         },
--     --     },
--     -- },
-- })

_G.setup_dap({ "rust" }, {
    {
        type = "codelldb_rust",
        name = "LLDB: Launch file",
        request = "launch",
        -- 编译输出目录在 cwd/build/,和asynctask中定义的一致
        program = "${workspaceFolder}/build/${fileBasenameNoExtension}",
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
    },
})

return {
    { "neovim/nvim-lspconfig", opts = { servers = { rust_analyzer = {} } } },
}
