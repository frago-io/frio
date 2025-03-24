require("avante_lib").load()
require("avante").setup(
{
    --- ... existing configurations
    provider = 'groq', -- In this example, use Claude for planning, but you can also use any provider you want.
    cursor_applying_provider = 'groq', -- In this example, use Groq for applying, but you can also use any provider you want.
    behaviour = {
        --- ... existing behaviours
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
    },
    windows = {
        width = 43,
        ask = {
            floating = true,
        },
    },
    vendors = {
        --- ... existing vendors
        groq = { -- define groq provider
            __inherited_from = 'openai',
            api_key_name = 'GROQ_API_KEY',
            endpoint = 'https://api.groq.com/openai/v1/',
            model = 'llama-3.3-70b-versatile',
            max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
    },
    --- ... existing configurations
}
)
