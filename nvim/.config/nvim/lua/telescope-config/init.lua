local actions = require('telescope.actions')
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case" -- this is default
    },
    bookmarks = {selected_browser = "google_chrome", url_open_command = "open"}
  },
  defaults = {
    layout_config = {width = 0.75, prompt_position = "top", preview_cutoff = 120, horizontal = {mirror = false}, vertical = {mirror = false}},
    find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    }
  }
}

-- Extensions --

-- https://github.com/dhruvmanila/telescope-bookmarks.nvim
require("telescope").load_extension("bookmarks")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("fzf")
require("telescope").load_extension("repo")

-- my telescopic customizations
local M = {}

-- requires repo extension
function M.repo_list()
  local opts = {}
  opts.prompt_title = " Repos"
  require("telescope").extensions.repo.list(opts)
end

function M.grep_notes()
  local opts = {}
  opts.hidden = true
  opts.search_dirs = {"~/Google Drive/My Drive/Notes/"}
  opts.prompt_prefix = "   "
  opts.prompt_title = " Grep Notes"
  opts.path_display = {"smart"}
  require("telescope.builtin").live_grep(opts)
end

function M.find_notes()
  require("telescope.builtin").find_files {
    prompt_title = " Find Notes",
    path_display = {"smart"},
    cwd = "~/Google Drive/My Drive/Notes/",
    layout_strategy = "horizontal",
    layout_config = {preview_width = 0.65, width = 0.75}
  }
end

function M.browse_webdev_projects()
  require("telescope.builtin").file_browser {
    prompt_title = " Browse WebDev Projects",
    prompt_prefix = " ﮷ ",
    cwd = "~/Projects/Personal/Web-developments/",
    layout_strategy = "horizontal",
    layout_config = {preview_width = 0.65, width = 0.75}
  }
end

-- search todos
function M.search_todos()
  require("telescope.builtin").grep_string {
    prompt_title = " Search @TODOs",
    prompt_prefix = " ",
    results_title = "@TODOs Results",
    path_display = {"smart"},
    search = "@TODO"
  }
end

return M
