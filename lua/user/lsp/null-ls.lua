local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- js jsx ts tsx html css json yaml markdown
    formatting.prettier,
    -- python
    formatting.black.with({ extra_args = { "--fast" } }),
    -- lua
    formatting.stylua,
    -- php
    formatting.phpcbf.with({ extra_args = { "--standard=PSR12", "-"}}),
    --bash
    formatting.shellharden,
    -- java
    formatting.google_java_format,
    -- js jsx ts tsx html css json yaml markdown
    -- diagnostics.eslint,
    -- python
    -- diagnostics.flake8,
    -- lua
    diagnostics.luacheck,
    -- php
    diagnostics.phpcs.with({extra_args = { "--standard=PSR12", "-"}}),
    -- css
    diagnostics.stylelint,
    -- bash
    diagnostics.shellcheck,

    -- null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.code_actions.proselint,
    -- null_ls.builtins.code_actions.refactoring,
    -- null_ls.builtins.code_actions.shellcheck,

    null_ls.builtins.hover.dictionary,
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.gitsigns,
  },
})
