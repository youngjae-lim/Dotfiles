require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "html", "javascript", "typescript", "lua", "go", "rust", "toml", "yaml",
    "css", "scss", "graphql", "python", "svelte", "gomod", "json", "dockerfile",
    "latex", "tsx", "vue", "vim", "markdown", "bash", "bibtex", "dot", "http",
    "make", "regex"
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false
  },
  autotag = {enable = true},
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autopairs = {enable = true},
  indent = {enable = true}
}
