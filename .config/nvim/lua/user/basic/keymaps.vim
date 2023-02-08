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

" H, L jump to line home / end
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
onoremap H ^
onoremap L $

" search
nnoremap n nzz:set hlsearch<CR>
nnoremap N Nzz:set hlsearch<CR>
nnoremap * *N:set hlsearch<CR>
nnoremap # #N:set hlsearch<CR>

" q/Q and quit
nnoremap Q q
nnoremap q <Nop>
" nnoremap <leader>x :x<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>Q :copen<CR>

" paste
" BUG:在展开snippet的时候会进入v模式,如果要输入p开头的单词会触发粘贴
vnoremap p P
vnoremap P p

" format
nnoremap <leader>= gg=G<C-o>zz:w<CR>
vnoremap > >gv
vnoremap < <gv

" switch window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" resize window
nnoremap <C-Up>    :resize +2<CR>
nnoremap <C-Down>  :resize -2<CR>
nnoremap <C-Left>  :vertical resize +2<CR>
nnoremap <C-Right> :vertical resize -2<CR>

" previous and next buffer
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" emacs mode in insert_mode
inoremap <C-d>   <Del>
inoremap <C-a>   <Home>
inoremap <C-e>   <End>
inoremap <C-f>   <Right>
inoremap <C-b>   <Left>
inoremap <C-Del> <C-o>dw

inoremap <M-w> <C-Right>
inoremap <M-b> <C-Left>

inoremap <C-l> <C-o>zz

cnoremap <expr> ;; getcmdtype() == ':' ? expand('%:p:h') .'/' : ';p'
