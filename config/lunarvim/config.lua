--[[
  LunarVim user configuration
  lvim is the global options object

  @author James Grundner <james@jgrundner.com>
]]

-- ---------------------------------
-- General
-- ---------------------------------
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "vscode"
lvim.leader = "space"

-- ---------------------------------
-- Global variables
-- ---------------------------------
vim.g.vscode_italic_comment = true
vim.g.italic_comments = true
vim.g.vscode_disable_nvimtree_bg = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ---------------------------------
-- Global options
-- ---------------------------------
vim.opt.background = "dark"
vim.opt.cmdheight  = 1
vim.opt.timeoutlen = 300
vim.opt.colorcolumn = '120'
vim.opt.relativenumber = false
vim.opt.guifont = "monospace:h17"
vim.opt.formatoptions:remove "cro"
--vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.cmd [[set iskeyword+=-]]
--[[ vim.opt.iskeyword:apend("-")]]
vim.cmd [[set statusline+=%f]]
--[[ vim.opt.statusline:apend "%f" ]]

-- ---------------------------------
-- Diagnostic color highlighting
-- ---------------------------------
vim.api.nvim_command("highlight LspDiagnosticsUnderlineError gui=undercurl")
vim.api.nvim_command("highlight LspDiagnosticsUnderlineWarning gui=undercurl")
vim.api.nvim_command("highlight LspDiagnosticsUnderlineInformation gui=undercurl")
vim.api.nvim_command("highlight LspDiagnosticsUnderlineInfo gui=undercurl")
vim.api.nvim_command("highlight LspDiagnosticsUnderlineHint gui=undercurl")
vim.api.nvim_command("highlight WinSeparator gui=none")
vim.api.nvim_command("highlight LspDiagnosticsDefaultHint guifg=#00ff00 gui=nocombine")
vim.api.nvim_command("highlight LspDiagnosticsDefaultInfo guifg=#73D7FF gui=nocombine")
vim.api.nvim_command("highlight LspDiagnosticsDefaultWarn guifg=#ffff00 gui=nocombine")
vim.api.nvim_command("highlight LspDiagnosticsDefaultError guifg=#ff0000 gui=nocombine")

-- ---------------------------------
-- Keymappings [view all the defaults by pressing <leader>sk]
-- ---------------------------------
-- Normal
lvim.keys.normal_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["zf"] = "zf%"
lvim.keys.normal_mode[",/"] = "<cmd>Telescope live_grep<cr>"
lvim.keys.normal_mode[",,/"] = "<cmd>lua require 'telescope.builtin'.grep_string({find_command = { 'rg', vim.fn.expand('<cword>'), '--ignore', '--hidden', '--smart-case' }})<CR>"
lvim.keys.normal_mode["ff"] = "<cmd>Telescope find_files<cr>"
-- Insert
lvim.keys.insert_mode["jj"] = "<ESC>"
-- Visual Block
lvim.keys.visual_block_mode["<A-j>"] = ":move '>+1<CR>gv-gv"
lvim.keys.visual_block_mode["<A-k>"] = ":move '<-2<CR>gv-gv"
-- Visual
lvim.keys.visual_mode["p"] = '"_dP'


-- ---------------------------------
-- Use which-key to add extra bindings with the leader-key prefix
-- ---------------------------------
lvim.builtin.which_key.mappings["q"] = {}
lvim.builtin.which_key.mappings["ga"] = { "<cmd>Git blame<CR>", "Blame File" }
lvim.builtin.which_key.mappings["gd"] = {
  name = "DiffView",
  ["c"] = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
  ["f"] = { "<cmd>DiffviewFileHistory<cr>", "File History" },
  ["o"] = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
}
lvim.builtin.which_key.mappings["ge"] = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle Blame" }
lvim.builtin.which_key.mappings["gl"] = { "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>", "Blame Line" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
lvim.builtin.which_key.mappings["s/"] = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" }
lvim.builtin.which_key.mappings["o"] = {
  name = "Outline",
  ["t"] = { "<cmd>SymbolsOutline<CR>", "Toggle Outline" },
  ["o"] = { "<cmd>SymbolsOutlineOpen<CR>", "Open Outline" },
  ["c"] = { "<cmd>SymbolsOutlineClose<CR>", "Close Outline" }
}

-- ---------------------------------
-- Telescope config
-- ---------------------------------
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
local _, telescope_config = pcall(require, "telescope_config")
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config.width = 0.99
lvim.builtin.telescope.defaults.layout_config.height = 0.99
lvim.builtin.telescope.defaults.pickers = telescope_config.pickers()
lvim.builtin.telescope.pickers = telescope_config.pickers()
-- Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}
-- ---------------------------------

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- ---------------------------------
-- Terminal
-- ---------------------------------
lvim.builtin.terminal.active = true

-- ---------------------------------
-- Nvim Tree
-- ---------------------------------
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- ---------------------------------
-- LuaLine
-- ---------------------------------
local _, lualine_config = pcall(require, "lualine_config")
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.disabled_filetypes = { "alpha", "dashboard", "toggleterm", "Outline", "NvimTree" }
lvim.builtin.lualine.sections = lualine_config.sections()

-- ---------------------------------
-- Treesitter parsers
-- ---------------------------------
-- If you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "css",
  "java",
  "javascript",
  "json",
  "lua",
  "markdown",
  "php",
  "python",
  "rust",
  "tsx",
  "typescript",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- ---------------------------------
-- generic LSP settings
-- ---------------------------------

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "bash-language-server",
  "css-lsp",
  "eslint-lsp",
  "html-lsp",
  "intelephense",
  "json-lsp",
  "lemminx",
  "lua-language-server",
  "pyright",
  "solang",
  "sumneko_lua",
  "tailwindcss-language-server",
  "typescript-language-server",
  "vim-language-server",
  "yaml-language-server",
}

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.diagnostics.virtual_text = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
---@diagnostic disable-next-line: missing-parameter
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "intelephense" })
local php_opts = {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  settings = {
    rootMarkers = { ".git/", "composer.json" },
  }
}
require("lvim.lsp.manager").setup("intelephense", php_opts)

-- ---------------------------------
-- Additional Plugins
-- ---------------------------------
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require('vscode').change_style("dark")
    end
  },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  {
    "sindrets/diffview.nvim",
    commit = "a1fbcaa7e1e154cfa793ab44da4a6eb0ae15458d",
    event = "BufRead",
    requires = "nvim-lua/plenary.nvim"
  },
  {
    "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require"lsp_signature".on_attach() end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },
  {
    "npxbr/glow.nvim",
    ft = {"markdown"}
    -- run = "yay -S glow"
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
    require('neoscroll').setup({
          -- All these keys will be mapped to their corresponding default scrolling animation
          mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
          hide_cursor = true,          -- Hide cursor while scrolling
          stop_eof = true,             -- Stop at <EOF> when scrolling downwards
          use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
          respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
          cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
          easing_function = nil,        -- Default easing function
          pre_hook = nil,              -- Function to run before the scrolling animation starts
          post_hook = nil,              -- Function to run after the scrolling animation ends
          })
    end
  },
  {
      "ethanholz/nvim-lastplace",
      event = "BufRead",
      config = function()
          require("nvim-lastplace").setup({
              lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
              lastplace_ignore_filetype = {
                  "gitcommit", "gitrebase", "svn", "hgcommit",
              },
              lastplace_open_folds = true,
          })
      end,
  },
}

-- ---------------------------------
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- ---------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"gitcommit", "markdown"},
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"gitcommit", "markdown"},
  command = "setlocal spell",
})
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  command = "setlocal number",
})

