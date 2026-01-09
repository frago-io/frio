-- General settings
vim.opt.encoding = 'utf-8'
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.conceallevel = 0

-- Quickfix settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.wrap = true
  end
})

-- Javascript settings
vim.api.nvim_create_augroup("Javascript", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = "Javascript",
  pattern = "*.js",
  callback = function()
    vim.opt_local.colorcolumn = "81"
  end
})
vim.api.nvim_create_autocmd("BufLeave", {
  group = "Javascript",
  pattern = "*.js",
  callback = function()
    vim.opt_local.colorcolumn = "0"
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = "Javascript",
  pattern = { "*.js", "*.ts", "*.tsx" },
  callback = function()
    vim.keymap.set("n", "<leader>ic", "i//<Esc>78a-<Esc>a<CR><CR><Esc>78a-<Esc>ka<space>", { buffer = true })
  end
})

-- Haskell settings
vim.api.nvim_create_augroup("Haskell", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = "Haskell",
  pattern = "*.hs",
  callback = function()
    vim.keymap.set("n", "<A-g>", ":%!stylish-haskell<CR>", { buffer = true })
    vim.keymap.set("n", "©", ":%!stylish-haskell<CR>", { buffer = true })
    vim.keymap.set("n", "<A-z>", ":w<CR>:make<CR>", { buffer = true })
    vim.keymap.set("n", "Ω", ":w<CR>:make<CR>", { buffer = true })
    vim.keymap.set("n", "<leader>ic", "80i-<Esc>a<CR><space>\\|<space>", { buffer = true })

    vim.opt_local.colorcolumn = "81"
    vim.opt_local.formatoptions:append("t")
  end
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = "Haskell",
  pattern = "*.hs",
  callback = function()
    vim.opt_local.colorcolumn = "0"
    vim.opt_local.formatoptions:remove("t")
  end
})

vim.g.haskell_indent_disable = 1

-- Default settings
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
vim.opt.backspace = "indent,eol,start"
vim.opt.compatible = false
vim.opt.number = true
vim.opt.wrap = false
vim.opt.showmode = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.history = 1000
vim.opt.wildignore:append({ "*\\tmp\\*", "*.swp", "*.swo", "*.zip", ".git", ".cabal-sandbox" })
vim.opt.wildmode = "longest,list,full"
vim.opt.wildmenu = true
vim.opt.cmdheight = 1
vim.opt.ruler = true

-- Moving lines keymaps
vim.keymap.set("n", "˚", ":m .-2<CR>==")
vim.keymap.set("n", "∆", ":m .+1<CR>==")
vim.keymap.set("i", "˚", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "∆", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>")

-- Clean trailing spaces
vim.keymap.set("n", "¬", ":%s/\\s\\+$//e<CR>:let @/ = \"\"<CR>")

-- Function to highlight trailing spaces
vim.api.nvim_create_augroup("TrailSpaces", { clear = true })
vim.api.nvim_exec([[
  function! SetTrailSpaceHighlight()
    highlight ExtraWhitespace ctermbg=red guibg=firebrick4
    syntax match ExtraWhitespace /\s\+$/
  endfunction
]], false)

vim.api.nvim_create_autocmd("FileType", {
  group = "TrailSpaces",
  pattern = "*",
  callback = function()
    vim.cmd("call SetTrailSpaceHighlight()")
  end
})
vim.cmd("call SetTrailSpaceHighlight()")

-- Restrictions on arrow keys
vim.keymap.set("n", "<Up>", "<NOP>")
vim.keymap.set("n", "<Down>", "<NOP>")
vim.keymap.set("n", "<Left>", "<NOP>")
vim.keymap.set("n", "<Right>", "<NOP>")
vim.keymap.set("n", "-", "<NOP>")

-- Terminal settings
-- For Neovim, we don't need t_Co as it handles colors differently
-- Only use these settings for Vim compatibility mode if needed
if vim.fn.has('nvim') == 0 then
  vim.cmd([[
    set t_Co=256
    let t_8f = "[38:2:%lu:%lu:%lum"
    let t_8b = "[48:2:%lu:%lu:%lum"
  ]])
end

-- Custom commands
--vim.api.nvim_create_user_command("JSONFormat", ":%!jq '.'", {})
vim.api.nvim_create_user_command("JSONFormat", function()
  vim.bo.filetype = "json"
  vim.cmd(":%!jq '.'")
end, {})

-- Generic keymappings
vim.keymap.set("n", "<leader>/", "/\\c")
vim.keymap.set("n", "<leader>:/", "/\\c")
vim.keymap.set("n", "S", "<NOP>")
vim.keymap.set("n", "SS", ":w<cr>")
vim.keymap.set("n", "<C-Tab>", "<C-w><C-w>")
vim.keymap.set("n", "<A-/>", ":let @/ = \"\"<cr>")
--vim.keymap.set("n", "÷", ":let @/ = \"\"<cr>:lua require(\"notify\").dismiss()<cr>")
vim.keymap.set("n", "÷", ":let @/ = \"\"<cr>")
vim.keymap.set("n", "<C-J>", "mao<Esc>`a")
vim.keymap.set("n", "<C-K>", "maO<Esc>`a")
vim.keymap.set("n", "<space>", "i<space><esc>l")
vim.keymap.set("n", "<S-space>", "i<space><esc>l")
vim.keymap.set("n", "<tab>", "i<tab><esc>l")
vim.keymap.set("n", "ZA", ":suspend<CR>")
vim.keymap.set("n", "ZQ", ":q<CR>")
vim.keymap.set("n", "ZS", ":mks! ~/.local/.vim-sessions/rooster.vim<CR>")
vim.keymap.set("n", "ZX", ":source ~/.local/.vim-sessions/rooster.vim<CR>")
vim.keymap.set("n", "d{", "ldi}vhp")
vim.keymap.set("n", "d}", "hdi}vhp")
vim.keymap.set("n", "d(", "ldi)vhp")
vim.keymap.set("n", "d)", "hdi)vhp")
vim.keymap.set("n", "d[", "ldi]vhp")
vim.keymap.set("n", "d]", "hdi]vhp")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Scrolloff settings
vim.opt.scrolloff = 999
vim.keymap.set("n", "<Leader>zz", ":let &scrolloff=999-&scrolloff<CR>")
vim.opt.cursorline = true

-- True color support
if vim.fn.has("nvim") == 1 then
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end
if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

-- Tmux settings
-- In Neovim, we handle cursor shape differently
if vim.env.TMUX then
  -- Using vim.cmd for these complex terminal sequences
  vim.cmd([[
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=0\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
  ]])
end

-- C language settings
vim.api.nvim_create_augroup("CLang", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = "CLang",
  pattern = { "*.c", "*.cpp" },
  callback = function()
    vim.keymap.set("n", "Ω", "\\rc", { buffer = true })
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = "CLang",
  pattern = "*.c",
  callback = function()
    vim.keymap.set("n", "≈", ":make<CR>", { buffer = true })
  end
})

-- iPad Pro specific mappings
vim.keymap.set("", "ï", "ƒ")
vim.keymap.set("", "ô", "∆")

-- Filetype definitions
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.fs",
  command = "set filetype=fs"
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.fsx",
  command = "set filetype=fs"
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.cljc",
  command = "set filetype=clojure"
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ts",
  command = "set filetype=typescript"
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tsx",
  command = "set filetype=typescriptreact"
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.js.flow",
  command = "set filetype=javascript"
})

-- Sophia filetype settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "aes",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end
})

-- Haskell filetype settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "haskell",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end
})
-- JavaScript filetype settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "vue", "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end
})

-- Neovide logo usage
vim.g.neovide_input_use_logo = 1
vim.keymap.set("", "<D-v>", "\"+p<CR>")
vim.keymap.set("!", "<D-v>", "<C-R>+")
vim.keymap.set("t", "<D-v>", "<C-R>+")
vim.keymap.set("v", "<D-c>", "\"+y<CR>")

-- Copilot settings
vim.keymap.set("i", "<M-p>", "<Plug>(copilot-next)")
vim.keymap.set("i", "π", "<Plug>(copilot-next)")
vim.keymap.set("i", "<M-n>", "<Plug>(copilot-next)")
vim.keymap.set("i", "ø", "<Plug>(copilot-previous)")
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap('i', '<C-Space>', 'copilot#Accept("\\<CR>")', { silent = true, expr = true, script = true })

-- Neovide settings
vim.opt.guifont = "MesloLGS\\ Nerd\\ Font:h14.5"
if vim.g.neovide then
  -- Using vim.opt.mousescroll directly with a string causes issues
  -- Setting mousescroll options individually
  vim.cmd("set mousescroll=ver:3,hor:0")
  vim.keymap.set("n", "<D-=>", ":let g:neovide_scale_factor += 0.1<CR>")
  vim.keymap.set("n", "<D-->", ":let g:neovide_scale_factor -= 0.1<CR>")
  vim.keymap.set("n", "<D-0>", ":let g:neovide_scale_factor = 1.0<CR>")
end

-- Signs for errors
vim.fn.sign_define("DiagnosticSignError", { text = "◉", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "◉", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "💡", texthl = "DiagnosticSignHint" })

vim.cmd("highlight DiagnosticSignError guifg=#F60067 gui=bold")
vim.diagnostic.config({
  signs = {
    priority = 100,  -- Increase priority (default is usually lower)
  },
})
vim.opt.signcolumn = "yes:2"
--vim.api.nvim_set_keymap('n', '<Leader>q', ':cclose<CR>', { noremap = true, silent = true })
