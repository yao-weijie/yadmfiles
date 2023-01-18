set nocompatible
set nobackup
set noswapfile
set nowritebackup
set autoread
set autowriteall
set history=200

set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030,latin1
set fileformat=unix
set fileformats=unix,dos

set cursorline
set colorcolumn=80
set number
set numberwidth=2
set scrolloff=10
set sidescrolloff=8
set ruler
set showcmd
set noshowmode
set wildmenu

set mouse=a
set termguicolors
set background=dark

if has('autocmd')
    filetype plugin indent on
endif

set autoindent
set smarttab
set cindent
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set linebreak

set textwidth=100
set backspace=eol,start,indent

set hlsearch
set incsearch
set ignorecase
set smartcase

set splitright
set diffopt=vertical,filler,internal,context:4

set pumheight=10

set spell
set spelllang=en_us

set hidden
set updatetime=300

let g:python3_prog_host = "/usr/bin/python3"
let g:ROOT_MARKERS = [ ".git", ".hg", ".svn", ".root", ".project", "Makefile" ]
