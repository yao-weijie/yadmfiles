---@type lspconfig.Config
return {
    init_options = {
        markupKindPreferred = "markdown",
        jediSettings = {
            autoImportModules = { "numpy", "pandas", "torch" },
        },
    },
}
