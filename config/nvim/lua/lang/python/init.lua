---@type LazySpec
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jedi_language_server = {},
                basedpyright = {},
                ruff = {},
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        opts = {
            adapters = {
                python = {
                    type = "executable",
                    command = "python3",
                    args = {
                        "-m",
                        "debugpy.adapter",
                    },
                },
            },
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
