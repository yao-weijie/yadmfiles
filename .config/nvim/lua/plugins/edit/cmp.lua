-- name
-- option
-- keyword_length
-- keyword_pattern
-- trigger_characters
-- priority
-- max_item_count
-- group_index
local source_candidates = {
    luasnip = { name = "luasnip", menu = "[Snip]" },
    nvim_lsp = {
        name = "nvim_lsp",
        menu = "[LSP]",
        entry_filter = function(entry)
            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
        end,
    },
    path = { name = "path", menu = "[Path]" },
    buffer = { name = "buffer", menu = "[Buf]" },
    rime = { name = "rime", menu = "[Rime]" },
    cmdline = { name = "cmdline", menu = "[Cmd]" },
    dap = { name = "dap", menu = "[Dap]" },

    -- unused
    treesitter = { name = "treesitter", menu = "[TS]" },
    cmdline_history = { name = "cmdline_history", menu = "[Cmd History]" },
    nvim_lsp_signature_help = { name = "nvim_lsp_signature_help", menu = "[Param]" },
    spell = { name = "spell", menu = "[Spell]" },
}

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- cmp-nvim-lsp in lsp/init.lua
        -- cmp-luasnip in edit/luasnip.lua
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        {
            "yao-weijie/cmp-rime",
            dev = true,
            opts = {
                libpath = "/home/yaowj/Projects/tools/librime/build/lib/librime.so",
                enable = {
                    comment = true,
                },
                preselect = true,
                -- TODO
                -- mapping = {
                --     select_2 = { ";" },
                --     select_3 = { "'" },
                --     page_up = { ",", "-" },
                --     page_down = { ".", "=" },
                --     confirm = { "<CR>" },
                --     space_commit = { "<Space>" },
                --     select_next_item = { "<C-n>" },
                --     select_prev_item = { "<C-p>" },
                -- },
            },
            keys = {
                { "<C-g>", "<cmd>lua require('cmp_rime').mapping.toggle()<CR>", mode = { "i", "n" } },
            },
        },
        -- "hrsh7th/cmp-nvim-lsp-signature-help",

        "onsails/lspkind.nvim",
    },
    event = { "VeryLazy" },
    config = function()
        local cmp = require("cmp")
        local compare = require("cmp.config.compare")

        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = require("lspkind").cmp_format({
                    mode = "text",
                    maxwidth = 50,

                    before = function(entry, vim_item)
                        vim_item.menu = source_candidates[entry.source.name].menu
                        return vim_item
                    end,
                }),
            },

            -- global setting and can be overwritten in sources
            experimental = { ghost_text = true },
            sources = {
                source_candidates.nvim_lsp,
                source_candidates.luasnip,
                source_candidates.buffer,
                source_candidates.rime,
                source_candidates.path,
            },

            sorting = {
                comparators = {
                    require("cmp_rime.compare").order,
                    compare.kind,
                    compare.exact,
                    compare.length,
                    compare.offset,
                    compare.score,
                    compare.recently_used,
                    compare.sort_text,
                },
            },

            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping(function(fallback)
                    if require("luasnip").expand_or_jumpable() then
                        require("luasnip").expand_or_jump()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-k>"] = cmp.mapping(function(fallback)
                    -- TODO: check  in snippet
                    if require("luasnip").jumpable(-1) then
                        require("luasnip").jump(-1)
                    elseif cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),

                ["<C-n>"] = require("cmp_rime").mapping.select_next_item,
                ["<C-p>"] = require("cmp_rime").mapping.select_prev_item,

                ["<C-Space>"] = require("cmp_rime").mapping.toggle_menu,
                ["<Space>"] = require("cmp_rime").mapping.space_commit,
                ["<CR>"] = require("cmp_rime").mapping.confirm,

                ["."] = require("cmp_rime").mapping.page_down,
                [","] = require("cmp_rime").mapping.page_up,

                [";"] = require("cmp_rime").mapping["2"],
                ["'"] = require("cmp_rime").mapping["3"],
            }),
        })

        -- for cmdline
        for _, cmd_type in ipairs({ "/", "?" }) do
            cmp.setup.cmdline(cmd_type, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    source_candidates.buffer,
                },
            })
        end

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                -- 有path 的时候屏蔽cmd
                vim.tbl_extend("force", source_candidates.path, { group_index = 1 }),
                vim.tbl_extend("force", source_candidates.cmdline, { group_index = 2 }),
            },
        })
    end,
}
