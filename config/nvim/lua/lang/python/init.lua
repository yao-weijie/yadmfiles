---@type LazySpec
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jedi_language_server = {
                    init_options = {
                        jediSettings = {
                            autoImportModules = { "numpy", "pandas", "torch" },
                        },
                    },
                },
                -- → basedpyright.analysis.autoImportCompletions           default: true
                -- → basedpyright.analysis.autoSearchPaths                 default: true
                -- → basedpyright.analysis.diagnosticMode                  default: "openFilesOnly"
                -- → basedpyright.analysis.diagnosticSeverityOverrides
                -- → basedpyright.analysis.exclude                         default: []
                -- → basedpyright.analysis.extraPaths                      default: []
                -- → basedpyright.analysis.ignore                          default: []
                -- → basedpyright.analysis.include                         default: []
                -- → basedpyright.analysis.inlayHints.callArgumentNames    default: true
                -- → basedpyright.analysis.inlayHints.functionReturnTypes  default: true
                -- → basedpyright.analysis.inlayHints.genericTypes         default: false
                -- → basedpyright.analysis.inlayHints.variableTypes        default: true
                -- → basedpyright.analysis.logLevel                        default: "Information"
                -- → basedpyright.analysis.stubPath                        default: "typings"
                -- → basedpyright.analysis.typeCheckingMode                default: "recommended"
                -- → basedpyright.analysis.typeshedPaths                   default: []
                -- → basedpyright.analysis.useLibraryCodeForTypes          default: true
                -- → basedpyright.disableLanguageServices                  default: false
                -- → basedpyright.disableOrganizeImports                   default: false
                -- → basedpyright.disableTaggedHints                       default: false
                -- → basedpyright.importStrategy                           default: "fromEnvironment"
                -- → python.pythonPath                                     default: "python"
                -- → python.venvPath                                       default: ""
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {},
                        },
                    },
                },
                ruff = {
                    init_options = {},
                    settings = {
                        -- Server settings should go here
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
