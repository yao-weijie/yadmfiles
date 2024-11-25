---@type table<string, lspconfig.Config>
local M = {}

M.bashls = {}

M.lua_ls = {}

M.vimls = {}

M.ruff = {}

M.jedi_language_server = {
    init_options = {
        markupKindPreferred = "markdown",
        jediSettings = {
            autoImportModules = { "numpy", "pandas", "torch" },
        },
    },
}

-- M.basedpyright = {
--     settings = {
--         basedpyright = {
--             analysis = {
--                 autoImportCompletions = false,
--                 disableOrganizeImports = true,
--             },
--         },
--     },
-- }

M.clangd = {
    cmd = {
        "clangd",

        -- 读取项目本地.clangd 配置文件,或者~/.config/clangd/config.yaml
        "--enable-config",

        -- 同时开启的任务数量
        "-j=" .. (vim.g.clangd_jobs and vim.g.clangd_jobs or 4),
        -- 在后台自动分析文件（基于complie_commands)
        "--background-index",
        -- 标记compelie_commands.json文件的目录位置
        -- 补全依赖这个json文件,否则不能补全
        "--compile-commands-dir=.vscode",
        -- pch优化的位置disk/memory
        "--pch-storage=disk",

        -- 开启clang-tidy, enable disgnostic
        "--clang-tidy",

        -- iwyu: include what you use; never: never auto insert
        "--header-insertion=iwyu",
        -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
        "--header-insertion-decorators=true",
        -- detailed: 更详细的补全内容; bundled: 合并相似条目
        "--completion-style=bundled",
        "--all-scopes-completion=true",
        "--function-arg-placeholders",
    },
    on_attach = function(client, bufnr)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
    end,
}

M.rust_analyzer = {}

return M
