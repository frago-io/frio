augroup Ale
    let g:ale_sign_error = "◉"
    let g:ale_sign_warning = "◉"

    let g:ale_linters = {
                \  'haskell': ['hlint'],
                \  'javascript': [],
                \}
                ""\  'cs': ['OmniSharp'],
                "\  'javascript': ['eslint','flow'],
                "\  'typescript': [ 'tslint', 'tsserver'],
    let g:ale_fixers = {
                "\  'haskell': ['hlint'],
                \  'vue': ['eslint'],
                \}
                """\  'haskell': ['hlint','stylish-haskell'],
                ""\  'javascript': ['eslint'],
                "\  'typescript': ['tslint'],
    let g:ale_fix_on_save = 1
    "let g:ale_javascript_eslint_use_global = 1
    "let g:ale_javascript_flow_use_global = 1
    let g:ale_set_highlights = 1

    let g:airline#extensions#ale#enabled = 1

    "highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
    "highlight clear ALEWarningSign " otherwise uses error bg color (typically red)


    function! SetAleHighlight()
        highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#d7424d
        highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#FFAF00
        "highlight CocCodeLens guifg=#5c6370
        "highlight CocCodeLens guifg=#343942
    endfunction

    call SetAleHighlight()

    "mantocarie mare mare!!!!, din cauza ca nu stiu cine draq ii ia culoarea lu ale
    au FileType javascript call SetAleHighlight()
    au FileType sh call SetAleHighlight()
    au FileType c call SetAleHighlight()
    au FileType json call SetAleHighlight()
    au FileType html call SetAleHighlight()
    au FileType lua call SetAleHighlight()
    au FileType xml call SetAleHighlight()
    au FileType haskell call SetAleHighlight()
    au FileType cpp call SetAleHighlight()
    au FileType nix call SetAleHighlight()
    au FileType typescript call SetAleHighlight()
    au FileType typescriptreact call SetAleHighlight()

    "endif
    let g:ale_statusline_format = ['X %d', '? %d', '']
    let g:ale_echo_msg_format = '%linter% says %s'

    " Map keys to navigate between lines with errors and warnings.
    "nnoremap <leader>an :ALENextWrap<cr>
    "nnoremap <leader>ap :ALEPreviousWrap<cr>
    nnoremap gn :ALENextWrap<cr>
    nnoremap gp :ALEPreviousWrap<cr>

    noremap ƒ :ALEFix<cr>
augroup END
