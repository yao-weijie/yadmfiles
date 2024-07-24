_G.LangSetup({
    filetypes = { "python" },
    conform = {
        formatter = { "ruff_format" },
    },
    dap = {
        type = "debugpy",
        adapter = {
            type = "executable",
            command = "python3",
            args = {
                "-m",
                "debugpy.adapter",
            },
        },
        configurations = {
            {
                type = "debugpy",
                name = "Python: Launch file",
                request = "launch",
                program = "${file}",
                console = "integratedTerminal",
            },
        },
    },
})

---@type LazySpec
return {
    {
        dir = "~/.config/nvim/lua/lang/python/conda.lua",
        ft = { "python" },
        opts = {},
        config = function(_, opts)
            require("lang.python.conda").setup(opts)
        end,
    },
    {
        dir = "~/.config/nvim/lua/lang/python/lcode.lua",
        ft = { "python" },
        opts = {},
        config = function(_, opts)
            require("lang.python.lcode").setup(opts)
        end,
    },
}
