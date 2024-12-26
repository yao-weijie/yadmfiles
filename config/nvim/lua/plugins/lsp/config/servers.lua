local servers = {}

--nvim
servers.lua_ls = {
    settings = {
        Lua = {
            hint = { enable = true },
        },
    },
}
servers.vimls = {}

-- python
servers.jedi_language_server = {
    init_options = {
        codeAction = {
            nameExtractVariable = "jls_extract_var",
            nameExtractFunction = "jls_extract_def",
        },
        completion = {
            disableSnippets = false,
            resolveEagerly = false,
            ignorePatterns = {},
        },
        diagnostics = {
            enable = true,
            didOpen = true,
            didChange = true,
            didSave = true,
        },
        hover = {
            enable = true,
            disable = {
                class = { all = false, names = {}, fullNames = {} },
                ["function"] = { all = false, names = {}, fullNames = {} },
                instance = { all = false, names = {}, fullNames = {} },
                keyword = { all = false, names = {}, fullNames = {} },
                module = { all = false, names = {}, fullNames = {} },
                param = { all = false, names = {}, fullNames = {} },
                path = { all = false, names = {}, fullNames = {} },
                property = { all = false, names = {}, fullNames = {} },
                statement = { all = false, names = {}, fullNames = {} },
            },
        },
        jediSettings = {
            autoImportModules = { "numpy", "torch", "pandas", "pandas" },
            caseInsensitiveCompletion = true,
            debug = false,
        },
        markupKindPreferred = "markdown", ---@type 'markdown'|'plaintext'
        workspace = {
            extraPaths = {},
            -- environmentPath = "python",
            symbols = {
                ignoreFolders = { ".nox", ".tox", ".venv", "__pycache__", "venv" },
                maxSymbols = 20,
            },
        },
    },
}

servers.basedpyright = {
    settings = {
        python = {
            pythonPath = "python",
            venvPath = "",
        },
        basedpyright = {
            disableLanguageServices = false,
            disableOrganizeImports = true,
            disableTaggedHints = false,
            importStrategy = "fromEnvironment",
            analysis = {
                autoImportCompletions = false,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", ---@type 'openFilesOnly'|'workspace'
                diagnosticSeverityOverrides = {},
                exclude = {},
                extraPaths = {},
                ignore = {},
                include = {},
                inlayHints = {
                    callArgumentNames = true,
                    functionReturnTypes = true,
                    genericTypes = false,
                    variableTypes = true,
                },
                logLevel = "Information",
                stubPath = "typings",
                typeCheckingMode = "recommended",
                typeshedPaths = {},
                useLibraryCodeForTypes = true,
            },
        },
    },
}
servers.ruff = {}

servers.clangd = require("plugins.lsp.config.clangd")

servers.neocmake = {
    init_options = {
        format = {
            enable = true,
        },
        lint = {
            enable = true,
        },
    },
}

-- latex
servers.texlab = {}

-- bash
servers.bashls = {}

return servers
