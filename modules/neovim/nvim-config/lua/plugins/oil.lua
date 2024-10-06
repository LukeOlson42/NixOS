require('oil').setup({
    default_file_explorer = true,
    columns = {
        { 'permissions', highlight = 'Identifier' },
        { 'size', highlight = 'Special'},
    },

    win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
    },

    view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
            return vim.startswith(name, '.')
        end,
        is_always_hidden = function(name, bufnr)
            return (name == '..')
        end,
    },

    keymaps = {
        ['<C-o>'] = 'actions.parent',
        ['<C-c>'] = 'actions.close',
        ['<CR>'] = 'actions.select',
        ['g?'] = 'actions.show_help',
    },
    use_default_keymaps = false,
})

vim.api.nvim_create_user_command('Ex', 'Oil', { nargs = 0 })
vim.keymap.set('n', '<leader>out', '<cmd>Oil<CR>')
