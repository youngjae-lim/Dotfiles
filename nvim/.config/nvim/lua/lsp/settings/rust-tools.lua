return {
	-- rust-tools options
	-- default values are: https://github.com/simrat39/rust-tools.nvim/blob/master/lua/rust-tools/config.lua
	autoSetHints = true,
	--[[ hover_with_actions = true, ]]
	runnables = {
		use_telescope = false,
	},
	inlay_hints = {
		show_parameter_hints = false,
		parameter_hints_prefix = "",
		other_hints_prefix = "",
	},
	hover_actions = {
		border = "single",
	},
}
