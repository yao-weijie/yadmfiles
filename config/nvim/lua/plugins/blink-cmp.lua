---@type LazySpec
return {
    "Saghen/blink.cmp",
    version = "v0.*",
    dependencies = {
        "L3MON4D3/LuaSnip",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        keymap = {
            preset = "enter",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            --
            ["<Tab>"] = { "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            --
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            -- custom
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-f>"] = {},
            ["<C-b>"] = {},
        },
        snippets = {
            expand = function(snippet)
                require("luasnip").lsp_expand(snippet)
            end,
            active = function(filter)
                if filter and filter.direction then
                    return require("luasnip").jumpable(filter.direction)
                end
                return require("luasnip").in_snippet()
            end,
            jump = function(direction)
                require("luasnip").jump(direction)
            end,
        },
        sources = {
            default = { "lsp", "path", "luasnip", "buffer" },
            min_keyword_length = 0,
            providers = {
                lsp = {
                    score_offset = 3,
                },
                buffer = {
                    async = true,
                    min_keyword_length = 1,
                },
            },
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                    override_brackets_for_filetypes = {
                        tex = { "{", "}" },
                    },
                },
            },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "source_name" },
                    },
                },
            },
            documentation = {
                auto_show = true,
            },
            list = {
                selection = "auto_insert", -- preselect, manual, auto_insert
            },
            ghost_text = {
                enabled = true,
            },
        },
        signature = {
            enabled = true,
        },
    },
}
