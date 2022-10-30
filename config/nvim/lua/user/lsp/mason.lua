-- -----------------------------------
-- LSP servers
local servers = {
	"bashls",       -- bash
	"cssls",        -- css
	"eslint",       -- js/ts
	"html",         -- html
	"intelephense", -- PHP
	"jsonls",       -- json
	"lemminx",      -- XML/XSLT
	"pyright",      -- python
	"solang",       -- solona
	"sumneko_lua",  -- lua
	"tsserver",     -- typescript
	"vimls",        -- vim
	"yamlls",       -- yaml
}

-- -----------------------------------
-- List of formatters & linters for mason to install
local linter_formatters = {
  "prettier",           -- ts/js formatter
  "black",              -- python formatter
  "stylua",             -- lua formatter
  "phpcbf",             -- php formatting
  "shellharden",        -- bash formatting
  "google_java_format", -- java formatting
  "eslint_d",           -- ts/js linter
  "luacheck",           -- lua linter
  "phpcs",              -- php linting
  "stylelint",          -- css linting
  "shellcheck",         -- bash linting
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

-- -----------------------------------
-- Setup installer
require("mason").setup(settings)

-- -----------------------------------
-- Language plugin server installation
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

-- -----------------------------------
-- null-ls format/lint installation configuration
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason_null_ls.setup({
	ensure_installed = linter_formatters,
	automatic_installation = true,
})

-- -----------------------------------
-- Configure LSP
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

  -- Install custom LSP settings
	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
