--[[ 
{
    filetypes = { "ft1", "ft2" },
    conform = {
        custom_formatters = {
            fmt = {
                command = "cmd",
                args = { "arg1", "arg2" },
            },
        },
        formatter = { "formatter1", "formatter2" },
    },
    dap = {
        type = "debugpy",
        adapter = {
            type = "executable",
            ---
        },
        configurations = {
            {
                type = "debugpy",
                ---
            },
        },
    }
} 
]]

---@param opts table
_G.LangSetup = function(opts)
    if opts.conform then
        if opts.conform.custom_formatters then
            for k, v in pairs(opts.conform.custom_formatters) do
                require("conform").formatters[k] = v
            end
        end
        for _, ft in ipairs(opts.filetypes) do
            require("conform").formatters_by_ft[ft] = opts.conform.formatter
        end
    end

    if opts.lsp then
        --
    end

    if opts.dap then
        require("dap").adapters[opts.dap.type] = opts.dap.adapter

        for _, ft in ipairs(opts.filetypes) do
            require("dap").configurations[ft] = opts.dap.configurations
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = opts.filetypes,
            callback = function(file)
                local opt = { buffer = file.buf }
                vim.keymap.set("n", "<leader>b", require("persistent-breakpoints.api").toggle_breakpoint, opt)
                vim.keymap.set("n", "<2-LeftMouse>", require("persistent-breakpoints.api").toggle_breakpoint, opt)
                vim.api.nvim_buf_create_user_command(file.buf, "DapRunToCursor", require("dap").run_to_cursor, {})
            end,
        })
    end

    if opts.neotest then
        --
    end
end

return {}
