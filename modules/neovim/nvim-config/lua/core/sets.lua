local set = vim.opt

-- line numbers on, no relative numbers
set.nu = true
set.relativenumber = false

-- tabs are 4 spaces, expand to spaces to appease the python gods
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

-- Don't let the cursor get to the bottom of the screen
set.scrolloff = 8
set.cursorline = true

-- Don't highlight all of the time, search incrementally,
-- and have fun smart search (only be case sensitive if
-- upper case are used)
set.hlsearch = false
set.incsearch = true
set.ignorecase = true
set.smartcase = true

-- using lualine, dont need the mode or selection count anyways
set.showmode = false
set.showcmd = false

set.lazyredraw = true
set.linebreak = true
set.splitright = true
set.swapfile = false

-- I like having the current line highlighted
-- with a nice gold color :)
vim.api.nvim_set_hl(0, 'CursorLineNr', {
--    fg = '#cfb53b',  -- this is my attempt at making a nice gold
    fg = '#E7C664',  -- this is the actual sonokai yellow
    bold = true,
})
set.termguicolors = true

-- let netrw lump .c and .h files together
vim.g.netrw_sort_sequence = '[\\/]$,*,\\.bak$,\\.o$,\\*.[h|c]$,\\.info$,\\.swp$,\\.obj$'
