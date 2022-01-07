local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup {
	-- size can be a number or function which is passed the current terminal
	function(term)
		if term.direction == "horizontal" then
			return 40
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,

	open_mapping = [[<c-\>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
}

-- Terminal windows mappings
-- It can be helpful to add mappings to make moving in and out of a terminal easier once toggled, whilst still keeping it open.
function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd "autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()"

-- Floating terminal by toggleterm
local Terminal = require("toggleterm.terminal").Terminal

-- Floating terminal by toggleterm
local float = Terminal:new { direction = "float" }

_TOGGLE_FLOAT = function()
	float:toggle()
end

-- Floating lazygit by toggleterm
local lazygit = Terminal:new { cmd = "lazygit", direction = "float" }

_TOGGLE_LAZYGIT = function()
	lazygit:toggle()
end

-- Floating notetaker by toggleterm
local notetaker = Terminal:new { cmd = "notetaker.sh", direction = "float" }

_TOGGLE_NOTETAKER = function()
	notetaker:toggle()
end
