local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  print("Installing packer close and reopen Neovim...")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'single'})
    end
  }
})

-- Install plugins
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- use 'shaunsingh/nord.nvim'
  -- use 'lifepillar/vim-gruvbox8'
  -- use 'ghifarit53/tokyonight-vim'
  -- use 'whatsthatsmell/codesmell_dark.vim'
  -- use 'overcache/NeoSolarized'
  -- use 'EdenEast/nightfox.nvim'
  use 'sainnhe/everforest'
  use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
  use 'windwp/nvim-ts-autotag'
  use 'p00f/nvim-ts-rainbow'
  use 'windwp/nvim-autopairs'
  use 'folke/which-key.nvim'
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
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
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {'hrsh7th/nvim-cmp', requires = {'kdheepak/cmp-latex-symbols'}}
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'onsails/lspkind-nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  }
  use 'simrat39/rust-tools.nvim'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'junegunn/vim-easy-align'
  use 'akinsho/toggleterm.nvim'
  use 'matze/vim-move'
  use 'glepnir/dashboard-nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'lukas-reineke/format.nvim'
  use 'azabiong/vim-highlighter'
  use 'tpope/vim-surround'
  use 'stevearc/dressing.nvim'
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then require('packer').sync() end
end)
