local _99 = require("99")

local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)

_99.setup({
    -- Default: OpenCode provider
    -- provider = _99.Providers.ClaudeCodeProvider,  -- uncomment to use Claude Code
    model = "anthropic/claude-opus-4-6",
    logger = {
        level = _99.DEBUG,
        path = "/tmp/" .. basename .. ".99.debug",
        print_on_error = true,
    },
    completion = {
        source = "cmp",
    },
    md_files = {
        "AGENT.md",
    },
})

-- Visual: send selection + prompt to AI, replace with result
vim.keymap.set("v", "<leader>9v", function()
    _99.visual()
end)

-- Cancel all in-flight requests
vim.keymap.set("n", "<leader>9x", function()
    _99.stop_all_requests()
end)

-- Search: AI-powered project search → quickfix list
vim.keymap.set("n", "<leader>9s", function()
    _99.search()
end)

-- Telescope: switch model on the fly
vim.keymap.set("n", "<leader>9m", function()
    require("99.extensions.telescope").select_model()
end)

-- Telescope: switch provider on the fly
vim.keymap.set("n", "<leader>9p", function()
    require("99.extensions.telescope").select_provider()
end)
