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
    path = { name = "path", menu = "[Path]" },
    buffer = { name = "buffer", menu = "[Buf]" },
    spell = { name = "spell", menu = "[Spell]" },
    nvim_lsp_signature_help = { name = "nvim_lsp_signature_help", menu = "[Param]" },
    rime = { name = "rime", menu = "[Rime]" },
    cmdline = { name = "cmdline", menu = "[Command]" },
    cmdline_history = { name = "cmdline_history", menu = "[Cmd History]" },
    dap = { name = "dap", menu = "[Dap]" },
}

local cmp_rime = require("cmp_rime")
cmp_rime.setup({
    libpath = "librime.so",
    traits = {
        shared_data_dir = "/usr/share/rime-data",
        user_data_dir = vim.fn.expand("~/.local/share/cmp-rime"),
        log_dir = "/tmp/cmp-rime",
    },
    enable = {
        global = false,
        comment = true,
    },
    preselect = true,
    auto_commit = false,
    number_select = 5,
})
vim.keymap.set({ "n", "i" }, "<C-g>", function()
    cmp_rime.mapping.toggle()
end, { desc = "toggle rime" })

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
        source_candidates.nvim_lsp_signature_help,
    },
    matching = {
        disallow_fuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = true,
        disallow_prefix_unmatching = true,
    },

    sortting = {
        priority = 0,
        comparators = {
            -- compare.sort_text,
            -- require("cmp_rime.compare").length,
            -- require("cmp_rime.compare").order,
            -- compare.length,
            -- compare.offset,
            -- compare.exact,
            -- compare.score,
            -- compare.recently_used,
            -- compare.kind,
            -- compare.order,
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
            -- TODO: check  in snippet
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

        ["<C-n>"] = cmp_rime.mapping.select_next_item,
        ["<C-p>"] = cmp_rime.mapping.select_prev_item,

        ["<C-Space>"] = cmp_rime.mapping.toggle_menu,
        ["<Space>"] = cmp_rime.mapping.space_commit,
        ["<CR>"] = cmp_rime.mapping.confirm,

        ["."] = cmp_rime.mapping.page_down,
        [","] = cmp_rime.mapping.page_up,

        [";"] = cmp_rime.mapping["2"],
        ["'"] = cmp_rime.mapping["3"],
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

    " 文档window 隐藏链接
    autocmd FileType cmp_docs setlocal filetype=markdown
    autocmd FileType markdown setlocal conceallevel=2
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
