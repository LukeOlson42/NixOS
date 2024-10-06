local new_command = vim.api.nvim_create_user_command

new_command("Clean",
    function()
        local r,c = unpack(vim.api.nvim_win_get_cursor(0))
        print("Clearing background buffers...")
        vim.cmd("%bd|e#|bd#")
        vim.api.nvim_win_set_cursor(0, {r,c}) -- now we go back to where we were before
    end,
    {
        nargs = 0
    }
)


