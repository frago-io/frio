require("avante").setup(
    {
    -- for example
    provider = "openai",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      temperature = 0,
      max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    }
} )


-- {
--     --- ... existing configurations
--     provider = 'claude', -- In this example, use Claude for planning, but you can also use any provider you want.
--     cursor_applying_provider = 'groq', -- In this example, use Groq for applying, but you can also use any provider you want.
--     behaviour = {
--         --- ... existing behaviours
--         enable_cursor_planning_mode = true, -- enable cursor planning mode!
--     },
--     vendors = {
--         --- ... existing vendors
--         groq = { -- define groq provider
--             __inherited_from = 'openai',
--             api_key_name = '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',
--             endpoint = 'https://api.groq.com/openai/v1/',
--             model = 'llama-3.3-70b-versatile',
--             max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
--         },
--     },
--     --- ... existing configurations
-- }
