local M = {}

M.setup = function(pattern)
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = pattern,
        callback = function(file)
            require("which-key").register({
                ["<F8>"] = { "<cmd>DapContinue<CR>", "start debug" },
                ["<2-LeftMouse>"] = { "<cmd>PBToggleBreakpoint<CR>", "toggle breakpont" },
            }, { buffer = file.buf })
        end,
    })
end

return M
