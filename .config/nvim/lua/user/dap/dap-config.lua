local M = {}

local function config_signs()
    local dap_signs = {
        DapBreakpoint = {
            text = "🔴",
            texthl = "",
            linehl = "",
            numhl = "",
        },
        DapBreakpointRejected = {
            text = "",
            texthl = "LspDiagnosticsSignHint",
            linehl = "",
            numhl = "",
        },
        DapStopped = {
            text = "➜ ",
            texthl = "LspDiagnosticsSignInformation",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "LspDiagnosticsSignInformation",
        },
    }
    for name, val in pairs(dap_signs) do
        vim.fn.sign_define(name, val)
    end
end

local function config_event()
    local dap, dapui = require("dap"), require("dapui")

    local debug_open = function()
        require("nvim-tree.view").close()
        dapui.open({})
    end
    local debug_close = function()
        dap.repl.close()
        dapui.close({})
    end

    dap.listeners.after.event_initialized["dapui_config"] = debug_open
    dap.listeners.before.event_terminated["dapui_config"] = debug_close
    dap.listeners.before.event_exited["dapui_config"] = debug_close
    dap.listeners.before.disconnect["dapui_config"] = debug_close
end

local function config_adapter()
    local mason_dap = require("mason-nvim-dap")
    mason_dap.setup({
        automatic_setup = true,
    })
    mason_dap.setup_handlers({
        function(source_name)
            require("mason-nvim-dap.automatic_setup")(source_name)
        end,
    })
    -- load tasks
    require("user.dap.adapters")
    require("dap.ext.vscode").load_launchjs(
        -- file path tbl
        -- '.vscode/launch.json'
        nil,
        {
            python = { "python" },
            cppdbg = { "c", "cpp" },
        }
    )
end

function M.setup()
    -- global settings
    config_signs()
    config_event()
    config_adapter()
    require("persistent-breakpoints").setup({ load_breakpoints_event = { "BufReadPost" } })
end

return M
