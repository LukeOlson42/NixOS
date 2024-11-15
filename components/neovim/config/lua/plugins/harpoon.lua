local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- Adding and viewing marks
vim.keymap.set('n', '<leader>add', mark.add_file)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

-- hot-swapping marks
vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end)
vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end)
vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end)
