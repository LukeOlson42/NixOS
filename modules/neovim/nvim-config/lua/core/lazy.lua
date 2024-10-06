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

    { 'ellisonleao/gruvbox.nvim' },

	{
		'nvim-telescope/telescope.nvim',
		dependencies = {'nvim-lua/plenary.nvim'}
  	},

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'}
    },

    {'nvim-treesitter/nvim-treesitter'},

    {'theprimeagen/harpoon'},

    {'echasnovski/mini.nvim', version = '*'},

    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = {'nvim-tree/nvim-web-devicons'},
    },

    {
        'ej-shafran/compile-mode.nvim',
        opts = {},
	dependencies = {'nvim-lua/plenary.nvim'},
        config = function()
            print('Compile mode: Enabled')
        end,
    },

}, config)
