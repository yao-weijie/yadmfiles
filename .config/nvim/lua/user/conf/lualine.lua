local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    vim.notify("lualine not found!")
    return
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info" },
    symbols = { error = " ", warn = " ", info = " " },
    always_visible = false,
}

local filetype = {
    "filetype",
    fmt = function(filetype)
        -- local env = require("py-env").get_env()

        -- if filetype == "python" and env ~= nil then
        --     if env.type == "conda" then
        --         return string.format("py(%s:%s)", env.name, env.version)
        --     else
        --         return string.format("py(%s:%s)", env.type, env.version)
        --     end
        -- end
        return filetype
    end,
}

local python_env = {
    fmt = function()
        return nil
    end,
}

local tabsize = function()
    return "tab:" .. vim.bo.shiftwidth
end

local tex_words = function()
    return "words:" .. vim.fn.call("vimtex#misc#wordcount", {})
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "material",
        component_separators = { left = "", right = "", },
        section_separators = { left = "", right = "", },
        disabled_filetypes = {
          -- statusline = {},
          -- winbar = {},
            -- "help",
            -- "alpha",
            -- "dashboard",
            -- "NvimTree",
            -- "neo-tree",
            -- "Outline",
            -- "aerial",
            -- "dapui_watches",
            -- "dapui_breakpoints",
            -- "dapui_stacks",
            -- "dapui_scopes",
            -- "dapui_console",
            -- "dap-repl",
            -- "neotest-summary",
            -- "lspsagaoutline",
            -- "vimtex-toc",
            -- "spectre_panel",
        },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", diagnostics },
        lualine_c = { "filename" },
        lualine_x = {
            "searchcount",
            tabsize,
            "encoding",
            "fileformat",
        },
        lualine_y = {
            filetype,
            tex_words,
        },
        lualine_z = {
            -- "location",
            "progress",
            "filesize",
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
})
