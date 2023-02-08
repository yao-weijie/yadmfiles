local status_cmp_ok, cmp = pcall(require, "cmp")
if not status_cmp_ok then
    vim.notify("cmp not found!")
    return
end

local compare = require("cmp.config.compare")

require("cmp_nvim_lsp").default_capabilities(require("user.lsp.handlers").capabilities)

local luasnip = require("luasnip")
-- load snippet folders in runtimeapth
vim.opt.runtimepath:append("~/.config/nvim/my-snippets")
vim.opt.runtimepath:append("~/.config/nvim/my-snippets/lua")
-- 我自己不用vscode格式,只用friendly-snippets里的
require("luasnip.loaders.from_vscode").lazy_load()
-- snippets/<ft>.snippets and snippets/<ft>/*.snippets
require("luasnip.loaders.from_snipmate").lazy_load()
-- luasnippets/<ft>.lua and luasnippets/<ft>/*.lua
require("luasnip.loaders.from_lua").lazy_load()

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
            return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
        end,
    },
    treesitter = { name = "treesitter", menu = "[TS]" },
    path = { name = "path", menu = "[Path]", group_index = 1 },
    buffer = { name = "buffer", menu = "[Buf]" },
    spell = { name = "spell", menu = "[Spell]" },
    nvim_lsp_signature_help = { name = "nvim_lsp_signature_help", menu = "[Param]" },
    luarime = {
        name = "luarime",
        menu = "[Rime]",
        option = {
            shared_data_dir = "/usr/share/rime-data",
            user_data_dir = vim.fn.getenv("HOME") .. "/.local/share/cmp-luarime",
            max_candidates = 10,
        },
    },
    cmdline = { name = "cmdline", menu = "[Command]", group_index = 2 },
    cmdline_history = { name = "cmdline_history", menu = "[Cmd History]" },
    dap = { name = "dap", menu = "[Dap]" },
}

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
        source_candidates.luarime,
        source_candidates.path,
    },
    sortting = {
        priority_weight = 1.0,
        comparators = {
            compare.sort_text,
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
            compare.length,
            compare.order,
        },
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),

        -- toggle cmp window
        ["<C-space>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.abort()
            else
                cmp.complete()
            end
        end),
        -- rime-ls 空格上屏
        ["<Space>"] = cmp.mapping(function(fallback)
            if cmp.visible() and vim.g.rime_enabled then
                cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace })
                cmp.close()
            else
                fallback()
            end
        end),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            -- select = true,
        }),
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
        { name = "dap" },
    },
})

-- 仿vscode配色
vim.cmd([[
    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
    " light blue
    highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    highlight! link CmpItemKindInterface CmpItemKindVariable
    highlight! link CmpItemKindText CmpItemKindVariable
    " pink
    highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
    highlight! link CmpItemKindMethod CmpItemKindFunction
    " front
    highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    highlight! link CmpItemKindProperty CmpItemKindKeyword
    highlight! link CmpItemKindUnit CmpItemKindKeyword
]])

-- other settings
-- autopairs is started before cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
        map_char = { tex = "" },
    })
)
