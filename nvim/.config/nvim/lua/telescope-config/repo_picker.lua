-- This is a telescope repo picker that allows you to change repo based on the zoxide query results.
-- The functionality is mapped to <,z> to list directories and select one.
-- stylua: ignore start
local actions      = require "telescope.actions"
local pickers      = require "telescope.pickers"
local finders      = require "telescope.finders"
local sorters      = require "telescope.sorters"
local action_state = require "telescope.actions.state"
local utils        = require "telescope.utils"
-- stylua: ignore end

-- enter applies a selected item to window
local enter = function(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	-- Show selected items
	-- print(vim.inspect(selected[1]))
	-- extract only the path part from the entire string
	-- selected = string.sub(selected[1], string.find(selected[1], "/"), string.len(selected[1]))
	local cmd = "cd " .. selected[1]
	vim.cmd(cmd)
	actions.close(prompt_bufnr)
end

-- next_repo selects next item and applies it to window immediately
local next_repo = function(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
end

-- prev_repo selects previous item and applies it to window immediately
local prev_repo = function(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
end

-- customized layout
local layout = {
	layout_strategy = "vertical",
	layout_config = { height = 50, width = 0.7, prompt_position = "top" },
	sorting_strategy = "ascending",
}

-- get a list of resulting cmd output from running 'fd '^\.git$' -H --type=d /Users/youngjaelim/Projects -x echo {//}'
local stdout, _, _ = utils.get_os_command_output {
	"fd",
	"^\\.git$",
	"-H", -- search hidden folder as well
	"--type=d", -- find directory
	"/Users/youngjaelim/Projects",
	"-x", -- execute
	"echo", -- print out
	"{//}", -- parent directory
}

local opts = {
	finder = finders.new_table(stdout),
	sorter = sorters.get_generic_fuzzy_sorter {},

	attach_mappings = function(_, map)
		map("i", "<CR>", enter)
		map("i", "<C-J>", next_repo)
		map("i", "<C-K>", prev_repo)

		map("n", "<CR>", enter)
		map("n", "j", next_repo)
		map("n", "k", prev_repo)
		return true
	end,
}

local repo_picker = pickers.new(layout, opts)

local M = {}

function M.repo_picker()
	repo_picker:find()
end

return M
