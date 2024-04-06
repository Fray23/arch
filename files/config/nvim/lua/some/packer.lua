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

    -- decorations

    use 'ryanoasis/vim-devicons'
    use 'nvim-tree/nvim-web-devicons'
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'
    use 'windwp/nvim-autopairs'

    use {
      'phaazon/mind.nvim',
      branch = 'v2.2',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require'mind'.setup()
      end
    }
    use {"shortcuts/no-neck-pain.nvim", tag = "*" }

    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use {
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function()
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }
    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
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
    use {
      "startup-nvim/startup.nvim",
       config = function()
         require"startup".setup()
       end
    }
    use 'preservim/tagbar'
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {                                      -- Optional
          'williamboman/mason.nvim',
          run = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
      }
}
end)
