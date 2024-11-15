require("gruvbox").setup({
    terminal_colors = true,

    undercurl = false,
    underline = false,

    bold = true,
    italic = {
        strings = true,
        comments = true,
    },

    dim_inactive = true,
})

vim.cmd("colorscheme gruvbox")
