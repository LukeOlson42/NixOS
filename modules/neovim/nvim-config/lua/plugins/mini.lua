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

