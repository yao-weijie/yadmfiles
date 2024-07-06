local cmp_utils = require("plugins.cmp.utils")
local CMP_SOURCES = cmp_utils.CMP_SOURCES

---@type LazySpec
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- cmp-nvim-lsp in lsp/init.lua
        -- cmp-luasnip in edit/luasnip.lua
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "ray-x/cmp-treesitter",
        require("plugins.cmp.rime"),
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require("cmp")
        local compare = require("cmp.config.compare")
        local luasnip = require("luasnip")
        vim.opt.completeopt = "menu,menuone,noselect"

        cmp.setup({
            window = {
                completion = {
                    border = "none",
                    winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:MyCmpSel",
                },
                documentation = {
                    border = "none",
                },
            },
            view = {
                -- entries = {
                --     name = "custom",
                --     selection_order = "near_cursor",
                --     follow_curosr = true,
                -- },
                docs = {
                    auto_open = true,
                },
            },

            formatting = {
                fields = { "abbr", "kind", "menu" },
                expandable_indicator = false,
                format = cmp_utils.cmp_format,
            },

            -- global setting and can be overwritten in sources
            experimental = { ghost_text = false },
            sources = {
                CMP_SOURCES.nvim_lsp,
                CMP_SOURCES.luasnip,
                CMP_SOURCES.buffer,
                CMP_SOURCES.rime,
                CMP_SOURCES.path,
                CMP_SOURCES.treesitter,
                CMP_SOURCES.xmake,
            },

            sorting = {
                priority_weight = 1,
                comparators = {
                    -- require("cmp_rime.compare").order,
                    cmp_utils.underline_sorter,
                    compare.score,
                    compare.kind,
                    compare.exact,
                    compare.length,
                    compare.offset,
                    compare.sort_text,
                },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- snippet settting in luasnip
            mapping = cmp.mapping.preset.insert({
                -- expand snippet setting in luasnip
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),

                ["<C-j>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end),
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end),

                ["<C-Space>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),
                ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),

                -- ["<C-n>"] = require("cmp_rime").mapping.select_next_item,
                -- ["<C-p>"] = require("cmp_rime").mapping.select_prev_item,
                -- ["<C-Space>"] = require("cmp_rime").mapping.toggle_menu,
                -- ["<Space>"] = require("cmp_rime").mapping.space_commit,
                -- ["<CR>"] = require("cmp_rime").mapping.confirm,

                -- ["."] = require("cmp_rime").mapping.page_down,
                -- [","] = require("cmp_rime").mapping.page_up,

                -- [";"] = require("cmp_rime").mapping["2"],
                -- ["'"] = require("cmp_rime").mapping["3"],
            }),
        })

        -- for cmdline
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                CMP_SOURCES.buffer,
            }),
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                CMP_SOURCES.path,
                CMP_SOURCES.cmdline,
                CMP_SOURCES.FzfLua,
            }),
        })
    end,
}
