vim.filetype.add({
    pattern = {
        [".*/polyMesh/.*"] = "foam",
        -- [".*/system/.*"] = "foam",
        -- [".*/0/.*"] = "foam",
    },
})

return {}
