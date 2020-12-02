augroup LanguageClient
    nnoremap <leader>] :call LanguageClient#textDocument_definition()<CR>

    let g:LanguageClient_rootMarkers = ['package.json']
    let g:LanguageClient_serverCommands = {
                \ 'javascript': ['flow', 'lsp'],
                \ }

    let g:LanguageClient_diagnosticsEnable=0
    let g:LanguageClient_diagnosticsDisplay= {
                \1: {
                \"name": "Error",
                \"texthl": "ALEError",
                \"signText": "•",
                \"signTexthl": "ALEErrorSign",
                \},
                \2: {
                \"name": "Warning",
                \"texthl": "ALEWarning",
                \"signText": "❕",
                \"signTexthl": "ALEWarningSign",
                \},
                \3: {
                \"name": "Information",
                \"texthl": "ALEInfo",
                \"signText": "ℹ",
                \ "signTexthl": "ALEInfoSign",
                \},
                \4: {
                \ "name": "Hint",
                \ "texthl": "ALEInfo",
                \ "signText": "➤",
                \ "signTexthl": "ALEInfoSign",
                \},
                \}


    let g:LanguageClient_hoverPreview = 'Never'

    au Bufenter *.js nnoremap ≈ :FlowMake<CR>
    au Bufenter *.js nnoremap ≥ :call LanguageClient#textDocument_hover()<CR>
    au Bufenter *.js nnoremap <C-]> :w<CR>:call LanguageClient#textDocument_definition()<CR>

    au Bufenter *.fs nnoremap ≥ :call LanguageClient#textDocument_hover()<CR>
    au Bufenter *.fs nnoremap <leader>ir :call LanguageClient#textDocument_references()<CR>
    au Bufenter *.fs nnoremap <C-]> :call LanguageClient#textDocument_definition()<CR>
    au Bufenter *.fs map Ω :w<CR>:make<CR>
    au Bufenter *.fsx nnoremap ≥ :call LanguageClient#textDocument_hover()<CR>
    au Bufenter *.fsx nnoremap <C-]> :call LanguageClient#textDocument_definition()<CR>

    "nnoremap Ô <C-W><C-J>
    "nnoremap  <C-W><C-K>
    "nnoremap Ó <C-W><C-L>
    "nnoremap Ò <C-W><C-H>

    au Bufenter *.ts nnoremap ≥ :call LanguageClient#textDocument_hover()<CR>
    au Bufenter *.ts nnoremap <C-]> :call LanguageClient#textDocument_definition()<CR>
    au Bufenter *.tsx nnoremap ≥ :call LanguageClient#textDocument_hover()<CR>
    au Bufenter *.tsx nnoremap <C-]> :call LanguageClient#textDocument_definition()<CR>

augroup END
