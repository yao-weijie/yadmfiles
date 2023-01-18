local status_cmp_ok, cmp = pcall(require, "cmp")
if not status_cmp_ok then
    vim.notify("cmp not found!")
    return
end

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

local source_menus = {
    luasnip = "[Snip]",
    nvim_lsp = "[LSP]",
    treesitter = "[TS]",
    path = "[Path]",
    buffer = "[Buf]",
    spell = "[Spell]",
    nvim_lsp_signature_help = "[Param]",

    cmdline = "[Command]",
    cmdline_history = "[Cmd History]",
}
local sources = {
    { name = "luasnip" },
    {
        name = "nvim_lsp",
        -- disable snippets from lsp
        entry_filter = function(entry)
            return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
        end,
    },
    { name = "path" },
    { name = "buffer", dup = 0 },
    { name = "spell", keyword_length = 3, dup = 0 },
    -- { name = "nvim_lsp_signature_help" },
}

local priority_default = 1
local priorities = {
    luasnip = 3,
    nvim_lsp = 2,
}

for i, v in ipairs(sources) do
    sources[i]["priority"] = priorities[v.name] -- or nil
end

cmp.setup({
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    formatting = {
        fields = { "abbr", "kind", "menu" },

        format = function(entry, vim_item)
            vim_item.menu = source_menus[entry.source.name]
            return vim_item
        end,
        -- format = lspkind.cmp_format({
        --     mode = "text",
        --     -- maxwidth = 50,
        --     ellipsis_char = "..",

        --     before = function(entry, vim_item)
        --         vim_item.menu = source_menus[entry.source.name]
        --         return vim_item
        --     end,
        -- }),
    },
    -- global setting and can be overwritten in sources
    completion = { keyword_length = 1, priority = priority_default },
    sources = sources,
    sortting = {
        priority_weight = 1.0,
        comparators = {
            cmp.config.compare.socre,
            cmp.config.compare.kind,
            cmp.config.compare.exact,
            -- cmp.config.compare.offset,
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
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            -- select = false,
        }),
    }),
})

-- for cmdline
for _, cmd_type in ipairs({ "/", "?" }) do
    cmp.setup.cmdline(cmd_type, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })
end

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline" },
        { name = "path" },
    },
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
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
