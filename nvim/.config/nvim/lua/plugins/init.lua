local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	-- print("Installing packer close and reopen Neovim...")

	require "notify"(
		"Installing packer.nvim from its github repository...",
		"info",
		{ title = "Installation of packer.nvim" }
	)
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install plugins
return require("packer").startup(function(use)
	-- Package Manager for neovim
	use "wbthomason/packer.nvim"

	-- Colorschemes
	use "savq/melange"
	use "lunarvim/darkplus.nvim"
	use "whatsthatsmell/codesmell_dark.vim"
	use "overcache/NeoSolarized"
	use "EdenEast/nightfox.nvim"
	use "rose-pine/neovim"
	use "shaeinst/roshnivim-cs"
	use "sainnhe/everforest"

	-- Treesitter-related plugins
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
	use "JoosepAlviste/nvim-ts-context-commentstring"
	use "windwp/nvim-ts-autotag"
	use "p00f/nvim-ts-rainbow"

	-- UI-related plugins
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	}
	use { "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" }
	use { "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }
	use "windwp/nvim-autopairs"
	use "norcalli/nvim-colorizer.lua"
	use "lukas-reineke/indent-blankline.nvim"
	use "folke/which-key.nvim"
	use "akinsho/toggleterm.nvim"
	use "stevearc/dressing.nvim"
	use "glepnir/dashboard-nvim"
	use "rcarriga/nvim-notify"

	-- Telescope and its extensions
	use { "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } }
	use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
	use "nvim-lua/popup.nvim"
	use "dhruvmanila/telescope-bookmarks.nvim"
	use {
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	}
	-- use "cljoly/telescope-repo.nvim"
	use "nvim-telescope/telescope-file-browser.nvim"

	-- cmp plugins
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },
			{ "ray-x/cmp-treesitter" },
			{ "kdheepak/cmp-latex-symbols" },
		},
	}
	-- TODO: after using lsp-installer, this plugin is not working possibly because the lua language server path changed to local nvim. I think I have to modify cmd variable or something like that, so that lua-dev can pick up the server.
	use "folke/lua-dev.nvim"

	-- LSP
	use "neovim/nvim-lspconfig"
	use "williamboman/nvim-lsp-installer"
	use "tamago324/nlsp-settings.nvim"
	use "jose-elias-alvarez/null-ls.nvim"
	use "onsails/lspkind-nvim"
	use "ray-x/lsp_signature.nvim"
	use "simrat39/rust-tools.nvim"
	use "mfussenegger/nvim-dap"
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	}

	-- Git
	use {
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	}

	-- Convenience plugins(mostly making editing experience great!)
	use "junegunn/vim-easy-align"
	use "matze/vim-move"
	-- use 'lukas-reineke/format.nvim' -- format on save
	use "azabiong/vim-highlighter"
	use "tpope/vim-surround"
	use "numToStr/Comment.nvim"
	use {
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
