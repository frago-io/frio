-- Static curated keymap reference, grouped by plugin/section
-- Usage:
--   :Maps            — show all keymaps
--   :Maps <section>  — filter by section (fuzzy, e.g. :Maps tele, :Maps lsp)

local sections = {
  {
    name = "General",
    maps = {
      { "n", "˚  (Alt+K)",      "Move line up" },
      { "n", "∆  (Alt+J)",      "Move line down" },
      { "i", "˚  (Alt+K)",      "Move line up (insert)" },
      { "i", "∆  (Alt+J)",      "Move line down (insert)" },
      { "v", "˚  (Alt+K)",      "Move selection up" },
      { "v", "∆  (Alt+J)",      "Move selection down" },
      { "i", "jk / jj / kk",   "Exit insert mode" },
      { "n", "¬  (Alt+L)",      "Clean trailing whitespace" },
      { "n", "÷  (Alt+/)",      "Clear search highlight" },
      { "n", "SS",              "Save file (:w)" },
      { "n", "<C-J>",           "Insert blank line below" },
      { "n", "<C-K>",           "Insert blank line above" },
      { "n", "<space>",         "Insert space at cursor" },
      { "n", "<tab>",           "Insert tab at cursor" },
      { "n", "<C-Tab>",         "Switch to next window" },
      { "n", "\\leader /",      "Case-insensitive search" },
      { "n", "\\leader zz",     "Toggle centered cursor scrolling" },
      { "t", "<Esc>",           "Exit terminal to normal mode" },
    },
  },
  {
    name = "Sessions & Quit",
    maps = {
      { "n", "ZA",   "Suspend Neovim (Ctrl+Z)" },
      { "n", "ZQ",   "Quit without saving" },
      { "n", "ZS",   "Save session" },
      { "n", "ZX",   "Load session" },
    },
  },
  {
    name = "Delete Surround",
    maps = {
      { "n", "d{  d}",   "Delete surrounding {}" },
      { "n", "d(  d)",   "Delete surrounding ()" },
      { "n", "d[  d]",   "Delete surrounding []" },
    },
  },
  {
    name = "NERDTree",
    maps = {
      { "n", ",m",   "Toggle NERDTree" },
      { "n", ",n",   "Find current file in NERDTree" },
    },
  },
  {
    name = "Telescope",
    maps = {
      { "n", "<C-p>",           "Git files" },
      { "n", "<C-t>",           "Find all files (hidden+ignored)" },
      { "n", "<C-b>",           "Buffers" },
      { "n", "<C-l>",           "Fuzzy find in current buffer" },
      { "n", "\\leader *",      "Grep word under cursor" },
      { "v", "\\leader *",      "Grep selected text" },
      { "n", "\\leader fb",     "Buffers" },
      { "n", "\\leader fB",     "Buffers (unsorted)" },
      { "n", "\\leader fo",     "Recent files" },
      { "n", "\\leader f<C-o>", "Jump list" },
      { "n", "\\leader fgs",    "Git status" },
      { "n", "\\leader fga",    "Git commits" },
      { "n", "\\leader fg;",    "Git buffer commits" },
      { "n", "\\leader fgr",    "Live grep (hidden+ignored)" },
      { "n", "\\leader f/",     "Fuzzy find in buffer" },
      { "n", "\\leader f*",     "Grep word under cursor" },
      { "n", "\\leader ft",     "Tags" },
      { "n", "\\leader fq",     "Quickfix list" },
      { "n", "\\leader fl",     "Location list" },
    },
  },
  {
    name = "LSP",
    maps = {
      { "n", "gd",           "Go to definition" },
      { "n", "K",            "Hover documentation" },
      { "n", "gr",           "Find all references" },
      { "n", "gy",           "Go to type definition" },
      { "n", "\\leader rn",  "Rename symbol" },
      { "n", "\\leader ca",  "Code action" },
      { "n", "gca",          "Code action (alt)" },
      { "n", "gce",          "Run CodeLens" },
      { "n", "[d",           "Previous diagnostic" },
      { "n", "]d",           "Next diagnostic" },
      { "n", "\\leader ap",  "Previous diagnostic (alt)" },
      { "n", "\\leader an",  "Next diagnostic (alt)" },
    },
  },
  {
    name = "Completion (nvim-cmp)",
    maps = {
      { "i", "<Tab>",    "Next completion item" },
      { "i", "<S-Tab>",  "Previous completion item" },
      { "i", "<CR>",     "Confirm completion" },
      { "i", "<C-n>",    "Trigger completion" },
    },
  },
  {
    name = "99 (AI Agent)",
    maps = {
      { "n", "\\leader 9s",  "AI search → quickfix list" },
      { "v", "\\leader 9v",  "Visual: send to AI, replace" },
      { "n", "\\leader 9x",  "Cancel all AI requests" },
      { "n", "\\leader 9m",  "Switch AI model (Telescope)" },
      { "n", "\\leader 9p",  "Switch AI provider (Telescope)" },
    },
  },
  {
    name = "Copilot",
    maps = {
      { "i", "π  (Alt+P)",   "Next suggestion" },
      { "i", "ø  (Alt+O)",   "Previous suggestion" },
      { "i", "<C-Space>",    "Accept suggestion" },
    },
  },
  {
    name = "Git (Fugitive/Gitgutter)",
    maps = {
      { "n", ":G",            "Git status (Fugitive)" },
      { "n", ":Gblame",       "Git blame" },
      { "n", ":Gdiffsplit",   "Git diff split" },
      { "n", ":GBrowse",      "Open in GitLab" },
    },
  },
  {
    name = "Tabular / Alignment",
    maps = {
      { "v", "a=",   "Align on =" },
      { "v", "a;",   "Align on ::" },
      { "v", "a:",   "Align on :" },
      { "v", "a-",   "Align on ->" },
      { "v", "a<",   "Align on <-" },
      { "x", "ga",   "EasyAlign (visual)" },
      { "n", "ga",   "EasyAlign (motion)" },
    },
  },
  {
    name = "CamelCaseMotion",
    maps = {
      { "*", ",w",    "Forward by camelCase word" },
      { "*", ",b",    "Backward by camelCase word" },
      { "*", ",e",    "End of camelCase word" },
      { "*", ",ge",   "End of previous camelCase word" },
    },
  },
  {
    name = "Colorscheme",
    maps = {
      { "*", "˘  (Shift+Alt+>)",   "Next colorscheme" },
      { "*", "¯  (Shift+Alt+<)",   "Previous colorscheme" },
    },
  },
  {
    name = "Grammarous",
    maps = {
      { "n", "\\leader age",   "Grammar check (English)" },
      { "n", "\\leader agr",   "Grammar check (Romanian)" },
    },
  },
  {
    name = "Haskell",
    maps = {
      { "n", "©  (Alt+G)",     "Format with stylish-haskell" },
      { "n", "Ω  (Alt+Z)",     "Save and make" },
      { "n", "\\leader ic",    "Insert comment separator" },
    },
  },
  {
    name = "Clojure (Fireplace)",
    maps = {
      { "n", "E",   "Evaluate expression (*.clj, *.cljc)" },
    },
  },
  {
    name = "Neovide",
    maps = {
      { "*", "<D-v>",   "Paste from clipboard (Cmd+V)" },
      { "v", "<D-c>",   "Copy to clipboard (Cmd+C)" },
      { "n", "<D-=>",   "Increase font size" },
      { "n", "<D-->",   "Decrease font size" },
      { "n", "<D-0>",   "Reset font size" },
    },
  },
}

-- Build the display lines
local function build_lines(filter)
  local lines = {}
  local filter_lower = filter and filter:lower() or nil

  for _, section in ipairs(sections) do
    local show = true
    if filter_lower then
      show = section.name:lower():find(filter_lower, 1, true) ~= nil
    end

    if show then
      table.insert(lines, "")
      table.insert(lines, "═══ " .. section.name .. " ═══")
      table.insert(lines, "")

      -- Calculate column widths
      local max_mode = 4
      local max_key = 4
      for _, map in ipairs(section.maps) do
        max_mode = math.max(max_mode, #map[1])
        max_key = math.max(max_key, #map[2])
      end

      -- Header
      local header = string.format(
        "  %-" .. max_mode .. "s  %-" .. max_key .. "s  %s",
        "Mode", "Key", "Action"
      )
      table.insert(lines, header)
      table.insert(lines, "  " .. string.rep("─", #header))

      for _, map in ipairs(section.maps) do
        table.insert(lines, string.format(
          "  %-" .. max_mode .. "s  %-" .. max_key .. "s  %s",
          map[1], map[2], map[3]
        ))
      end
    end
  end

  if #lines == 0 then
    table.insert(lines, "No sections matching '" .. (filter or "") .. "'")
  end

  return lines
end

-- Get section names for completion
local function get_section_names()
  local names = {}
  for _, section in ipairs(sections) do
    table.insert(names, section.name)
  end
  return names
end

-- Show maps in a floating window
local function show_maps(filter)
  local lines = build_lines(filter)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = "maps"
  vim.bo[buf].bufhidden = "wipe"

  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * 0.75)
  local height = math.min(#lines + 2, math.floor(ui.height * 0.8))

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((ui.height - height) / 2),
    col = math.floor((ui.width - width) / 2),
    style = "minimal",
    border = "rounded",
    title = filter and (" Maps: " .. filter .. " ") or " Frio Keymaps ",
    title_pos = "center",
  })

  vim.wo[win].wrap = false
  vim.wo[win].cursorline = true

  -- Highlight section headers
  for i, line in ipairs(lines) do
    if line:match("^═══") then
      vim.api.nvim_buf_add_highlight(buf, -1, "Title", i - 1, 0, -1)
    elseif line:match("^  Mode") then
      vim.api.nvim_buf_add_highlight(buf, -1, "Comment", i - 1, 0, -1)
    elseif line:match("^  ─") then
      vim.api.nvim_buf_add_highlight(buf, -1, "Comment", i - 1, 0, -1)
    end
  end

  -- Close with q or Esc
  vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", function() vim.api.nvim_win_close(win, true) end, { buffer = buf, nowait = true })
end

-- Register :StaticMaps command with tab completion
vim.api.nvim_create_user_command("StaticMaps", function(opts)
  local filter = opts.args ~= "" and opts.args or nil
  show_maps(filter)
end, {
  nargs = "?",
  complete = function(arg_lead)
    local names = get_section_names()
    local matches = {}
    for _, name in ipairs(names) do
      if name:lower():find(arg_lead:lower(), 1, true) then
        table.insert(matches, name)
      end
    end
    return matches
  end,
})
