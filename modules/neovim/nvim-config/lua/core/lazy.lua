local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local config = {
    ui = {
        border = "double",
        title = 'lazy.nvim',
        title_pos = 'center',
        pills = true,
    },
}

require("lazy").setup({
-- 	{
--         'sainnhe/sonokai',
--         config = function()
--             vim.cmd('let g:sonokai_enable_italic = 0')
--             vim.cmd('let g:sonokai_disable_italic_comment = 1')
--             vim.cmd('let g:sonokai_dim_inactive_windows = 1')
--             vim.cmd("let g:sonokai_diagnostic_virtual_text = 'colored'")
--             vim.cmd('colorscheme sonokai')
--         end
-- 	},

    { 'ellisonleao/gruvbox.nvim' },

	{
		'nvim-telescope/telescope.nvim',
		dependencies = {'nvim-lua/plenary.nvim'}
  	},

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'kyazdani42/nvim-web-devicons'}
    },

    {'nvim-treesitter/nvim-treesitter'},

--    {
--        'VonHeikemen/lsp-zero.nvim', -- need to rework when we get nvim 0.10.x
--        dependencies = {
--            -- LSP Support
--            {'neovim/nvim-lspconfig'},             -- Required
--            {'williamboman/mason.nvim'},           -- Optional
--            {'williamboman/mason-lspconfig.nvim'}, -- Optional
--
--            -- Autocompletion
--            {'hrsh7th/nvim-cmp'},         -- Required
--            {'hrsh7th/cmp-nvim-lsp'},     -- Required
--            {'hrsh7th/cmp-path'},         -- Optional
--            {'hrsh7th/cmp-nvim-lua'},     -- Optional
--
--            -- Snippets
--            {'L3MON4D3/LuaSnip'},             -- Required
--        }
--    },

    {'theprimeagen/harpoon'},

    {'echasnovski/mini.nvim', version = '*'},

}, config)
