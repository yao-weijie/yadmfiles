return {
    cmd = {
        "clangd",
        -- 同时开启的任务数量
        "-j=8",
        -- 读取项目本地.clangd 配置文件,或者~/.config/clangd/config.yaml
        "--enable-config",
        -- 开启clang-tidy
        "--clang-tidy",

        -- 在后台自动分析文件（基于complie_commands)
        "--background-index",
        -- 标记compelie_commands.json文件的目录位置
        -- 补全依赖这个json文件,否则不能补全
        "--compile-commands-dir=build",

        -- 补充头文件的形式
        "--header-insertion=iwyu",
        -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
        "--header-insertion-decorators",
        -- detailed: 更详细的补全内容
        "--completion-style=detailed",
        -- pch优化的位置disk/memory
        "--pch-storage=disk",

        -- 这两项在LazyVim配置中找到的
        -- "--function-arg-placeholders",
        -- "--fallback-style=llvm",
    },
}
