local cmp_utils = require("plugins.cmp.utils")
local CMP_SOURCES = cmp_utils.CMP_SOURCES

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function in_snippet_map(str)
    return require("cmp").mapping(function(fallback)
        if require("luasnip").in_snippet() then
            return vim.api.nvim_feedkeys(t(str), "n", true)
        else
            fallback()
        end
    end, { "s" })
end

---@type LazySpec
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- cmp-nvim-lsp in lsp/init.lua
        -- cmp-luasnip in edit/luasnip.lua
        -- "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        -- "hrsh7th/cmp-path",
        -- { url = "https://codeberg.org/FelipeLema/cmp-async-path" },
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-nvim-lsp",
        -- require("plugins.cmp.rime"),
    },
    event = { "InsertEnter", "CmdlineEnter" },
    ---@type cmp.ConfigSchema
    opts = {
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
            docs = {
                auto_open = true,
            },
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            expandable_indicator = false,
            format = cmp_utils.cmp_format,
        },

        -- global setting and can be overwritten in sources
        experimental = { ghost_text = false },
        sources = {
            CMP_SOURCES.nvim_lsp,
            CMP_SOURCES.luasnip,
            CMP_SOURCES.buffer,
            -- CMP_SOURCES.rime,
            -- CMP_SOURCES.async_path,
            CMP_SOURCES.path,
            CMP_SOURCES.treesitter,
            -- CMP_SOURCES.xmake,
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
    },
    config = function(_, opts)
        opts = opts or {}
        local cmp = require("cmp")
        local compare = require("cmp.config.compare")
        local luasnip = require("luasnip")
        vim.opt.completeopt = "menu,menuone,noselect"

        -- extract sources from plugin single file
        require("plugins.cmp.sources.path").register()
        require("plugins.cmp.sources.luasnip").register()
        require("plugins.cmp.sources.cmdline").register()

        opts.sorting = {
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
        }

        opts.mapping = cmp.mapping.preset.insert({
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

            ["p"] = in_snippet_map("p"),
            ["P"] = in_snippet_map("P"),
            ["j"] = in_snippet_map("j"),
            ["k"] = in_snippet_map("k"),
            ["<"] = in_snippet_map("<"),
            [">"] = in_snippet_map(">"),
            ["q"] = in_snippet_map("q"),

            ["<C-Space>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.abort()
                else
                    cmp.complete()
                end
            end),
            ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        })
        cmp.setup(opts)

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
