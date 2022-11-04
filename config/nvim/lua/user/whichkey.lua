local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local mappings = {
  [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
  ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Comment" },
  ["?"] = { "<cmd>Cheatsheet<cr>", "Cheatsheet" },
  [">"] = { "<cmd>BufferLineMoveNext<CR>", "BufferMoveNext" },
  ["<lt>"] = { "<cmd>BufferLineMovePrev<CR>", "BufferMovePrevious" },
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = {
    name = "Buffers",
    ["b"] = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffers" },
    ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    ["p"] = {"<cmd>BufferLinePick<cr>", "Pick"},
    ["j"] = { "<cmd>BufferLineMoveNext<CR>", "BufferMoveNext" },
    ["k"] = { "<cmd>BufferLineMovePrev<CR>", "BufferMovePrevious" },
  },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["d"] = {
    name = "Debug",
    ["b"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    ["B"] = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Conditional Breakpoint" },
    ["c"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    ["e"] = { "<cmd>lua require'dapui'.eval(<expression>)<cr>", "Eval Expression" },
    ["i"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    ["l"] = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
    ["o"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    ["O"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    ["r"] = { "<cmd>lua require'dap'.repl.open()<cr>", "REPL" },
    ["t"] = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    ["u"] = { "<cmd>lua require'dapui'.toggle()<cr>", "DapUi Toggle" },
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["f"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
  ["g"] = {
    name = "Git",
    ["a"] = { "<cmd>Git blame<CR>", "Blame" },
    ["b"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["c"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    ["C"] = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
    -- TODO: Why is this broken: open a issue with dev
    -- ["d"] = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    ["d"] = {
      name = "DiffView",
      ["c"] = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
      ["f"] = { "<cmd>DiffviewFileHistory<cr>", "File History" },
      ["o"] = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
    },
    ["e"] = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle Blame" },
    ["g"] = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "LazyGit" },
    ["j"] = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    ["k"] = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    ["l"] = { "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>", "Blame" },
    ["o"] = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    ["p"] = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    -- This works I just don't want it on for the moment
    -- ["r"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    -- ["R"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    -- ["s"] = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    ["t"] = { "<cmd>Git status<cr>", "Status"},
    ["u"] = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk"},
  },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  -- ["i"] = {},
  -- ["j"j = {},
  -- ["k"] = {},
  ["l"] = {
    name = "LSP",
    ["a"] = { "<cmd>CodeActionMenu<cr>", "Code Action" },
    ["d"] = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
    ["D"] = { "<cmd>lua require('neogen').generate()<cr>", "Annotations" },
    ["e"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line diagnostic hover" },
    ["E"] = { "<cmd>lua require('lsp_lines').toggle()<CR>", "Line diagnostic" },
    ["f"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
    ["i"] = { "<cmd>LspInfo<cr>", "Info" },
    ["I"] = { "<cmd>Mason<cr>", "Mason Installer" },
    ["j"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    ["k"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    ["l"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    ["M"] = { "<cmd>Mason<cr>", "Mason Installer" },
    ["m"] = { "lua require'nvim-treesitter.textobjects.swap'.swap_previous('@parameter.inner')<CR>", "Swap next param" },
    ["n"] = { "lua require'nvim-treesitter.textobjects.swap'.swap_next('@parameter.inner')<CR>", "Swap prev param" },
    ["o"] = { "<cmd>SymbolsOutline<cr>", "Toggle Outline" },
    ["q"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    ["r"] = { "<cmd>lua require('cosmic-ui').rename()<cr>", "Rename" },
    ["s"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    ["S"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    ["t"] = { "lua require'nvim-treesitter.textobjects.lsp_interop'.peek_definition_code('@function.outer')<CR>", "Peek DefCode Func" },
    ["T"] = { "lua require'nvim-treesitter.textobjects.lsp_interop'.peek_definition_code('@class.outer')<CR>", "Peek DefCode Class" },
    ["w"] = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
  },
  ["m"] = {
    name = "Markdown",
    ["p"] = { "<cmd>Glow<cr>", "Markdown Preview" }
  },
  ["n"] = {
    name = "Neogen",
    ["f"] = { "<cmd>lua require('neogen').generate()<cr>", "Generate Comment"}
  },
  ["o"] = {
    name = "Outline",
    ["t"] = { "<cmd>SymbolsOutline<CR>", "Toggle Outline" },
    ["o"] = { "<cmd>SymbolsOutlineOpen<CR>", "Open Outline" },
    ["c"] = { "<cmd>SymbolsOutlineClose<CR>", "Close Outline" }
  },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
  ["p"] = {
    name = "Packer",
    ["c"] = { "<cmd>PackerCompile<cr>", "Compile" },
    ["i"] = { "<cmd>PackerInstall<cr>", "Install" },
    ["s"] = { "<cmd>PackerSync<cr>", "Sync" },
    ["S"] = { "<cmd>PackerStatus<cr>", "Status" },
    ["u"] = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  -- ["r"] = {},
  ["s"] = {
    name = "Search",
    ["/"] = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
    --[[ ["b"] = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Checkout branch" }, ]]
    ["c"] = { "<cmd>lua require('telescope.builtin').colorscheme()<cr>", "Colorscheme" },
    ["f"] = { "<cmd>lua require('telescope.builtin').fd()<cr>", "FD" },
    --[[ ["h"] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Find Help" }, ]]
    --[[ ["M"] = { "<cmd>lua require('telescope.builtin').man_pages()<cr>", "Man Pages" }, ]]
    ["r"] = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Open Recent File" },
    ["s"] = { ":%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>", "Search Replace" },
    --[[ ["R"] = { "<cmd>lua require('telescope.builtin').registers()<cr>", "Registers" }, ]]
    ["k"] = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", "Keymaps" },
    ["C"] = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
    ["p"] = {
      name = "Picker",
      ["a"] = { "<cmd>PickAltFont<cr>", "Alt Font Picker" },
      ["e"] = { "<cmd>PickEmoji<cr>", "Emoji Picker" },
      --[[ ["E"] = { "<cmd>PickEverything<cr>", "Everything Picker" }, ]]
      ["i"] = { "<cmd>PickIcons<cr>", "Icon Picker" },
      ["n"] = { "<cmd>PickNerd<cr>", "Pick Nerd Icon" },
      ["s"] = { "<cmd>PickSymbols<cr>", "Symbol Picker" },
    }
  },
  ["t"] = {
    name = "Terminal",
    ["g"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "LazyGit" },
    ["n"] = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    ["u"] = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    ["b"] = { "<cmd>lua _BPYTOP_TOGGLE()<cr>", "BPyTop" },
    ["t"] = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    ["p"] = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    ["f"] = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    ["h"] = { "<cmd>ToggleTerm size=80 direction=horizontal<cr>", "Horizontal" },
    ["v"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  -- ["u"] = {},
  -- ["v"] = {},
  ["v"] = {
    name = "VS Code Colors",
    ["d"] = { "<cmd>lua require('vscode').change_style('dark')<cr>", "VS Code Dark" },
    ["l"] = { "<cmd>lua require('vscode').change_style('light')<cr>", "VS Code Light" },
    ["o"] = { "<cmd>colorscheme onedarker<cr>", "One Darker" },
    ["p"] = { "<cmd>colorscheme darkplus<cr>", "Dark Plus" },
  },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["x"] = {
    name = "Diagnostics",
    d = { "<cmd>TroubleToggle document_diagnostics<CR>", "document" },
    l = { "<cmd>TroubleToggle loclist<CR>", "loclist" },
    q = { "<cmd>TroubleToggle quickfix<CR>", "quickfix" },
    R = { "<cmd>TroubleToggle lsp_references<CR>", "references" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "workspace" },
    x = { "<cmd>TroubleToggle<CR>", "trouble" },
  },
  -- ["y"] = {},
  -- ["z"] = {},
}

local n_mappings = {
  ["g"] = {
    name = "LSP",
    ["b"] = {name="+Comment blockwise"},
    ["c"] = {name="+Comment linewise"},
    ["d"] = {"<cmd>Telescope lsp_definitions<CR>", "Definition"},
    ["D"] = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration"},
    ["i"] = {"<cmd>Telescope lsp_implementations<CR>", "Implementation"},
    ["l"] = {"<cmd>lua vim.diagnostic.open_float()<CR>"},
    ["r"] = {"<cmd>Telescope lsp_references<CR>", "References"},
    ["R"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    ["v"] = {name="Reselect"}
  },
  ["K"] = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Hover"},
  ["<C-k>"] = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature"}
}

local v_mappings = {
  ["/"] = { "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Comment" },
  ["f"] = { ":s/\\v%V//gc<Left><Left><Left><Left>", "Search Replace Visual" },
}

local i_mappings = {
  ["p"] = {
    name = "Picker",
    ["a"] = { "<cmd>PickAltFont<cr>", "Alt Font Picker" },
    ["e"] = { "<cmd>PickEmoji<cr>", "Emoji Picker" },
    -- ["E"] = { "<cmd>PickEverything<cr>", "Everything Picker" },
    ["i"] = { "<cmd>PickIcons<cr>", "Icon Picker" },
    ["n"] = { "<cmd>PickNerd<cr>", "Nerd Font Icon" },
    ["s"] = { "<cmd>PickSymbols<cr>", "Symbol Picker" },
  }
}

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  --[[ disable = { ]]
  --[[   buftypes = {}, ]]
  --[[   filetypes = { "TelescopePrompt" }, ]]
  --[[ }, ]]
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local iopts = {
  mode = "i", -- VISUAL mode
  prefix = "<Tab>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(n_mappings, { mode = "n", prefix = "", preset = true })
which_key.register(v_mappings, vopts)
which_key.register(i_mappings, iopts)
