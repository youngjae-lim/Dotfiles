-- autocommands
--- This function is taken from https://github.com/norcalli/nvim_utils
local nvim_create_augroups = function(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_command("augroup " .. group_name)
		vim.api.nvim_command "autocmd!"
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
			vim.api.nvim_command(command)
		end
		vim.api.nvim_command "augroup END"
	end
end

-- Define your own autocmds object here to be passed into nvim_create_augroups function
-- Note that each object can have multiple definitions
local autocmds = {
	-- Turn a markdown note file into a pdf
	turn_markdown_to_pdf = {
		{ "BufWritePost", "*note-*.md", 'silent !buildNote.sh "%:p"' },
	},
	-- Run PackerSync automatically whenever ~./config/nvim/lua/plugins/init.lua file is saved
	-- @TODO: Follow up the issue where PackerSync removes and installs a newly added plugin instead of just installing.
	run_packersync = {
		{
			"BufWritePost",
			"*/nvim/lua/plugins/init.lua",
			"source <afile> | PackerSync",
		},
	},
	-- Use q to close for a set of these filetypes
	q_to_close = {
		{
			"FileType",
			"qf,help,man,lspinfo",
			"nnoremap <silent> <buffer> q :close<CR>",
		},
	},
	-- Save and Load view (mainly for folds)
	-- save_load_view = {
	-- 	{ "BufWinLeave", "*.*", "if &buftype != 'terminal' | mkview" },
	-- 	{ "BufWinEnter", "*.*", "if &buftype != 'terminal' | silent! loadview" },
	-- },
	-- Highlight on yank for 2 seconds
	highlight_on_yank = {
		{
			"TextYankPost",
			"*",
			"silent! lua vim.highlight.on_yank({higroup = 'Visual', timeout = 2000})",
		},
	},
}

nvim_create_augroups(autocmds)
-- autocommands END
