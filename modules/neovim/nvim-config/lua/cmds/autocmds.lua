local autocmd = vim.api.nvim_create_autocmd

autocmd('TermOpen', {
    command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
    pattern = '',
    callback = function()
        vim.api.nvim_feedkeys('A', 'n', false)
    end
})

autocmd('BufLeave', {
    pattern = 'term:*',
    command = 'stopinsert',
})

autocmd('BufEnter', {
    pattern = '*compilation*',
    callback = function()
        vim.keymap.set('n', '<C-c>', function()
            local comp_win = vim.fn.win_getid(vim.fn.winnr('#'))
            vim.api.nvim_win_close(comp_win, false)
            vim.keymap.del('n', '<C-c>')
            vim.keymap.del('n', '<C-n>')
        end)
        vim.keymap.set('n', '<C-n>', '<cmd>NextError<CR>')
    end
})

autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('HelpVSplit', { clear = true }),
    callback = function()
        if vim.bo.buftype == 'help' then 
            -- get win number so we can keep it open
            local original_win = vim.fn.win_getid(vim.fn.winnr('#'))

            -- get help buf and win numbers to keep it open
            local help_buf = vim.fn.bufnr()
            local help_win = vim.api.nvim_get_current_win()


            -- set current window to code buffer and close help buffer
            vim.api.nvim_set_current_win(original_win)
            vim.api.nvim_win_close(help_win, false)

            -- open vsplit and set buf to help buf
            vim.cmd('vsplit')
            vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), help_buf)
        end
    end
})
