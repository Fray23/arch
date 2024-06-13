vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- theme
    use 'navarasu/onedark.nvim'
    use 'folke/tokyonight.nvim'
    use 'shaunsingh/nord.nvim'
    use 'morhetz/gruvbox'
    use 'ellisonleao/gruvbox.nvim'
    use 'Mofiqul/dracula.nvim'
    use 'sainnhe/everforest'
    use 'catppuccin/nvim'
    use 'bluz71/vim-nightfly-colors'
    use 'NTBBloodbath/doom-one.nvim'
    use 'metalelf0/base16-black-metal-scheme'
    use 'EdenEast/nightfox.nvim'
    use 'ayu-theme/ayu-vim'
    use 'Shatur/neovim-ayu'
    use 'lunacookies/vim-colors-xcode'
    use 'chriskempson/vim-tomorrow-theme'
    use 'maxmx03/solarized.nvim'
    use 'antonk52/lake.nvim'

    -- auto save
    use 'pocco81/auto-save.nvim'

    -- nerd tree
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'

    -- git
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'

    -- decorations
    use 'ryanoasis/vim-devicons'
    use 'nvim-tree/nvim-web-devicons'
    use {"shortcuts/no-neck-pain.nvim", tag = "*" }
    use {
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function()
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }
    -- func
    use 'windwp/nvim-autopairs'

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'ThePrimeagen/harpoon'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use 'dense-analysis/ale'

    -- lsp
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        {'neovim/nvim-lspconfig'},
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},
      }
    } 
    -- snippet
    use 'honza/vim-snippets'
end)


