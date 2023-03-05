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
    treesitter = { name = "treesitter", menu = "[TS]" },
    path = { name = "path", menu = "[Path]" },
    buffer = { name = "buffer", menu = "[Buf]" },
    spell = { name = "spell", menu = "[Spell]" },
    nvim_lsp_signature_help = { name = "nvim_lsp_signature_help", menu = "[Param]" },
    rime = { name = "rime", menu = "[Rime]" },
    cmdline = { name = "cmdline", menu = "[Command]" },
    cmdline_history = { name = "cmdline_history", menu = "[Cmd History]" },
    dap = { name = "dap", menu = "[Dap]" },
}

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
            config = function()
                require("cmp_nvim_lsp").default_capabilities()
            end,
        },
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        { "rcarriga/cmp-dap", ft = { "dap-repl", "dapui_watches", "dapui_hover" } },
        {
            "yao-weijie/cmp-rime",
            dev = true,
            opts = {
                enable = {
                    comment = true,
                },
                preselect = true,
            },
            keys = {
                { "<C-g>", "<cmd>lua require('cmp_rime').mapping.toggle()<CR>", mode = { "i", "n" } },
            },
        },
        "saadparwaiz1/cmp_luasnip",
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

            sortting = {
                priority = 1,
                comparators = {
                    compare.sort_text,
                    compare.length,
                    compare.offset,
                    compare.exact,
                    compare.score,
                    compare.recently_used,
                    compare.kind,
                    compare.order,
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
                source_candidates.path,
                source_candidates.cmdline,
            },
        })

        cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
            sources = {
                source_candidates.dap,
            },
        })

        -- other settings
        -- autopairs is started before cmp
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done({
                map_char = { tex = "" },
            })
        )
        vim.cmd([[
            " 文档window 隐藏链接
            autocmd FileType cmp_docs setlocal filetype=markdown
            autocmd FileType markdown setlocal conceallevel=2
        ]])
    end,
}
