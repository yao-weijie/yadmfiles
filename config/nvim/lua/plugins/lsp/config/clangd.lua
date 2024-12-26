-- vim.g.clangd_jobs = 8
-- vim.g.clangd_pch_storage = "memory" ---@type 'disk'|'memory'
-- vim.g.clangd_db_path = ".vscode"

return {
    cmd = {
        "clangd",
        "--enable-config", -- load .clangd or ~/.config/clangd/config.yaml
        "-j=" .. (vim.g.clangd_jobs or 8),
        "--background-index",
        "--pch-storage=" .. (vim.g.clangd_pch_storage or "memory"),

        "--clang-tidy",

        "--all-scopes-completion=false",

        "--header-insertion=never", -- auto insert header: iwyu/never
        -- "--header-insertion-decorators=true",
        "--completion-style=bundled", -- detailed/bundled
        "--function-arg-placeholders",
        "--offset-encoding=utf-8",
    },
    capabilities = {
        offsetEncoding = { "utf-8" },
    },
    -- on_attach = function(client, bufnr)
    --     -- require("clangd_extensions.inlay_hints").setup_autocmd()
    --     -- require("clangd_extensions.inlay_hints").set_inlay_hints()
    -- end,
    init_options = {
        compilationDatabasePath = vim.g.clangd_db_path or ".vscode",
        fallbackFlags = {
            "-std=c++17",
        },
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    settings = {
        clangd = {
            -- compilationDatabaseChanges = {},
            checkUpdates = false,
            detectExtensionConflicts = true,
            enable = true,
            enableCodeCompletion = true,
            enableHover = true,
            inactiveRegions = {
                opacity = 0.55,
                useBackgroundHighlight = false,
            },
            onConfigChanged = "prompt",
            path = "clangd",
            restartAfterCrash = true,
            semanticHighlighting = true,
            serverCompletionRanking = true,
            -- trace
            InlayHints = {
                Enabled = true,
                Designators = true,
                ParameterNames = true,
                DeducedTypes = true,
            },
        },
    },
}
