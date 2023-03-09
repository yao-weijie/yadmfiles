augroup _general_settings
    autocmd!
    autocmd FileType TelescopePrompt,qf,help,man,lspinfo,checkhealth,startuptime,null-ls-info,spectre_panel,lspsagaoutline nnoremap <silent><buffer> q :close<CR>
    if has('nvim')
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({ timeout = 500 })
    endif
    autocmd BufWinEnter * set formatoptions-=cro
augroup end

augroup _hlsearch
    autocmd!
    autocmd cursorhold * set nohlsearch
augroup end

if has("wsl")
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup end
    endif
else
    set clipboard=unnamedplus
endif
