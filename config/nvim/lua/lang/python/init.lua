-- _G.LangSetup({
--     filetypes = { "python" },
--     dap = {
--         ---@type DebugpyConfig[]
--         configurations = {
--             {
--                 type = "debugpy",
--                 name = "Python: Launch file",
--                 request = "launch",
--                 program = "${file}",
--             },
--         },
--     },
-- })

_G.setup_dap({ "python" }, {
    {
        type = "debugpy",
        name = "Python: Launch file",
        request = "launch",
        program = "${file}",
    },
})

---@type LazySpec
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jedi_language_server = {
                    init_options = {
                        markupKindPreferred = "markdown",
                        jediSettings = {
                            autoImportModules = { "numpy", "pandas", "torch" },
                        },
                    },
                },
                -- basedpyright = {
                --     settings = {
                --         basedpyright = {
                --             analysis = {
                --                 autoImportCompletions = false,
                --                 disableOrganizeImports = true,
                --             },
                --         },
                --     },
                -- }
                ruff = {},
            },
        },
    },

    -- {
    --     "linux-cultist/venv-selector.nvim",
    --     branch = "regexp",
    --     ft = { "python" },
    --     lazy = false,
    --     opts = {},
    -- },
    -- {
    --     dir = "~/.config/nvim/lua/lang/python/conda.lua",
    --     ft = { "python" },
    --     opts = {},
    --     config = function(_, opts)
    --         require("lang.python.conda").setup(opts)
    --     end,
    -- },
    -- {
    --     dir = "~/.config/nvim/lua/lang/python/lcode.lua",
    --     ft = { "python" },
    --     opts = {},
    --     config = function(_, opts)
    --         require("lang.python.lcode").setup(opts)
    --     end,
    -- },
}
