require('nvim-autopairs').setup({check_ts = true})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rule(Rule("$$", "$$", "tex"))

-- you can use some built-in conditions

local cond = require('nvim-autopairs.conds')
-- print(vim.inspect(cond))

npairs.add_rules({
  Rule("$", "$", {"tex", "latex"}) -- don't add a pair if the next character is %
  :with_pair(cond.not_after_regex("%%")) -- don't add a pair if  the previous character is xxx
  :with_pair(cond.not_before_regex("xxx", 3)) -- don't move right when repeat character
  :with_move(cond.none()) -- don't delete if the next character is xx
  :with_del(cond.not_after_regex("xx")) -- disable adding a newline when you press <cr>
  :with_cr(cond.none())
}, -- disable for .vim files, but it work for another filetypes
Rule("a", "a", "-vim"))

