-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

npairs.setup {
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<C-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
}

local rule_status_ok, rule = pcall(require, "nvim-autopairs.rule")
if not rule_status_ok then
	return
end

local ts_conds_status_ok, ts_conds = pcall(require, "nvim-autopairs.ts-conds")
if not ts_conds_status_ok then
	return
end

-- Add customized rules for each filetype - these are just examples, please feel free to delete or comment them out
npairs.add_rules { rule("$$", "$$", "tex") }
npairs.add_rules {
	-- press % => %% only while inside a comment or string
	rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
	-- don't insert $$ while inside a function
	rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
}

-- If you want insert `(` after select function or method item
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
