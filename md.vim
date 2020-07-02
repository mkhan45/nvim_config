nnoremap <C-Space> :s/\[ \]/\[X\]/g<CR> :let @/ = "" <CR>
nnoremap <C-n> :s/\[X\]/\[ \]/g<CR> :let @/ = "" <CR>

function! Open_parens_firefox()
   call feedkeys("\"uyi\(")
   call system("firefox " . @u)
endfunction

nnoremap <C-o> :call Open_parens_firefox()<CR>
