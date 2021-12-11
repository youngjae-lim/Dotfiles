-- Change diagnostic symbols in the sign column (gutter)
local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

Border = {
  {"╭", "FloatBorder"}, {"─", "FloatBorder"}, {"╮", "FloatBorder"},
  {"│", "FloatBorder"}, {"╯", "FloatBorder"}, {"─", "FloatBorder"},
  {"╰", "FloatBorder"}, {"│", "FloatBorder"}
}

vim.api.nvim_command(
    "autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({border="
        .. vim.inspect(Border) .. ", focusable=false})")
