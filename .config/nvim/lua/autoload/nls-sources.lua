require("null-ls").reset_sources()
for _, toolset in pairs(_G.toolset) do
    require("null-ls").register(toolset.sources)
end

return {}
