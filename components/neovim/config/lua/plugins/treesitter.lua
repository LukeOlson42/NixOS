local config = {
    -- A list of parser names, or "all" (the listed parsers should always be installed)
    ensure_installed = { "c", "lua", "json", "python", "cpp", "cmake", "markdown", "haskell"},

    compilers = {"gcc"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {},

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

vim.filetype.add({     --  adds groovy syntax highlighting to Jenkinsfiles
    filename = {
        ['Jenkinsfile'] = 'groovy',
        ['*.dis'] = 'asm'
    },
})

require('nvim-treesitter.configs').setup(config)
