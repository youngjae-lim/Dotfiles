-- This is a telescope directory picker that allows you to change directory based on the zoxide query results.
-- The functionality is mapped to <,z> to list directories and select one.
local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local action_state = require "telescope.actions.state"
local utils = require('telescope.utils')

-- enter applies a selected item to window
local enter = function(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  -- Show selected items
  -- print(vim.inspect(selected[1]))
  -- extract only the path part from the entire string
  selected = string.sub(selected[1], string.find(selected[1], '/'),
                        string.len(selected[1]))
  local cmd = 'cd ' .. selected
  vim.cmd(cmd)
  actions.close(prompt_bufnr)
end

-- next_directory selects next item and applies it to window immediately
local next_directory = function(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
end

-- prev_directory selects previous item and applies it to window immediately
local prev_directory = function(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
end

-- customized layout
local layout = {
  layout_strategy = "vertical",
  layout_config = {height = 50, width = 0.7, prompt_position = "top"},
  sorting_strategy = "ascending"
}

-- get a list of resulting cmd output from running 'zoxide query -ls'
local stdout, _, _ = utils.get_os_command_output({"zoxide", "query", "-ls"})

local opts = {
  finder = finders.new_table(stdout),
  sorter = sorters.get_generic_fuzzy_sorter({}),

  attach_mappings = function(_, map)
    map("i", "<CR>", enter)
    map("i", "<C-J>", next_directory)
    map("i", "<C-K>", prev_directory)

    map("n", "<CR>", enter)
    map("n", "j", next_directory)
    map("n", "k", prev_directory)
    return true
  end
}

local directory_picker = pickers.new(layout, opts)

local M = {}

function M.directory_picker()
  directory_picker:find()
end

return M
