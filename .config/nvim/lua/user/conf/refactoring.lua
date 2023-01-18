local status_ok, refactoring = pcall(require, "refactoring")
if not status_ok then
    vim.notify("refactoring not found!")
    return
end

-- 没搞懂这个插件怎么用
refactoring.setup({
    -- default is all false
    prompt_func_return_type = {
        python = true,
        lua = true,
    },
    prompt_func_param_type = {
        python = true,
        lua = true,
    },
    printf_statements = {},
    print_var_statements = {},
})
