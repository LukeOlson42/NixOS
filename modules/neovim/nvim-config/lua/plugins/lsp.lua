local lsp = require("lsp-zero")
local cmp = require('cmp')
local lspcfg = require('lspconfig')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<C-r>', function() vim.lsp.buf.rename() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'clangd', 'rust_analyzer'},
    handlers = {
        lsp.default_setup,

        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            lspcfg.lua_ls.setup(lua_opts)
        end,

        clangd = function()
            local c_opts = {
                cmd = {"clangd", "--header-insertion=never"},
                filetypes = {"c", "cpp", "objc", "objcpp"},
            }
            lspcfg.clangd.setup(c_opts)
        end,
    },
})

cmp.setup({
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
    },

    formatting = lsp.cmp_format(),

    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-d>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm( {select = false} ),
    }),

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    experimental = {
        ghost_text = true, -- i love ghost text
    },
})

vim.diagnostic.config({
    virtual_text = true,
})

vim.opt.signcolumn = 'no'

