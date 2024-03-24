-- name
-- option
-- keyword_length
-- keyword_pattern
-- trigger_characters
-- priority
-- max_item_count
-- group_index
CMP_SOURCES = {
    luasnip = { name = "luasnip", menu = "[Snip]" },
    nvim_lsp = {
        name = "nvim_lsp",
        menu = "[LSP]",
        -- entry_filter = function(entry) return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind() end,
    },
    path = { name = "path", menu = "[Path]" },
    buffer = { name = "buffer", menu = "[Buf]" },
    cmdline = { name = "cmdline", menu = "[Cmd]", group_index = 2 },

    -- unused
    rime = { name = "rime", menu = "[Rime]" },
    treesitter = { name = "treesitter", menu = "[TS]" },
    cmdline_history = { name = "cmdline_history", menu = "[Cmd History]" },
    nvim_lsp_signature_help = { name = "nvim_lsp_signature_help", menu = "[Param]" },
    spell = { name = "spell", menu = "[Spell]" },
    dap = { name = "dap", menu = "[Dap]" },
}
for k, _ in pairs(CMP_SOURCES) do
    CMP_SOURCES[k].group_index = CMP_SOURCES[k].group_index or 1
end

-- sort __xxx__ or _xxx_ items
---@param entry1 cmp.Entry
---@param entry2 cmp.Entry
---@return boolean | nil
local function underline_sorter(entry1, entry2)
    local _, entry1_under = entry1.completion_item.label:find("^_+")
    local _, entry2_under = entry2.completion_item.label:find("^_+")
    entry1_under = entry1_under or 0
    entry2_under = entry2_under or 0
    if entry1_under > entry2_under then
        return false
    elseif entry1_under < entry2_under then
        return true
    end
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- cmp-nvim-lsp in lsp/init.lua
        -- cmp-luasnip in edit/luasnip.lua
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "ray-x/cmp-treesitter",
        -- {
        --     "yao-weijie/cmp-rime",
        --     dev = true,
        --     opts = {
        --         -- libpath = vim.fn.expand("~/Projects/neovim/librime/build/lib/librime.so"),
        --         libpath = "librime.so.1",
        --         enable = {
        --             comment = true,
        --         },
        --         preselect = true,
        --         number_select = 9,
        --         -- TODO
        --         mapping = {
        --             select_2 = { ";" },
        --             select_3 = { "'" },
        --             page_up = { ",", "-" },
        --             page_down = { ".", "=" },
        --             confirm = { "<CR>" },
        --             space_commit = { "<Space>" },
        --             select_next_item = { "<C-n>" },
        --             select_prev_item = { "<C-p>" },
        --         },
        --     },
        --     keys = {
        --         { "<C-g>", "<cmd>lua require('cmp_rime').mapping.toggle()<CR>", mode = { "i", "n" } },
        --     },
        -- },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require("cmp")
        local compare = require("cmp.config.compare")
        local luasnip = require("luasnip")

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

            formatting = {
                fields = { "abbr", "kind", "menu" },
                expandable_indicator = false,
                ---@param entry cmp.Entry
                ---@param vim_item vim.CompletedItem
                format = function(entry, vim_item)
                    local max_width = 80
                    vim_item.abbr = string.sub(vim_item.abbr, 1, max_width)
                    vim_item.menu = CMP_SOURCES[entry.source.name].menu
                    return vim_item
                end,
            },

            -- global setting and can be overwritten in sources
            experimental = { ghost_text = false },
            sources = {
                CMP_SOURCES.nvim_lsp,
                CMP_SOURCES.luasnip,
                CMP_SOURCES.buffer,
                -- CMP_SOURCES.rime,
                CMP_SOURCES.path,
                CMP_SOURCES.treesitter,
            },

            sorting = {
                priority_weight = 1,
                comparators = {
                    -- require("cmp_rime.compare").order,
                    underline_sorter,
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
            sources = {
                CMP_SOURCES.buffer,
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                -- 有path 的时候屏蔽cmd
                CMP_SOURCES.path,
                CMP_SOURCES.cmdline,
            },
        })
    end,
}
