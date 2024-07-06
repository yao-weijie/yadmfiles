local args = {
    -- 同时开启的任务数量
    "-j=8",
    -- 读取项目本地.clangd 配置文件,或者~/.config/clangd/config.yaml
    "--enable-config",
    -- 开启clang-tidy, enable disgnostic
    "--clang-tidy",

    -- 在后台自动分析文件（基于complie_commands)
    "--background-index",
    -- 标记compelie_commands.json文件的目录位置
    -- 补全依赖这个json文件,否则不能补全
    "--compile-commands-dir=.vscode",

    -- 补充头文件的形式
    "--header-insertion=iwyu",
    -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
    "--header-insertion-decorators",
    -- detailed: 更详细的补全内容
    "--completion-style=detailed",
    -- pch优化的位置disk/memory
    "--pch-storage=disk",

    "--function-arg-placeholders",
}

---@type lspconfig.Config
return {
    cmd = {
        "clangd",
        unpack(args),
    },
    settings = {
        clangd = {
            -- arguments = args,
            -- arguments = {},
        },
    },
}
