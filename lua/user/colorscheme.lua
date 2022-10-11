vim.g.vscode_italic_comment = true
vim.g.italic_comments = true
vim.g.vscode_disable_nvimtree_bg = true
vim.o.background = "dark"
vim.cmd [[
try
  " colorscheme darkplus
  colorscheme vscode
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

vim.api.nvim_command("highlight LspDiagnosticsUnderlineError gui=undercurl")
vim.api.nvim_command("highlight LspDiagnosticsUnderlineWarning gui=undercurl")
vim.api.nvim_command("highlight LspDiagnosticsUnderlineInformation gui=undercurl")
vim.api.nvim_command("highlight LspDiagnosticsUnderlineInfo gui=undercurl")
vim.api.nvim_command("highlight LspDiagnosticsUnderlineHint gui=undercurl")
