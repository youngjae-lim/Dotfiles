local actions = require "telescope.actions"

local action_state = require "telescope.actions.state"
local custom_actions = {}

function custom_actions._multiopen(prompt_bufnr, open_cmd)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local num_selections = #picker:get_multi_selection()
	if num_selections > 1 then
		local cwd = picker.cwd
		if cwd == nil then
			cwd = ""
		else
			cwd = string.format("%s/", cwd)
		end
		vim.cmd "bw!"
		for _, entry in ipairs(picker:get_multi_selection()) do
			vim.cmd(string.format("%s %s%s", open_cmd, cwd, entry.value))
		end
		vim.cmd "stopinsert"
	else
		if open_cmd == "vsplit" then
			actions.file_vsplit(prompt_bufnr)
		elseif open_cmd == "split" then
			actions.file_split(prompt_bufnr)
		elseif open_cmd == "tabe" then
			actions.file_tab(prompt_bufnr)
		else
			actions.select_default(prompt_bufnr)
		end
	end
end
function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
	custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function custom_actions.multi_selection_open_split(prompt_bufnr)
	custom_actions._multiope(prompt_bufnr, "split")
end
function custom_actions.multi_selection_open_tab(prompt_bufnr)
	custom_actions._multiopen(prompt_bufnr, "tabe")
end
function custom_actions.multi_selection_open(prompt_bufnr)
	custom_actions._multiopen(prompt_bufnr, "edit")
end

require("telescope").setup {
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case", -- this is default
		},
		bookmarks = { selected_browser = "chrome", url_open_command = "open" },
		file_browser = { hidden = true },
	},
	defaults = {
		layout_config = {
			width = 0.75,
			prompt_position = "top",
			preview_cutoff = 120,
			horizontal = { mirror = false },
			vertical = { mirror = false },
		},
		find_command = {
			"rg",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = " ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = {},
		winblend = 0,
		border = {},
		-- borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<tab>"] = actions.toggle_selection + actions.move_selection_next,
				["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist,
				["<esc>"] = actions.drop_all + actions.close,
				["<CR>"] = custom_actions.multi_selection_open,
				["<c-v>"] = custom_actions.multi_selection_open_vsplit,
				["<c-s>"] = custom_actions.multi_selection_open_split,
				["<c-t>"] = custom_actions.multi_selection_open_tab,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<tab>"] = actions.toggle_selection + actions.move_selection_next,
				["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist,
				["<esc>"] = actions.drop_all + actions.close,
				["<CR>"] = custom_actions.multi_selection_open,
				["<c-v>"] = custom_actions.multi_selection_open_vsplit,
				["<c-s>"] = custom_actions.multi_selection_open_split,
				["<c-t>"] = custom_actions.multi_selection_open_tab,
			},
		},
	},
}

-- Extensions --

-- https://github.com/dhruvmanila/telescope-bookmarks.nvim
require("telescope").load_extension "bookmarks"
require("telescope").load_extension "neoclip"
require("telescope").load_extension "fzf"
require("telescope").load_extension "file_browser"

-- my telescopic customizations
local M = {}

function M.grep_notes()
	local opts = {}
	opts.hidden = true
	opts.search_dirs = { "~/Google Drive/My Drive/Notes/" }
	opts.prompt_prefix = "   "
	opts.prompt_title = " Grep Notes"
	opts.path_display = { "smart" }
	require("telescope.builtin").live_grep(opts)
end

function M.find_notes()
	require("telescope.builtin").find_files {
		prompt_title = " Find Notes",
		path_display = { "smart" },
		cwd = "~/Google Drive/My Drive/Notes/",
		layout_strategy = "horizontal",
		layout_config = { preview_width = 0.65, width = 0.75 },
	}
end

function M.browse_webdev_projects()
	require("telescope").extensions.file_browser.file_browser {
		prompt_title = " Browse WebDev Projects",
		prompt_prefix = " ﮷ ",
		path = "~/Projects/Personal/Web-developments/",
		layout_strategy = "horizontal",
		layout_config = { preview_width = 0.65, width = 0.75 },
	}
end

function M.browse_nvim_config()
	require("telescope").extensions.file_browser.file_browser {
		prompt_title = " Browse Nvim Configs",
		prompt_prefix = " ﮷ ",
		path = "~/.config/nvim/",
		layout_strategy = "horizontal",
		layout_config = { preview_width = 0.65, width = 0.75 },
	}
end

-- grep_string pre-filtered from grep_prompt
local function grep_filtered(opts)
	opts = opts or {}
	require("telescope.builtin").grep_string {
		path_display = { "smart" },
		search = opts.filter_word or "",
	}
end

-- open vim.ui.input dressing prompt for initial filter
function M.grep_prompt()
	vim.ui.input({ prompt = "Rg " }, function(input)
		grep_filtered { filter_word = input }
	end)
end

-- search todos
function M.search_todos()
	require("telescope.builtin").grep_string {
		prompt_title = " Search @TODOs",
		prompt_prefix = " ",
		results_title = "@TODOs Results",
		path_display = { "smart" },
		search = "TODO:",
	}
end

return M
