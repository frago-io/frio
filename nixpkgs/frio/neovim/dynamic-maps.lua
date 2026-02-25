-- Dynamic keymap discovery command
-- Usage:
--   :Maps            — show all custom keymaps, grouped by source
--   :Maps <filter>   — filter by source/key/description (fuzzy)
--   :Maps n          — show only normal mode maps
--   :Maps v          — show only visual mode maps
--   :Maps i          — show only insert mode maps

local modes_to_scan = { "n", "v", "x", "i", "t", "o", "s" }

-- Known plugin patterns to categorize keymaps by source file or rhs content
local source_patterns = {
  { pattern = "99",                   label = "99 (AI Agent)" },
  { pattern = "telescope",            label = "Telescope" },
  { pattern = "Telescope",            label = "Telescope" },
  { pattern = "copilot",              label = "Copilot" },
  { pattern = "Copilot",              label = "Copilot" },
  { pattern = "NERDTree",             label = "NERDTree" },
  { pattern = "nerdtree",             label = "NERDTree" },
  { pattern = "fugitive",             label = "Git (Fugitive)" },
  { pattern = "Fugitive",             label = "Git (Fugitive)" },
  { pattern = "gitgutter",            label = "Git (Gitgutter)" },
  { pattern = "cmp",                  label = "Completion (nvim-cmp)" },
  { pattern = "lsp",                  label = "LSP" },
  { pattern = "vim.lsp",              label = "LSP" },
  { pattern = "diagnostic",           label = "LSP" },
  { pattern = "Hoogle",               label = "Haskell (Hoogle)" },
  { pattern = "stylish%-haskell",     label = "Haskell" },
  { pattern = "EasyAlign",            label = "Alignment" },
  { pattern = "Tabularize",           label = "Alignment" },
  { pattern = "CamelCaseMotion",      label = "CamelCaseMotion" },
  { pattern = "ColorScheme",          label = "Colorscheme" },
  { pattern = "Grammarous",           label = "Grammarous" },
  { pattern = "FlowMake",             label = "Flow" },
  { pattern = "fireplace",            label = "Clojure (Fireplace)" },
  { pattern = "Eval",                 label = "Clojure (Fireplace)" },
  { pattern = "lean",                 label = "Lean" },
  { pattern = "CtrlP",                label = "CtrlP" },
  { pattern = "ctrlp",                label = "CtrlP" },
  { pattern = "neovide",              label = "Neovide" },
  { pattern = "render%-markdown",     label = "Render Markdown" },
  { pattern = "mason",                label = "Mason" },
  { pattern = "fidget",               label = "Fidget" },
  { pattern = "luasnip",              label = "LuaSnip" },
  { pattern = "LuaSnip",              label = "LuaSnip" },
}

--- Try to classify a keymap into a group based on its rhs, desc, or source
--- @param map table  a keymap entry from vim.api.nvim_get_keymap or nvim_buf_get_keymap
--- @return string  the group label
local function classify(map)
  -- Combine all text fields for matching
  local rhs = map.rhs or map.callback and "<Lua callback>" or ""
  local desc = map.desc or ""
  local source = ""

  -- Try to extract source from Lua callback info
  if map.callback then
    local info = debug.getinfo(map.callback, "S")
    if info and info.source then
      source = info.source
    end
  end

  local haystack = rhs .. " " .. desc .. " " .. source

  for _, p in ipairs(source_patterns) do
    if haystack:find(p.pattern) then
      return p.label
    end
  end

  -- Fallback: try to infer from the source file path
  if source:find("init%.lua") then
    return "General (init.lua)"
  elseif source:find("telescope") then
    return "Telescope"
  elseif source:find("lsp") then
    return "LSP"
  end

  return "Other"
end

--- Check if a keymap is "interesting" (not a default vim builtin)
--- @param map table
--- @return boolean
local function is_custom(map)
  -- Skip <Plug> internal mappings
  local lhs = map.lhs or ""
  if lhs:find("<Plug>") then return false end

  -- Skip <SNR> script-internal mappings
  if lhs:find("<SNR>") then return false end

  -- Must have some rhs or callback (not just a mode remap)
  if not map.rhs and not map.callback then return false end

  -- Skip empty rhs with no callback
  if map.rhs == "" and not map.callback then return false end

  return true
end

--- Describe the rhs in a human-readable way
--- @param map table
--- @return string
local function describe(map)
  if map.desc and map.desc ~= "" then
    return map.desc
  end

  local rhs = map.rhs or ""

  -- Clean up common patterns for display
  rhs = rhs:gsub("^:", "")
  rhs = rhs:gsub("<CR>$", "")
  rhs = rhs:gsub("<cr>$", "")
  rhs = rhs:gsub("^lua ", "")

  if map.callback and (rhs == "" or rhs == nil) then
    -- Try to get useful info from the callback
    local info = debug.getinfo(map.callback, "S")
    if info and info.source and info.short_src then
      local file = info.short_src:match("([^/]+)$") or info.short_src
      return string.format("<Lua %s:%s>", file, info.linedefined or "?")
    end
    return "<Lua callback>"
  end

  -- Truncate long rhs
  if #rhs > 60 then
    rhs = rhs:sub(1, 57) .. "..."
  end

  return rhs
end

--- Collect all keymaps grouped by classification
--- @param filter string|nil
--- @return table<string, table[]>  groups: label -> list of {mode, lhs, desc}
--- @return string[]  sorted group names
local function collect_maps(filter)
  local groups = {}
  local filter_lower = filter and filter:lower() or nil

  -- Check if filter is a single mode letter
  local mode_filter = nil
  if filter_lower and #filter_lower == 1 and vim.tbl_contains(modes_to_scan, filter_lower) then
    mode_filter = filter_lower
    filter_lower = nil  -- don't also text-filter
  end

  for _, mode in ipairs(modes_to_scan) do
    if not mode_filter or mode == mode_filter then
      local maps = vim.api.nvim_get_keymap(mode)
      for _, map in ipairs(maps) do
        if is_custom(map) then
          local group = classify(map)
          local lhs = map.lhs or ""
          local desc_text = describe(map)

          -- Apply text filter
          local show = true
          if filter_lower then
            local haystack = (group .. " " .. lhs .. " " .. desc_text):lower()
            show = haystack:find(filter_lower, 1, true) ~= nil
          end

          if show then
            if not groups[group] then
              groups[group] = {}
            end
            table.insert(groups[group], {
              mode = mode,
              lhs = lhs,
              desc = desc_text,
            })
          end
        end
      end
    end
  end

  -- Sort group names; put "Other" last
  local names = {}
  for name, _ in pairs(groups) do
    table.insert(names, name)
  end
  table.sort(names, function(a, b)
    if a == "Other" then return false end
    if b == "Other" then return true end
    return a < b
  end)

  return groups, names
end

--- Build display lines
--- @param filter string|nil
--- @return string[]
local function build_lines(filter)
  local groups, names = collect_maps(filter)
  local lines = {}

  if #names == 0 then
    table.insert(lines, "  No keymaps found" .. (filter and (" matching '" .. filter .. "'") or ""))
    return lines
  end

  local total = 0
  for _, name in ipairs(names) do
    local maps = groups[name]
    total = total + #maps

    table.insert(lines, "")
    table.insert(lines, "═══ " .. name .. " (" .. #maps .. ") ═══")
    table.insert(lines, "")

    -- Sort maps within group by mode then lhs
    table.sort(maps, function(a, b)
      if a.mode ~= b.mode then return a.mode < b.mode end
      return a.lhs < b.lhs
    end)

    -- Calculate column widths
    local max_mode = 4
    local max_lhs = 3
    for _, m in ipairs(maps) do
      max_mode = math.max(max_mode, #m.mode)
      max_lhs = math.max(max_lhs, #m.lhs)
    end
    max_lhs = math.min(max_lhs, 30) -- cap key column width

    local header = string.format(
      "  %-" .. max_mode .. "s  %-" .. max_lhs .. "s  %s",
      "Mode", "Key", "Description"
    )
    table.insert(lines, header)
    table.insert(lines, "  " .. string.rep("─", #header))

    for _, m in ipairs(maps) do
      local lhs_display = m.lhs
      if #lhs_display > 30 then
        lhs_display = lhs_display:sub(1, 27) .. "..."
      end
      table.insert(lines, string.format(
        "  %-" .. max_mode .. "s  %-" .. max_lhs .. "s  %s",
        m.mode, lhs_display, m.desc
      ))
    end
  end

  table.insert(lines, 1, string.format("  %d keymaps across %d groups", total, #names))

  return lines
end

--- Show dynamic maps in a floating window
--- @param filter string|nil
local function show_dynamic_maps(filter)
  local lines = build_lines(filter)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = "maps"
  vim.bo[buf].bufhidden = "wipe"

  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * 0.8)
  local height = math.min(#lines + 2, math.floor(ui.height * 0.85))

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((ui.height - height) / 2),
    col = math.floor((ui.width - width) / 2),
    style = "minimal",
    border = "rounded",
    title = filter and (" Maps: " .. filter .. " ") or " Frio Keymaps (dynamic) ",
    title_pos = "center",
  })

  vim.wo[win].wrap = false
  vim.wo[win].cursorline = true

  -- Highlight
  for i, line in ipairs(lines) do
    if line:match("^═══") then
      vim.api.nvim_buf_add_highlight(buf, -1, "Title", i - 1, 0, -1)
    elseif line:match("^  Mode") then
      vim.api.nvim_buf_add_highlight(buf, -1, "Comment", i - 1, 0, -1)
    elseif line:match("^  ─") then
      vim.api.nvim_buf_add_highlight(buf, -1, "Comment", i - 1, 0, -1)
    elseif i == 1 then
      vim.api.nvim_buf_add_highlight(buf, -1, "WarningMsg", i - 1, 0, -1)
    end
  end

  -- Close with q or Esc
  vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", function() vim.api.nvim_win_close(win, true) end, { buffer = buf, nowait = true })
end

-- Register :Maps command
vim.api.nvim_create_user_command("Maps", function(opts)
  local filter = opts.args ~= "" and opts.args or nil
  show_dynamic_maps(filter)
end, {
  nargs = "?",
  complete = function(arg_lead)
    -- Offer known group names + mode letters
    local _, names = collect_maps(nil)
    local completions = {}
    for _, name in ipairs(names) do
      if name:lower():find(arg_lead:lower(), 1, true) then
        table.insert(completions, name)
      end
    end
    -- Also offer mode filters
    for _, m in ipairs(modes_to_scan) do
      if m:find(arg_lead:lower(), 1, true) and #arg_lead <= 1 then
        table.insert(completions, m)
      end
    end
    return completions
  end,
})
