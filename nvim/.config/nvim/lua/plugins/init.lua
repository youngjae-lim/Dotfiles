return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- use 'shaunsingh/nord.nvim'
  -- use 'lifepillar/vim-gruvbox8'
  -- use 'ghifarit53/tokyonight-vim'
  -- use 'whatsthatsmell/codesmell_dark.vim'
  -- use 'overcache/NeoSolarized'
  -- use 'EdenEast/nightfox.nvim'
  use {'sainnhe/everforest', config = "vim.cmd('colorscheme everforest')"}
  -- use {'rose-pine/neovim', config = "vim.cmd('colorscheme rose-pine')"}
  use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate", event = "BufWinEnter", config = "require('treesitter-config')"}
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    event = "BufWinEnter",
    config = "require('lualine-config')"
  }
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons', event = "BufWinEnter", config = "require('bufferline-config')"}
  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', cmd = "NvimTreeToggle", config = "require('nvim-tree-config')"}
  use {'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter"}
  use {'p00f/nvim-ts-rainbow', after = "nvim-treesitter"}
  use {'windwp/nvim-autopairs', config = "require('autopairs-config')", after = "nvim-cmp"}
  use {'folke/which-key.nvim', event = "BufWinEnter", config = "require('whichkey-config')"}
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}, cmd = "Telescope", config = "require('telescope-config')"}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use 'nvim-lua/popup.nvim'
  use 'jvgrootveld/telescope-zoxide'
  use 'dhruvmanila/telescope-bookmarks.nvim'
  use {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require('neoclip').setup()
    end
  }
  use 'cljoly/telescope-repo.nvim'
  use {'neovim/nvim-lspconfig', config = "require('lsp')"}
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {'hrsh7th/nvim-cmp', requires = {'kdheepak/cmp-latex-symbols'}}
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'onsails/lspkind-nvim'
  use 'ray-x/lsp_signature.nvim'
  use {'norcalli/nvim-colorizer.lua', event = "BufRead", config = "require('colorizer-config')"}
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  }
  use {'simrat39/rust-tools.nvim', config = "require('rust-tools-config')"}
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'junegunn/vim-easy-align'
  use {'akinsho/toggleterm.nvim', config = "require('toggleterm-config')"}
  use {'matze/vim-move', config = "require('vim-move-config')"}
  use {'glepnir/dashboard-nvim', cmd = "Dashboard", config = "require('dashboard-config')"}
  use {'lukas-reineke/indent-blankline.nvim', event = "BufRead", config = "require('blankline-config')"}
  use {'lukas-reineke/format.nvim', cmd = "Format", config = "require('format-config')"}
end)

