vim.g.autoformat = true
vim.g.editorconfig = true
vim.g.enable_endhints = true

-- cpp projects
vim.g.dap_cpp_exec_filter = nil
vim.g.dap_cpp_exec_dir = "build"

vim.g.clangd_jobs = 8
vim.g.clangd_pch_storage = "memory" ---@type 'disk'|'memory'
vim.g.clangd_db_path = ".vscode"
