
autocmd FileType haskell nnoremap <buffer> <A-.> :Hoogle <C-r><C-w><CR>
autocmd FileType haskell nnoremap <buffer> ≥ :Hoogle <C-r><C-w><CR>

let g:hoogle_fzf_copy_import = '<A-c>'
let g:hoogle_fzf_copy_import = 'ç'

let g:hoogle_fzf_copy_type = '<A-x>'
let g:hoogle_fzf_copy_type = '≈'

let g:hoogle_fzf_open_browser = '<A-s>'
let g:hoogle_fzf_open_browser = 'ß'

let g:hoogle_fzf_cache_file = '~/.config/hoogle_cache.json'
