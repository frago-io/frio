require("mason").setup()

local lspconfig = require("lspconfig")

-- Global default configuration
local default_hls_config = {
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
    },
  },
  cmd = { "haskell-language-server-wrapper", "--lsp" },
}

-- Function to find and load project-specific config
local function get_project_config()
  local project_config_file = vim.fn.getcwd() .. "/.vim/haskell-lsp.lua"
  if vim.fn.filereadable(project_config_file) == 1 then
    local config = dofile(project_config_file)
    return config
  end
  return nil
end

-- Combine default with project-specific config
local function setup_hls()
  local config = vim.deepcopy(default_hls_config)
  local project_config = get_project_config()

  if project_config then
    -- Merge project config with default config
    for k, v in pairs(project_config) do
      if type(v) == "table" and type(config[k]) == "table" then
        config[k] = vim.tbl_deep_extend("force", config[k], v)
      else
        config[k] = v
      end
    end
  end

  require("lspconfig").hls.setup(config)
end

-- Call the setup function
setup_hls()

-- Example project-specific config in `~/.vim/haskell-lsp.lua`
-- return {
--   cmd = { "haskell-language-server", "--lsp" },
--   -- Any other project-specific settings
--   settings = {
--     haskell = {
--       -- Override or add settings as needed
--       -- These will be merged with the defaults
--     },
--   },
-- }



lspconfig.ts_ls.setup({})  -- TypeScript/JavaScript
lspconfig.yamlls.setup({})  -- YAML LSP
lspconfig.rnix.setup({})  -- Nix LSP
-- lspconfig.lean.setup({})  -- Lean LSP

-- Global Mappings for LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })  -- Go to definition
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })  -- Hover documentation
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })  -- Rename symbol
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })  -- Code actions
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })  -- Show references
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })  -- Previous diagnostic
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })  -- Next diagnostic
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ap", vim.diagnostic.goto_prev, { noremap = true, silent = true })  -- Previous diagnostic
vim.keymap.set("n", "<Leader>an", vim.diagnostic.goto_next, { noremap = true, silent = true })  -- Next diagnostic
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { noremap = true, silent = true })


-- Enable LSP UI Enhancements (Floating Windows)
vim.diagnostic.config({
  virtual_text = false,  -- Similar to `diagnostic.virtualText: false`
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Autoformat on Save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.hs", "*.ts", "*.tsx", "*.yaml", "*.nix" },
  callback = function() vim.lsp.buf.format() end,
})

-- State variable to track if popup is currently closed by user
local popup_manually_closed = false
local current_diagnostic_pos = nil

-- -------------------------------------
-- Show diagnostics popup on cursor hold
-- -------------------------------------
vim.o.updatetime = 300  -- Show popup quickly

vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    -- Get current diagnostic
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor_pos[1] - 1
    local current_col = cursor_pos[2]
    local diagnostics = vim.diagnostic.get(0, {
      lnum = current_line,
    })

    -- Only show popup if we have diagnostics and either:
    -- 1. We haven't manually closed it, or
    -- 2. We've moved to a different diagnostic position
    if #diagnostics > 0 then
      local new_pos = current_line .. ":" .. current_col
      if not popup_manually_closed or new_pos ~= current_diagnostic_pos then
        current_diagnostic_pos = new_pos
        popup_manually_closed = false
        vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
      end
    end
  end,
})

-- Close floating windows and set manually closed flag
vim.keymap.set("n", "<Esc>", function()
  local closed_any = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
      closed_any = true
    end
  end
  if closed_any then
    popup_manually_closed = true
    current_diagnostic_pos = vim.api.nvim_win_get_cursor(0)[1] - 1 .. ":" .. vim.api.nvim_win_get_cursor(0)[2]
  end
end, { noremap = true, silent = true })
