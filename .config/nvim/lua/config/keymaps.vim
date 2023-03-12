" -- Mode           | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang | ~
" -- Command        +------+-----+-----+-----+-----+-----+------+------+ ~
" -- [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
" -- n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
" -- [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
" -- i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
" -- c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
" -- v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
" -- x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
" -- s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
" -- o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
" -- t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
" -- l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
" -- Modes
" -- normal_mode = "n",
" -- insert_mode = "i",
" -- visual_mode = "v",
" -- visual_block_mode = "x",
" -- term_mode = "t",
" -- command_mode = "c",

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" C-r用作搜索替换
nnoremap U <C-r>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" H, L jump to line home / end
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
onoremap H ^
onoremap L $

" search
nnoremap n nzz<cmd>set hlsearch<CR>
nnoremap N Nzz<cmd>set hlsearch<CR>
nnoremap * *N<cmd>set hlsearch<CR>
nnoremap # #N<cmd>set hlsearch<CR>

" q/Q and quit
nnoremap Q q
vnoremap Q q
nnoremap q <Nop>
vnoremap q <Nop>
nnoremap <leader>x <cmd>x<CR>
nnoremap <leader>q <cmd>bd<CR>
nnoremap <leader>w <cmd>w<CR>
nnoremap <leader>Q <cmd>copen<CR>

" paste
" TODO:在展开snippet的时候会进入v模式,如果要输入p开头的单词会触发粘贴
vnoremap p P
vnoremap P p

" format
nnoremap <leader>= gg=G
vnoremap > >gv
vnoremap < <gv

" switch window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" resize window
nnoremap <C-Up>    <cmd>resize +2<CR>
nnoremap <C-Down>  <cmd>resize -2<CR>
nnoremap <C-Left>  <cmd>vertical resize +2<CR>
nnoremap <C-Right> <cmd>vertical resize -2<CR>

" previous and next buffer
nnoremap [b <cmd>bprevious<CR>
nnoremap ]b <cmd>bnext<CR>
nnoremap <C-n> <cmd>bnext<CR>
nnoremap <C-p> <cmd>bprevious<CR>

" emacs mode in insert_mode
inoremap <C-d>   <Del>
inoremap <C-a>   <Home>
inoremap <C-e>   <End>
inoremap <C-f>   <Right>
inoremap <C-b>   <Left>
inoremap <C-Del> <C-o>dw
inoremap <C-k>   <C-o>c$

inoremap <M-w> <C-Right>
inoremap <M-b> <C-Left>

inoremap <C-l> <C-o>zz

cnoremap <expr> ;; getcmdtype() == ':' ? expand('%:p:h') .'/' : ';p'
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
