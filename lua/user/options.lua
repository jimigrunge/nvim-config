local options = {
  title = false,
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = false,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  laststatus=3,                            -- use a single status line
}

vim.opt.shortmess:append "c"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.cmd [[set statusline+=%f]]

vim.cmd [[
  highlight WinSeparator guibg=None
  hi LspDiagnosticsDefaultHint  guifg=#00ff00 gui=nocombine
  hi LspDiagnosticsDefaultInfo  guifg=#73D7FF gui=nocombine
  hi LspDiagnosticsDefaultWarn  guifg=#ffff00 gui=nocombine
  hi LspDiagnosticsDefaultError guifg=#ff0000 gui=nocombine
]]


-- ------------------------------------
-- Co-Authors for git commit messages
--  - This is being replaced by abbrevman
--    I will be removing this block once
--    it is fully on my work machine
-- ------------------------------------
-- local ex = setmetatable({}, {
--   __index = function(t, k)
--     local command = k:gsub("_$", "!")
--     local f = function(...)
--       return vim.api.nvim_command(table.concat(vim.tbl_flatten { command, ... }, " "))
--     end
--     rawset(t, k, f)
--     return f
--   end,
-- })
-- ex.abbrev("cabjim", "co-authored-by: james grundner <james.grundner@ryansg.com>")
-- ex.abbrev("cabjf", "co-authored-by: joseph frazer <joseph.frazer@ryansg.com>")
-- ex.abbrev("cabmg", "co-authored-by: mark goldsmith <mark.goldsmith@ryansg.com>")
-- ex.abbrev("cabss", "co-authored-by: shelly shaver <shelly.shaver@ryansg.com>")
-- ex.abbrev("cabae", "co-authored-by: andrew elbaneh <andrew.elbaneh@ryansg.com>")
-- ex.abbrev("cabcv", "co-authored-by: corey vollmer <corey.vollmer@ryansg.com>")
-- ex.abbrev("cabrn", "co-authored-by: raymond nagel <raymond.nagel@ryansg.com>")
-- ex.abbrev("cabad", "co-authored-by: anthony dalfonso <anthony.dalfonso@ryansg.com>")
-- ex.abbrev("cabrh", "co-authored-by: ronnie herbine <veronica.herbine@ryansg.com>")
-- ex.abbrev("cabtq", "co-authored-by: thomas quiring <thomas.quiring@ryansg.com>")
-- ex.abbrev("cabme", "co-authored-by: matt edgar <matthew.edgar@rtspecialty.com>")
