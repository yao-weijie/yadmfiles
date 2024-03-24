return {
    "nvimdev/guard.nvim",
    dependencies = {
        "nvimdev/guard-collection",
    },
    config = function()
        local ft = require("guard.filetype")
        ft("sh"):fmt("shfmt")
        ft("lua"):fmt("stylua")
        -- ft("python"):fmt("black"):append("isort")
        ft("python"):fmt({
            cmd = "ruff",
            args = {
                "format",
                "--stdin-filename",
                "$FILENAME",
                "-",
            },
            stdin = true,
        })
        ft("c,cpp,cs,foam"):fmt("clang-format")
        ft("tex"):fmt("latexindent")

        require("guard").setup({
            fmt_on_save = true,
        })
    end,
}
