local builtins = require("null-ls").builtins
local toolset = {
    name = "tex",
    -- vimtex很好用,texlab可有可无
    server = { "texlab", "ltex" },
    treesitter = { "latex" },
    sources = {
        builtins.formatting.latexindent,
    },
}

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
    build_dir = "build",
    callback = 1,
    continus = 1,
    executable = "latexmk",
    options = {
        "-verbose",
        "-file-line-error",
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
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
    split_width = 25,
    todo_sorted = 0,
    show_help = 0,
    show_numbers = 1,
    split_pos = "vert rightbelow",
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
        autocmd FileType tex setlocal conceallevel=2
        autocmd FileType tex setlocal shiftwidth=2 tabstop=2 softtabstop=2

        autocmd FileType tex nnoremap <buffer> <leader>o <cmd>VimtexTocToggle<CR>
        autocmd FileType tex nnoremap <buffer> == gg=G
        autocmd FileType tex nnoremap <buffer> H g^
        autocmd FileType tex nnoremap <buffer> L g$
        autocmd FileType tex vnoremap <buffer> H g^
        autocmd FileType tex vnoremap <buffer> L g$
        autocmd FileType tex onoremap <buffer> H g^
        autocmd FileType tex onoremap <buffer> L g$
        autocmd FileType tex nnoremap <buffer> <Down> gj
        autocmd FileType tex vnoremap <buffer> <Down> gj
        autocmd FileType tex nnoremap <buffer> <Up> gk
        autocmd FileType tex vnoremap <buffer> <Up> gk
    augroup END
]])

return toolset
