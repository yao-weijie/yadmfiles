---@type lspconfig.Config
return {
    settings = {
        basedpyright = {
            analysis = {
                autoImportCompletions = false,
                disableOrganizeImports = true,
            },
        },
    },
}
