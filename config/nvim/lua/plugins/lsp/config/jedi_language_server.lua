return {
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
