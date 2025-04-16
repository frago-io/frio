local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        --path_display = function(_, path)
            --local max_length = 55  -- Adjust as needed
            --if #path > max_length then
                --local half = math.floor((max_length - 3) / 2)
                --return path:sub(1, half) .. "..." .. path:sub(-half)
            --end
            --return path
        --end,
        layout_strategy = "vertical",
        prompt_prefix = "🔍 ",
        selection_caret = "➜ ",
        winblend = 5,
        --layout_config = { preview_width = 0.5 },
    },
    pickers = {
        find_files = { hidden = true, no_ignore = true, follow = true },
        buffers = { sort_lastused = true, ignore_current_buffer = true },
        live_grep = { only_sort_text = true },
        oldfiles = { only_cwd = true },
    },
})

-- Define mappings (same style as your fzf-preview setup)
-- vim.keymap.set("n", "<Leader>fp", function() builtin.find_files({ hidden = true, no_ignore = true }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fgs", builtin.git_status, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fga", builtin.git_commits, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fb", builtin.buffers, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fB", function() builtin.buffers({ sort_lastused = false }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fo", builtin.oldfiles, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>f<C-o>", builtin.jumplist, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fg;", builtin.git_bcommits, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>f/", builtin.current_buffer_fuzzy_find, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>f*", function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fgr", function() builtin.live_grep({ additional_args = function() return { "--hidden", "--no-ignore" } end }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ft", builtin.tags, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fq", builtin.quickfix, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fl", builtin.loclist, { noremap = true, silent = true })

-- <C-p> should find **all** files (ignoring .gitignore)
-- vim.keymap.set("n", "<C-p>", function() builtin.find_files({ hidden = true, no_ignore = true }) end, { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', ':Telescope git_files<CR>', { noremap = true, silent = true })
-- Buffers (like `:Buffers`)
vim.keymap.set("n", "<C-b>", builtin.buffers, { noremap = true, silent = true })

-- Search lines in the current buffer (like `:BLines`)
vim.keymap.set("n", "<C-l>", builtin.current_buffer_fuzzy_find, { noremap = true, silent = true })

-- Find files (like `:Files`)
vim.keymap.set("n", "<C-t>", function() builtin.find_files({ hidden = true, no_ignore = true }) end, { noremap = true, silent = true })

-- Grep for the word under cursor (like `:Ag <C-r><C-w>`)
vim.keymap.set("n", "<Leader>*", function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end, { noremap = true, silent = true })

-- Grep for selected text in visual mode (like `:Ag <C-r><C-w>` in visual mode)
vim.keymap.set("v", "<Leader>*", function()
  local text = vim.fn.getreg("v")  -- Get the visually selected text
  builtin.grep_string({ search = text })
end, { noremap = true, silent = true })

vim.api.nvim_create_user_command('Tg', function(opts)
  require('telescope.builtin').live_grep({
    default_text = opts.args,
  })
end, {
  nargs = '*',  -- Accept zero or more arguments
})

