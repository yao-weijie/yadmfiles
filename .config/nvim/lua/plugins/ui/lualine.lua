local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { error = " ", warn = " ", info = " " },
    always_visible = false,
}

-- local rime_status = function()
--     if require("cmp_rime").status() then
--         return "ㄓ"
--     else
--         return "EN"
--     end
-- end

local tabsize = function()
    return "tab:" .. vim.bo.shiftwidth
end

return {
    "nvim-lualine/lualine.nvim",
    event = { "UIEnter" },
    opts = {
        options = {
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            always_divide_middle = true,
            globalstatus = true,
            ignore_focus = {
                "NvimTree",
            },
        },

        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", diagnostics },
            lualine_c = {
                -- rime_status
            },

            lualine_x = {
                tabsize,
                "encoding",
                "fileformat",
            },
            lualine_y = {
                "filetype",
            },
            lualine_z = {
                "progress",
                "filesize",
            },
        },
    },
}
