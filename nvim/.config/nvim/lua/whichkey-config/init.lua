local wk = require "which-key"
wk.setup {
	plugins = {
		marks = false,
		registers = false,
		spelling = { enabled = false, suggestions = 20 },
		presets = {
			operators = false,
			motions = false, -- Don't set this to true. Otherwise, vim-highligher won't work.
			text_objects = false, -- Don't set this to true. Otherwise, vim-highligher won't work.
			windows = true,
			nav = false,
			z = false,
			g = false,
		},
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 6, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
}

-- @TODO: organize which-keys
local mappings = {
	x = { ":bdelete!<CR>", "Close Buffer" },
	E = { ":e ~/.config/nvim/init.lua<CR>", "Edit nvim config" },
	f = {
		':Telescope find_files hidden=true file_ignore_patterns={".git/"} no_ignore=true<CR>',
		"Telescope Find Files",
	},
	r = { ":Telescope live_grep<CR>", "Telescope Live Grep" },
	b = {
		'<cmd>lua require("telescope").extensions.file_browser.file_browser() <CR>',
		"Telescope File Browser",
	},
	O = { "<cmd>!mostRecentNote.sh<CR>", "Open Most Recent Note in PDF" },

	-- LSP-related keybindings
	l = {
		name = "LSP",
		-- show LSP code actions - lists any LSP actions for the word under the cursor, that can be triggered with <CR>
		a = {
			"<Cmd>lua require'telescope.builtin'.lsp_code_actions()<CR>",
			"Code Actions",
		},
		-- show LSP definitions - go to the definition of the word under the cursor, if there's only one, otherwise show all options
		d = {
			"<Cmd>lua require'telescope.builtin'.lsp_definitions({layout_config = { preview_width = 0.50, width = 0.92 }, path_display = { 'shorten' }, results_title='Definitions'})<CR>",
			"Go To Definitions",
		},
		-- List LSP diagnostics for the current buffer
		g = {
			"<Cmd>lua require'telescope.builtin'.diagnostics({bufnr = 0})<CR>",
			"List Diagnostics @Current Buffer",
		},
		-- List LSP diagnostics for all open buffers
		G = {
			"<Cmd>lua require'telescope.builtin'.diagnostics()<CR>",
			"List Diagnotics for All Open Buffers",
		},
		-- Display hover information abuot the symbol under the cursor in a floating window.
		h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
		i = { ":LspInfo<CR>", "Connected Language Servers" },
		I = { ":LspInstallInfo<CR>", "Install Info" },
		-- List LSP references for word under the cursor
		r = {
			"<Cmd>lua require'telescope.builtin'.lsp_references()<CR>",
			"Show References",
		},
		-- Rename all references to the symbol under the cursor.
		R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		-- Display signature information about the symbol under the cursor in a floating window.
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		-- show LSP document symbols(function, property, variable, etc) in the current buffer
		y = {
			"<Cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>",
			"List Symbols @Current Buffer",
		},
		-- show LSP document symbols(function, property, variable, etc) in the current workspace
		Y = {
			"<Cmd>lua require'telescope.builtin'.lsp_workspace_symbols()<CR>",
			"List Symbols @Current Workspace",
		},
	},

	-- Terminal-related keybindings
	t = {
		name = "Terminal",
		t = { ":ToggleTerm<CR>", "Split Below" },
		f = { "<cmd>lua _TOGGLE_FLOAT()<CR>", "Floating Terminal" },
		l = { "<cmd>lua _TOGGLE_LAZYGIT()<CR>", "Floating Lazygit" },
		n = { "<cmd>lua _TOGGLE_NOTETAKER()<CR>", "Floating Notetaker" },
	},

	-- Trouble keybindings
	T = {
		name = "Trouble",
		s = { "<cmd>TodoTelescope<CR>", "Todos" },
		t = { "<cmd>Trouble<CR>", "Trouble" },
		w = { "<cmd>Trouble workspace_diagnostics<CR>", "Workspace Diagnotics" },
		d = { "<cmd>Trouble document_diagnostics<CR>", "Document Diagnotics" },
		l = { "<cmd>Trouble loclist<CR>", "Location List" },
		q = { "<cmd>Trouble quickfix<CR>", "Quickfix List" },
		r = { "<cmd>Trouble lsp_references<CR>", "References" },
	},
}

local opts = { prefix = "<leader>" }
wk.register(mappings, opts)
