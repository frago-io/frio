local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"

-- Ensure the directory exists
vim.fn.mkdir(parser_install_dir, "p")

-- Set the custom parser directory
vim.opt.runtimepath:append(parser_install_dir)
require('nvim-treesitter').setup {
    ensure_installed = {
            "haskell" ,"bash", "c", "css",
            "html", "javascript", "json", "lua", "python", 
            "typescript", "yaml", "markdown", "markdown_inline"
    },
    highlight = { enable = true },
    parser_install_dir = parser_install_dir,
}

-- Enable markdown fenced code block highlighting
vim.g.markdown_fenced_languages = {
    "javascript",
    "js=javascript",
    "python",
    "html",
    "css",
    "bash",
    "lua",
    "haskell"
}
