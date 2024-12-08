---@type LazySpec
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jedi_language_server = {},
                basedpyright = {},
                ruff = {
                    init_options = {
                        settings = {
                            -- Server settings should go here
                        },
                    },
                },
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        opts = {
            configurations = {
                python = {
                    {
                        type = "python",
                        name = "Python: Launch file",
                        request = "launch",
                        program = "${file}",
                    },
                },
            },
        },
    },
}
