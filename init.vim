set runtimepath^=~/.vim runtimepath+=~/.vim/after
hi Normal ctermbg=none

colo photon
set foldmethod=indent
set foldlevelstart=99

set nocompatible
filetype off
" set rtp+=~/.vim/bundle/vundle/
" call vundle#rc()
" Plugin 'gmarik/vundle'

" " We could also add repositories with a ".git" extension
" Plugin 'gmarik/Vundle.vim'
" Plugin 'glacambre/firenvim'
" Plugin 'pangloss/vim-javascript'
" Plugin 'jpalardy/vim-slime'
" Plugin 'machakann/vim-sandwich'
" Plugin 'tbastos/vim-lua'
" Plugin 'tpope/vim-commentary'
" Plugin 'udalov/kotlin-vim'
" Plugin 'easymotion/vim-easymotion'
" Plugin 'Shougo/denite.nvim'
" Plugin 'christoomey/vim-system-copy'
" Plugin 'lervag/vimtex'
" Plugin 'NLKNguyen/papercolor-theme'
" Plugin 'rust-lang/rust.vim'
" Plugin 'tikhomirov/vim-glsl'
" Plugin 'calviken/vim-gdscript3'
" Plugin 'neovimhaskell/haskell-vim'
" Plugin 'junegunn/goyo.vim'
" " Plugin 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
" Plugin 'neoclide/coc.nvim', {'branch' : 'release'}

call plug#begin('~/.vim/plugged')
Plug 'glacambre/firenvim'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/denite.nvim'
Plug 'christoomey/vim-system-copy'
Plug 'lervag/vimtex'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'calviken/vim-gdscript3'
Plug 'neovimhaskell/haskell-vim'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', {'branch' : 'release'}
call plug#end()

filetype plugin indent on

" call coc#util#install()
"

let g:slime_target = "tmux"

" easymotion
map o <Plug>(easymotion-prefix)

let g:system_copy#copy_command='xclip -sel clipboard'

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap t gt
nnoremap T gT
nnoremap <C-n> :!tree \| less<CR>

"make coc.nvim work w/ tab autocomplete
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<C-l>'
imap <C-l> <Plug>(coc-snippets-expand-jump)

" hi Normal ctermfg=254 ctermbg=none
set nu
set relativenumber

nmap <F8> :TagbarToggle<CR>

" clears highlight on enter
verb map <Enter> :let @/ = "" <CR>

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
let g:python_recommended_style = 0

let g:UltiSnipsExpandTrigger="<tab>"

"
let g:coc_global_extensions = [
   \ 'coc-snippets',
   \ 'coc-pairs',
   \ 'coc-tsserver',
   \ 'coc-rls',
   \ 'coc-tslint',
   \ 'coc-vimtex',
   \ 'coc-json',
   \ 'coc-python',
   \ 'coc-css',
   \ 'coc-pairs',
   \ 'coc-git',
   \ 'coc-highlight',
   \ 'coc-snippets',
   \ 'coc-actions',
   \]

" denite stuff
autocmd FileType denite call s:denite_my_settings()

function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action', 'open')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction

call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--block-buffered'])

call denite#custom#map(
            \ 'insert',
            \ '<C-j>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-k>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)
call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>',
            \'noremap')

" nmap <C-p> :Denite file/rec -winwidth=100 -winheight=20 -split=floating<CR>i
nmap <C-p> :Denite file/rec<CR>i
nmap <S-p> :Denite grep:. -no-empty -winwidth=100 -winheight=20 -split=floating<CR>

nmap <Leader>t :TagbarToggle<CR>

function! s:cocActionsOpenFromSelected(type) abort
   execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

imap <C-l> <Plug>(coc-snippets-expand)
nmap <F2> <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)
nmap gd <Plug>(coc-definition)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
   if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
   else
      call CocAction('doHover')
   endif
endfunction


au BufRead,BufNewFile *.md set filetype=md

autocmd Filetype rust source ~/.config/nvim/rust.vim
autocmd Filetype c source ~/.config/nvim/c.vim
autocmd Filetype cpp source ~/.config/nvim/cpp.vim
autocmd Filetype python source ~/.config/nvim/python.vim
autocmd Filetype md source ~/.config/nvim/md.vim
autocmd TermOpen * set nonumber norelativenumber

let g:term_buf = 0
let g:term_win = 0

function! Term_toggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

function! Term_run(cmd)
   if win_gotoid(g:term_win)
      call feedkeys("a". a:cmd ."\<CR>\<ESC>")
   else
      call Term_toggle(12)
      call feedkeys(a:cmd ."\<CR>")
   endif
endfunction

nnoremap <C-b> :call Term_toggle(12)<cr>
tnoremap <C-b> <C-\><C-n>:call Term_toggle(13)<cr>
set hidden

syntax on
let g:vimtex_view_method = 'zathura'

inoremap jk <Esc>
tnoremap jk <C-\><C-n>

inoremap <C-w> <Esc>:bn<CR>
inoremap <C-S-w> <Esc>:bp<CR>
nnoremap <C-w> :bp<CR>
nnoremap <C-S-w> :bp<CR>
nnoremap <S-s> :split<CR>

:command Wmode :Goyo 100 | :set wrap linebreak nolist

cd %:p:h

"statusline
set laststatus=2
set statusline=
set statusline+=%f
set statusline+=%=
set statusline+=%m
set statusline+=%r
set statusline+=\ 
set statusline+=|
set statusline+=\ 
set statusline+=%P
set statusline+=\ 
set statusline+=|
set statusline+=\ 
set statusline+=%{strftime(\"%H:%M\")}

if exists('g:started_by_firenvim')
   set laststatus=0
   colo PaperColor
   set background=light
   set wrap linebreak nolist
else
   set guifont=DejaVu\ Sans\ Mono:h16
   hi Normal guibg=#1b1b1c
   set guifont=DejaVu\ Sans\ Mono:h19
endif

" add
silent! nmap <unique> sa <Plug>(operator-sandwich-add)
silent! xmap <unique> sa <Plug>(operator-sandwich-add)
silent! omap <unique> sa <Plug>(operator-sandwich-g@)

" delete
silent! xmap <unique> sd <Plug>(operator-sandwich-delete)

" replace
silent! xmap <unique> sr <Plug>(operator-sandwich-replace)
