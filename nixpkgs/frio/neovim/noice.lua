local routes_ =  {
    {
        filter = {
            event = "msg_show",
            find = "^E162: No write since last change for buffer \".+\"$"
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "^%d+ fewer lines$"
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "^E37: No write since last change$"
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "B written$"
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "^Already at oldest change$",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "^Already at newest change$",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "seconds ago$",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "second ago$",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "fewer lines$",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "more lines$",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "lines indented$",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "lines yanked$",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "lines >ed ",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "msg_show",
            find = "lines <ed ",
        },
        opts = { skip = true },
    },
}
require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    routes = routes_,
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
})
