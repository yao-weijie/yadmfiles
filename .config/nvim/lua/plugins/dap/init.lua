return {
    "mfussenegger/nvim-dap",
    version = "*",
    dependencies = {
        { "jayp0521/mason-nvim-dap.nvim", version = "*" },
        { "thehamsta/nvim-dap-virtual-text", config = true },
        { "weissle/persistent-breakpoints.nvim", opts = { load_breakpoints_event = { "BufReadPost" } } },
    },
    lazy = false,
    keys = {
        { "<F8>", "<cmd>DapContinue<CR>", desc = "start debug" },
        -- Shift-F8
        { "<F20>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
        { "<S-F8>", "<cmd>DapTerminate<CR>", desc = "terminate debug" },
    },
    config = function()
        local mason_dap = require("mason-nvim-dap")
        mason_dap.setup({
            handlers = {
                function(configs)
                    local type = configs.configurations[1].type

                    if vim.pathlib.file_exist(("~/.config/nvim/lua/plugins/dap/adapters/%s.lua"):format(type)) then
                        local spec_configs = require(("plugins.dap.adapters.%s"):format(type))
                        configs = vim.tbl_deep_extend("force", configs, spec_configs)
                    end

                    mason_dap.default_setup(configs)
                end,
            },
        })
        vim.api.nvim_create_user_command("DapRunToCursor", require("dap").run_to_cursor, {})

        local installed_adapters = mason_dap.get_installed_sources()
        local ft_map = require("mason-nvim-dap.mappings.filetypes")
        local dap_ft = {}
        for _, adapter in ipairs(installed_adapters) do
            dap_ft = vim.tbl_extend("keep", dap_ft, ft_map[adapter])
        end
        vim.api.nvim_create_autocmd("FileType", {
            pattern = dap_ft,
            callback = function(file)
                print(file.buf)
                local opts = { buffer = file.buf }
                vim.keymap.set("n", "<leader>b", require("persistent-breakpoints.api").toggle_breakpoint, opts)
                vim.keymap.set("n", "<2-LeftMouse>", require("persistent-breakpoints.api").toggle_breakpoint, opts)
            end,
        })
    end,
}
