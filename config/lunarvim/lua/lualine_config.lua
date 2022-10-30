local M = {}

local ll_hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local ll_branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}
local ll_diff = {
	"diff",
	colored = true,
  diff_color = {
    -- Same color values as the general color option can be used here.
    added    = 'DiffAdd',    -- Changes the diff's added color
    modified = 'DiffChange', -- Changes the diff's modified color
    removed  = 'DiffDelete', -- Changes the diff's removed color you
  },
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = ll_hide_in_width
}
local ll_diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}
local ll_filename = {
  "filename",
  file_status = true,
  path = 1,                -- 0: Just the filename
                           -- 1: Relative path
                           -- 2: Absolute path
                           -- 3: Absolute path, with tilde as the home directory
  shorting_target = 40,
  symbols = {
    modified = '[+]',      -- Text to show when the file is modified.
    readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
  }
}
local ll_spaces = function()
	return "sp: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

function M.sections()
  local sections = {}

  sections["lualine_a"] = { "mode" }
  sections["lualine_b"] = { ll_branch, ll_diff } --, ll_diagnostics }
  sections["lualine_c"] = { ll_filename }
  sections["lualine_x"] = { ll_spaces, "encoding", "filetype" }
  sections["lualine_y"] = { "location" }
  sections["lualine_z"] = { "filesize", "progress" }

  return sections
end

return M
