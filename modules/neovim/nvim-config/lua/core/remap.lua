vim.g.mapleader = " "
local remap = vim.keymap.set

-- various useful keybinds
remap("n", "U", "<C-r>")
remap('n', '<leader>new', 'o<Esc>k')
remap("n", "<leader>out", vim.cmd.Ex)
remap("n", "<leader>j", '/')

-- inspect treesitter data
remap('n', '<A-i>', function() vim.cmd("Inspect") end)

-- The copy-paste keybind of all time 
remap({'n', 'v'}, "P", '"+p')
remap('v', "Y", '"+y')

-- expand braces
-- remap("i", "<C-[>", "{<CR><LF>}<Esc>ki<Tab>")
-- remap("i", "[", "[]<Esc>i") -- maybe make command to enable brace expansion?

-- Jump to beginning or end of line
remap("i", "<C-h>", "<C-o><S-i>")
remap("i", "<C-l>", "<C-o><S-a>")

-- Working with split windows
-- I want to see if I can map this to a function
-- where we see the size of the terminal window, 
-- and if its  <= SCREEN_WIDTH then we open a
-- horizontal split
remap("n", "<leader>sp", "<C-w>v")
remap("n", "<C-l>", "<C-w>l")
remap("n", "<C-h>", "<C-w>h")

-- fancier text selections
remap('n', "<leader>l", "vib")
remap('n', "<leader>k", "viB")
remap('n', "<leader>snag", "vaBok")

-- indentation fix
remap('n', "<leader>fix", "viB=")

-- get rid of those macros
remap('n', "q", "<nop>")
remap('n', "Q", "<nop>")

-- help how do i quit
remap('i', "<C-c>", "<Esc>l")
remap('v', "<C-c>", "<Esc>")

-- set this one when on a unix machine
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Keybind Testing Grounds --
remap('n', '<A-;>', "A;<Esc>");

