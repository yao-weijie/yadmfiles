vim.g.coq_settings = {
    display = {
        pum = {
            kind_context = { "", "" },
        },
        preview = {
            border = "single",
            -- positoins = {
            --     north = 1,
            --     south = 2,
            --     west = 3,
            --     east = 4,
            -- },
        },
        icons = {
            mode = "none",
        },
    },
}

return {
    "ms-jpq/coq_nvim",
    event = "InsertEnter",
    build = ":COQdeps",
    dependencies = {
        "ms-jpq/coq.thirdparty",
    },
    config = function()
        require("coq").Now()
        require("coq_3p")({
            { src = "nvimlua", short_name = "nLUA", config_only = true },
            { src = "vimtex", short_name = "vTEX" },
            { src = "dap" },
        })
    end,
}
