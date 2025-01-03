vim.g.dap_cpp_exec_filter = nil
vim.g.dap_cpp_exec_dir = "build"

vim.g.clangd_jobs = 8
vim.g.clangd_pch_storage = "memory" ---@type 'disk'|'memory'
vim.g.clangd_db_path = ".vscode"

---@type LazySpec
return {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = {
        inline = true,
        show_parameter_hints = true,
    },
}
