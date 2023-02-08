local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

vim.g.rime_enabled = false

-- register rime-ls
if not configs.rime_ls then
    configs.rime_ls = {
        default_config = {
            name = "rime-ls",
            cmd = { "rime_ls" },
            single_file_support = true,

            init_options = {
                enabled = false,
                shared_data_dir = "/usr/share/rime-data",
                user_data_dir = vim.fn.expand("~/.local/share/rime-ls"),
                log_dir = vim.fn.expand("~/.local/share/rime-ls/log"),
                max_candidates = 10,
                trigger_characters = {},
            },
        },
        settings = {},
        docs = {
            description = [[
https://www.github.com/wlh320/rime-ls

A language server for librime
]],
        },
    }
end

local function on_attach(client, bufnr)
    local function toggle_rime()
        client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
            if ctx.client_id == client.id then
                vim.g.rime_enabled = result
            end
        end)
    end

    vim.api.nvim_create_user_command("RimeLsSyncData", function()
        client.request("workspace/executeCommand", { command = "rime-ls.sync-user-data" })
    end, {})

    vim.keymap.set("i", "<C-r>", function()
        toggle_rime()
    end, { buffer = bufnr })
end

lspconfig.rime_ls.setup({
    on_attach = on_attach,
})
