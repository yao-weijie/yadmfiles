local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("lspconfig not found!")
    return
end

require("user.lsp.handlers").setup()
require("user.lsp.lspsaga")
require("user.lsp.lsp-signature")
require("user.lsp.trouble")
require("user.lsp.null-ls")

-- require("user.lsp.settings.rime-ls")
