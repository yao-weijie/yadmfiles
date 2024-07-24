local M = {}
-- name
-- option
-- keyword_length
-- keyword_pattern
-- trigger_characters
-- priority
-- max_item_count
-- group_index
---@type table<string, cmp.SourceConfig>
CMP_SOURCES = {
    luasnip = { name = "luasnip", menu = "[Snip]" },
    nvim_lsp = {
        name = "nvim_lsp",
        menu = "[LSP]",
        -- entry_filter = function(entry, ctx) return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind() end,
    },
    path = { name = "path", menu = "[Path]" },
    async_path = { name = "async_path", menu = "[Path]" },
    buffer = { name = "buffer", menu = "[Buf]" },
    cmdline = { name = "cmdline", menu = "[Cmd]", group_index = 2 },
    rime = { name = "rime", menu = "[Rime]" },
    treesitter = { name = "treesitter", menu = "[TS]" },
    cmdline_history = { name = "cmdline_history", menu = "[Cmd History]" },
    nvim_lsp_signature_help = { name = "nvim_lsp_signature_help", menu = "[Param]" },
    spell = { name = "spell", menu = "[Spell]" },
    dap = { name = "dap", menu = "[Dap]" },
    FzfLua = {
        name = "FzfLua",
        menu = "[Fzf]",
        group_index = 1,
        -- entry_filter = false,
        entry_filter = function(entry, ctx)
            return false
        end,
    },
    xmake = { name = "xmake", menu = "[Xmake]" },
}
for k, _ in pairs(CMP_SOURCES) do
    CMP_SOURCES[k].group_index = CMP_SOURCES[k].group_index or 1
end

M.CMP_SOURCES = CMP_SOURCES

-- sort __xxx__ or _xxx_ items
---@param entry1 cmp.Entry
---@param entry2 cmp.Entry
---@return boolean | nil
M.underline_sorter = function(entry1, entry2)
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

---@param entry cmp.Entry
---@param vim_item vim.CompletedItem
---@return vim.CompletedItem
M.cmp_format = function(entry, vim_item)
    local max_width = 80
    vim_item.abbr = string.sub(vim_item.abbr, 1, max_width)
    vim_item.menu = CMP_SOURCES[entry.source.name].menu
    return vim_item
end

return M
