local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("lualine not found!")
    return
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { error = " ", warn = " ", info = " " },
    always_visible = false,
}

local rime_status = function()
    if require("cmp_rime").status() then
        return "ㄓ"
    else
        return "EN"
    end
end

local python_env = function()
    if vim.bo.filetype ~= "python" then
        return ""
    end

    return ""
end

local tabsize = function()
    return "tab:" .. vim.bo.shiftwidth
end

local tex_words = function()
    if vim.bo.filetype ~= "tex" then
        return ""
    end
    return "words:" .. vim.fn.call("vimtex#misc#wordcount", {})
end

lualine.setup({
    options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
        globalstatus = true,
        ignore_focus = {
            "NvimTree",
        },
        disabled_filetypes = {
            "help",
            "alpha",
            "dashboard",
            "NvimTree",
            "neo-tree",
            "Outline",
            "aerial",
            "dapui_watches",
            "dapui_breakpoints",
            "dapui_stacks",
            "dapui_scopes",
            "dapui_console",
            "dap-repl",
            "neotest-summary",
            "lspsagaoutline",
            "vimtex-toc",
            "spectre_panel",
        },
    },

    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", diagnostics },
        lualine_c = { rime_status },

        lualine_x = {
            tabsize,
            "encoding",
            "fileformat",
        },
        lualine_y = {
            "filetype",
            -- tex_words,
            python_env,
        },
        lualine_z = {
            "progress",
            "filesize",
        },
    },

    -- tabline = {
    --     lualine_a = { buffers },
    -- },
})

vim.cmd([[
    autocmd InsertLeave * lua require('lualine').refresh({scope='all', place={'statusline', 'winbar', 'tabline'}})
]])

-- require("which-key").register({
--     ["<leader>1"] = { "<cmd>LualineBuffersJump! 1<CR>", "go to buffer 1" },
--     ["<leader>2"] = { "<cmd>LualineBuffersJump! 2<CR>", "go to buffer 2" },
--     ["<leader>3"] = { "<cmd>LualineBuffersJump! 3<CR>", "go to buffer 3" },
--     ["<leader>4"] = { "<cmd>LualineBuffersJump! 4<CR>", "go to buffer 4" },
--     ["<leader>5"] = { "<cmd>LualineBuffersJump! 5<CR>", "go to buffer 5" },
--     ["<leader>6"] = { "<cmd>LualineBuffersJump! 6<CR>", "go to buffer 6" },
--     ["<leader>7"] = { "<cmd>LualineBuffersJump! 7<CR>", "go to buffer 7" },
--     ["<leader>8"] = { "<cmd>LualineBuffersJump! 8<CR>", "go to buffer 8" },
--     ["<leader>9"] = { "<cmd>LualineBuffersJump! 9<CR>", "go to buffer 9" },
-- }, {})
