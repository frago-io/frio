augroup General
    set encoding=utf-8
    set noswapfile
    set hlsearch

    set conceallevel=0
augroup END

augroup Quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

augroup Javascript
    au Bufenter *.js set colorcolumn=81
    au BufLeave *.js set colorcolumn=0

    au Bufenter *.js nnoremap <leader>ic i//<esc>78a-<esc>a<CR><CR><esc>78a-<esc>ka<space>
augroup END

augroup Haskell
    au Bufenter *.hs nnoremap <A-g> :%!stylish-haskell<CR>
    au Bufenter *.hs nnoremap © :%!stylish-haskell<CR>

    au Bufenter *.hs map <A-z> :w<CR>:make<CR>
    au Bufenter *.hs map Ω :w<CR>:make<CR>

    au Bufenter *.hs set colorcolumn=81
    au Bufenter *.hs set fo+=t
    "au Bufenter *.hs set tw=80
    au BufLeave *.hs set colorcolumn=0
    au BufLeave *.hs set fo-=t

    au Bufenter *.hs nnoremap <leader>ic 80i-<esc>a<CR><space>\|<space>

    let g:haskell_indent_disable = 1
augroup END

augroup Defaults
    syntax on
    filetype plugin indent on
    set backspace=indent,eol,start
    set nocompatible
    set number
    set nowrap
    set showmode
    "set tw=90
    set smartcase
    set smarttab
    set smartindent
    set autoindent
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set incsearch
    set mouse=a
    set history=1000

    set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
    set wildmode=longest,list,full
    set wildmenu

    set cmdheight=2
    
    "set relativenumber
    set ruler

augroup END

augroup MovingLines
    nnoremap ˚ :m .-2<CR>==
    nnoremap ∆ :m .+1<CR>==

    inoremap ˚ <Esc>:m .-2<CR>==gi
    inoremap ∆ <Esc>:m .+1<CR>==gi

    vnoremap ˚ :m '<-2<CR>gv=gv
    vnoremap ∆ :m '>+1<CR>gv=gv

    inoremap jk <Esc>
    inoremap jj <Esc>
    inoremap kk <Esc>
augroup END

augroup CleanTrailSpaces

    nnoremap ¬ :%s/\s\+$//e<CR>

    function! SetTrailSpaceHighlight()
        highlight ExtraWhitespace ctermbg=red guibg=firebrick4
        syntax match ExtraWhitespace /\s\+$/
    endfunction
    au FileType * call SetTrailSpaceHighlight()
augroup END

augroup Restrictions
    nnoremap   <Up>     <NOP>
    nnoremap   <Down>   <NOP>
    nnoremap   <Left>   <NOP>
    nnoremap   <Right>  <NOP>
    nnoremap   -        <NOP>
augroup END

augroup TerminalShit
    set t_Co=256
    " have now ideea what those two lines below do
    let t_8f = "[38:2:%lu:%lu:%lum"
    let t_8b = "[48:2:%lu:%lu:%lum"
augroup END

command JSONFormat :%!python -m json.tool

augroup GenericKeyMapings
    "search
    nnoremap <leader>/ /\c
    nnoremap <leader>:/ /\c

    "saving 
    nnoremap S <NOP>
    nnoremap SS :w<cr>

    nmap <C-Tab> <C-w><C-w>

    "clear search
    nnoremap <A-/> :let @/ = ""<cr>
    nnoremap ÷ :let @/ = ""<cr>
    
    " new line and enter in the normal mode
    nnoremap <C-J> mao<Esc>`a
    nnoremap <C-K> maO<Esc>`a

    " space and tab in normal mode
    nnoremap <space> i<space><esc>l
    nnoremap <S-space> i<space><esc>l
    nnoremap <tab> i<tab><esc>l

    " Z-Shortcuts
    nnoremap ZA :suspend<CR>
    nnoremap ZQ :q<CR>
    
    "save vim session
    nnoremap ZS :mks! ~/.local/.vim-sessions/rooster.vim<CR>
    "restore vim session
    nnoremap ZX :source ~/.local/.vim-sessions/rooster.vim<CR>

    "delete paranthesis and others
    nnoremap d{ ldi}vhp
    nnoremap d} hdi}vhp

    nnoremap d( ldi)vhp
    nnoremap d) hdi)vhp

    nnoremap d[ ldi]vhp
    nnoremap d] hdi]vhp

    "escaping from `:terminal` mode
    tnoremap <Esc> <C-\><C-n>

augroup END

augroup Scrolloff
    nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>
    set cursorline
augroup END

augroup TrueColor
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors"))
        set termguicolors
    endif
augroup END

augroup Tmux
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=0\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
augroup END

augroup CLang
    au Bufenter *.c map Ω \rc
    au Bufenter *.cpp map Ω \rc
    au Bufenter *.c nnoremap ≈ :make<CR>
augroup END

augroup CLang
    "ipadpro
    "ï - alt f - ƒ
    map ï ƒ
    map ô ∆
augroup END


" fixing some filetypes that vim migh not know
augroup FilTypes
    au BufRead,BufNewFile *.fs set filetype=fs
    au BufRead,BufNewFile *.fsx set filetype=fs
    au BufRead,BufNewFile *.cljc set filetype=clojure
    au BufRead,BufNewFile *.ts set filetype=typescript
    au BufRead,BufNewFile *.tsx set filetype=typescript
    au BufRead,BufNewFile *.js.flow set filetype=javascript
augroup END

" Old ones which don't know if i need them anymore!!!
augroup Commented
"autocmd FileType javascript setlocal omnifunc=echo
augroup END
