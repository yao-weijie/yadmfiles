local builtins = require("null-ls").builtins
_G.toolset.tex = {
    server = { "texlab" }, -- vimtex很好用,texlab可有可无
    sources = {
        builtins.formatting.latexindent.with({
            extra_args = {
                "-g", -- 禁用log 文件输出
                "/dev/null",
            },
        }),
    },
}

local function vimtex_setup()
    -- vimtex settings
    vim.g.tex_flavor = "latex"
    -- disable spell check
    vim.g.tex_comment_nospell = 1
    -- vim.g.tex_nospell = 1

    -- 中文字数统计
    vim.g.vimtex_texcount_custom_arg = " -ch -total"

    -- 这一项目默认即为 nvr，但是如果由于种种原因无法实现 SyncTeX 同步位置，可以考虑手动指定这一项目
    -- vim.g.vimtex_compiler_progname = "nvr"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
        executable = "latexmk",
        continus = 1,
        build_dir = "build",
        options = {
            "-verbose",
            "-file-line-error",
            "-shell-escape",
            "-synctex=1",
            "-interaction=nonstopmode",
        },
        callback = 1,
        hooks = {},
    }
    -- 不自动弹出
    vim.g.vimtex_quickfix_mode = 0
    -- 忽略编译警告
    vim.g.vimtex_quickfix_ignore_filters = {
        "Package fontspec Warning",
        "underfull",
        "Overfull",
    }

    -- okular 中反向搜索, 需要pip install neovim-remote
    -- okular 中鼠标为手型才可用, 跳转方式为 shift+leftclick
    -- nvr --remote-silent +%l %f
    local viewer = "okular"
    vim.g.vimtex_view_general_viewer = viewer
    vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

    vim.g.vimtex_toc_config = {
        name = "TOC",
        layers = { "content" },
        split_width = 40,
        todo_sorted = 0,
        show_help = 0,
        split_pos = "vert leftabove",
    }

    vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 0,
        math_symbols = 0,
        sections = 1,
        styles = 1,
    }

    vim.g.vimtex_syntax_conceal_cites = {
        type = "brackets",
        icon = "📖",
        verbose = true,
    }

    vim.cmd([[
    augroup _VimTeX
        autocmd!
        autocmd BufWritePost *.tex call vimtex#toc#refresh()
    augroup END
    ]])

    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "tex",
        callback = function(file)
            local opts = { buffer = file.buf }
            vim.bo.shiftwidth = 2
            vim.bo.tabstop = 2
            vim.bo.softtabstop = 2
            vim.wo.conceallevel = 2

            vim.keymap.set({ "n", "v", "o" }, "H", "g^", opts)
            vim.keymap.set({ "n", "v", "o" }, "L", "g$", opts)
            vim.keymap.set("n", "<leader>o", "<cmd>VimtexTocToggle<CR>", opts)
            vim.keymap.set("n", "==", "gg=G", opts)
        end,
    })
end

return {
    "lervag/vimtex",
    version = "*",
    cond = vim.fn.executable("latexmk") == 1,
    ft = "tex",
    config = vimtex_setup,
}
