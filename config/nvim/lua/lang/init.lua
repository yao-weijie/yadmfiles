--[[ 
{
    filetypes = { "ft1", "ft2" },
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

---@class LangOpts
---@field filetypes? string[]
---@field conform? table<string, string[]>
---@field dap? any
---@field neotest? any
---@field lsp? any

---@param filetypes string[]
---@param formatters string[]
_G.setup_conform = function(filetypes, formatters)
    for _, ft in ipairs(filetypes) do
        require("conform").formatters_by_ft[ft] = formatters
    end
end

---@param filetypes string[]
---@param linter string[]
_G.setup_linter = function(filetypes, linter)
    for _, ft in ipairs(filetypes) do
        require("lint").linters_by_ft[ft] = linter
    end
end

---@param filetypes string[]
---@param configurations DapConfig[]
_G.setup_dap = function(filetypes, configurations)
    for _, ft in ipairs(filetypes) do
        if require("dap").configurations[ft] == nil then
            require("dap").configurations[ft] = configurations
        else
            vim.tbl_extend("keep", require("dap").configurations[ft], configurations)
        end
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(event)
            local opt = { buffer = event.buf }
            vim.keymap.set("n", "<leader>b", require("persistent-breakpoints.api").toggle_breakpoint, opt)
            vim.keymap.set("n", "<2-LeftMouse>", require("persistent-breakpoints.api").toggle_breakpoint, opt)
            vim.api.nvim_buf_create_user_command(event.buf, "DapRunToCursor", require("dap").run_to_cursor, {})
        end,
    })
end

---@param opts LangOpts
_G.LangSetup = function(opts)
    if opts.conform then
        _G.setup_conform(opts.conform.filetypes or opts.filetypes, opts.conform.formatters)
        --     for _, ft in ipairs(opts.conform.filetypes or opts.filetypes) do
        --         require("conform").formatters_by_ft[ft] = opts.conform.formatters
        --     end
    end

    if opts.lsp then
        --
    end

    if opts.dap then
        _G.setup_dap(opts.dap.filetypes or opts.filetypes, opts.dap.configurations)
        -- for _, ft in ipairs(opts.dap.filetypes or opts.filetypes) do
        --     require("dap").configurations[ft] = opts.dap.configurations
        -- end

        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = opts.filetypes,
        --     callback = function(event)
        --         local opt = { buffer = event.buf }
        --         vim.keymap.set("n", "<leader>b", require("persistent-breakpoints.api").toggle_breakpoint, opt)
        --         vim.keymap.set("n", "<2-LeftMouse>", require("persistent-breakpoints.api").toggle_breakpoint, opt)
        --         vim.api.nvim_buf_create_user_command(event.buf, "DapRunToCursor", require("dap").run_to_cursor, {})
        --     end,
        -- })
    end

    if opts.neotest then
        --
    end
end

return {}
