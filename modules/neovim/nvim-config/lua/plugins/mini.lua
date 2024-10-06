require('mini.move').setup({
    mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        down = '<S-j>',
        up = '<S-k>',
    },

    -- Options which control moving behavior
    options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
    },
})

require('mini.git').setup({
    job = {
        git_executable = 'git',
        timeout = 30000,
    },
    command = {
        split = 'vertical',
    },
})

vim.keymap.set({ 'n', 'v' }, '<C-g>', '<cmd>lua MiniGit.show_at_cursor()<CR>', { desc = "Show git history at cursor" })
vim.keymap.set('v', '<C-g>', '<cmd>lua MiniGit.show_range_history()<CR>', { desc = "Show git history of line range" })
