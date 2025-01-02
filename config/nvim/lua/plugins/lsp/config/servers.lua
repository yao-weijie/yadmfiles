local servers = {}

--nvim
servers.lua_ls = {
    settings = {
        Lua = {
            hint = { enable = true },
        },
    },
}
servers.vimls = {}

-- python
servers.jedi_language_server = require("plugins.lsp.config.jedi_language_server")
servers.basedpyright = require("plugins.lsp.config.basedpyright")
servers.ruff = {}

servers.clangd = require("plugins.lsp.config.clangd")

servers.neocmake = {
    init_options = {
        format = {
            enable = true,
        },
        lint = {
            enable = true,
        },
    },
}

-- latex
servers.texlab = {}

-- bash
servers.bashls = {}

return servers
