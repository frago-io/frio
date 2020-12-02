
let g:javascript_plugin_flow = 1

"Flow
let g:flow#autoclose = 1
let g:flow#enable = 0
let g:flow#omnifunc = 1

au Bufenter *.js nnoremap <A-x> :FlowMake<CR>
au Bufenter *.js nnoremap ≈ :FlowMake<CR>
