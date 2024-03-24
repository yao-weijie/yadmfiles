local util = require("lspconfig.util")
vim.g.rime_enabled = false
local function toggle_rime()
    local client = util.get_active_client_by_name(0, "rime_ls")
    if client == nil then
        return
    end
    client.request("workspace/executeCommand", {
        { command = "rime-ls.toggle-rime" },
    }, function(err, result)
        vim.g.rime_enabled = result
    end)
end

return {
    init_options = {
        enabled = vim.g.rime_enabled,
        shared_data_dir = "/usr/share/rime-data",
        user_data_dir = "~/.local/share/rime-ls",
        log_dir = "~/.local/share/rime-ls",
        schema_trigger_character = "&",
    },
    commands = {
        ToggleRime = {
            toggle_rime,
            description = "Toggle rime status",
        },
        SyncRimeData = {
            function()
                vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" })
            end,
            description = "Sync rime data",
        },
    },
}
