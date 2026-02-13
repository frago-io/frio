require("mason").setup()

local lspconfig = require("lspconfig")

local function codeLens(client, bufnr)
    -- Enable code lens refreshing
    if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
    end
end

-- Global default configuration
local default_hls_config = {
    settings = {
        haskell = {
            formattingProvider = "fourmolu",
        },
    },
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    on_attach = codeLens,
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


lspconfig.ts_ls.setup({on_attach = codeLens,})  -- TypeScript/JavaScript
lspconfig.yamlls.setup({on_attach = codeLens,})  -- YAML LSP
lspconfig.rnix.setup({on_attach = codeLens,})  -- Nix LSP
-- lspconfig.lean.setup({})  -- Lean LSP
lspconfig.aiken.setup({on_attach = codeLens,})  -- Aiken LSP

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
  pattern = { "*.hs", "*.ts", "*.tsx", "*.yaml", "*.nix", "*.ak" },
  callback = function() vim.lsp.buf.format() end,
})

-- State variable to track if popup is currently closed by user
local popup_manually_closed = false
local current_diagnostic_pos = nil


vim.keymap.set("n", "gce", vim.lsp.codelens.run, { noremap = true, silent = true, desc = "Run CodeLens" })
vim.keymap.set("n", "gca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code Actions" })

