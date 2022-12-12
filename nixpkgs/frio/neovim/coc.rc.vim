augroup coc

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    "nmap <silent> [g <Plug>(coc-diagnostic-prev)
    "nmap <silent> ]g <Plug>(coc-diagnostic-next)
    "WARNING: these overlapp over ALE, if ale enabled use previous
    nmap <silent> <leader>ap <Plug>(coc-diagnostic-prev)
    nmap <silent> <leader>an <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> gcr :CocRestart<CR>
    nmap <silent> gce <Plug>(coc-codelens-action)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    "autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current line.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Introduce function text object
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for selections ranges.
    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
    " coc-tsserver, coc-python are the examples of servers that support it.
    "nmap <silent> <TAB> <Plug>(coc-range-select)
    "xmap <silent> <TAB> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    "
    "highlight CocCodeLens guifg=#5c6370
    function! SetCocHighlight()
        "highlight CocCodeLens guifg=#5c6370
        "highlight CocErrorLine ctermfg=9 ctermbg=15 guifg=#d7424d
        "
        "highlight CocWarningHighlight ctermfg=11 ctermbg=15 guifg=#E5C07B
        "highlight CocHintHighlight ctermfg=9 ctermbg=15 guifg=#d7424d
        "highlight CocInfoHighlight ctermfg=9 ctermbg=15 guifg=#d7424d
        "highlight CocWarningHighlight ctermfg=9 ctermbg=15 guifg=#d7424d
        highlight CocErrorHighlight ctermfg=9 ctermbg=15 guifg=#d7424d
        highlight CocUnusedHighlight  ctermfg=11 ctermbg=15 guifg=#FFAF00

        "highlight CocCodeLens guifg=#5c6370
        "highlight CocCodeLens guifg=#434c5e
        highlight CocCodeLens guifg=#39404f
        "highlight CocCodeLens guifg=#3f4550
        "highlight CocCodeLens guifg=#343942
    endfunction

    call SetCocHighlight()

    "mantocarie mare mare!!!!, din cauza ca nu stiu cine draq ii ia culoarea lu ale
    au FileType javascript call SetCocHighlight()
    au FileType sh call SetCocHighlight()
    au FileType c call SetCocHighlight()
    au FileType json call SetCocHighlight()
    au FileType html call SetCocHighlight()
    au FileType lua call SetCocHighlight()
    au FileType xml call SetCocHighlight()
    au FileType haskell call SetCocHighlight()
    au FileType cpp call SetCocHighlight()
    au FileType nix call SetCocHighlight()
    au FileType typescript call SetCocHighlight()
    au FileType typescriptreact call SetCocHighlight()

    function! SynStack()
        if !exists("*synstack")
            return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunc
    function! Syn()
        for id in synstack(line("."), col("."))
            echo synIDattr(id, "name")
        endfor
    endfunction
    command! -nargs=0 Syn call Syn()

    "To make <cr> select the first completion item and confirm the completion when no item has been selected:
    inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

    inoremap <silent><expr> <C-space> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"


    "Use <Tab> and <S-Tab> to navigate the completion list:
    inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
    inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"


augroup END

