local status_ok, prettyfold = pcall(require, "pretty-fold")
if not status_ok then
  print 'Pretty Fold not loaded'
	return
end

prettyfold.setup {
  keep_indentation = true,
  fill_char = '•',
  sections = {
    left = {
       '+', function() return string.rep('-', vim.v.foldlevel) end,
       ' ', 'number_of_folded_lines', ':', 'content',
    }
  },
  matchup_patterns = {
    { '^%s*do$', 'end' }, -- do ... end blocks
    { '^%s*if', 'end' },  -- if ... end
    { '^%s*for', 'end' }, -- for
    { 'function%s*%(', 'end' }, -- 'function( or 'function (''
    {  '{', '}' },
    { '%(', ')' }, -- % to escape lua pattern char
    { '%[', ']' }, -- % to escape lua pattern char
  },
}
require('pretty-fold.preview').setup{
   default_keybindings = true, -- Set to false to disable default keybindings

   -- 'none', "single", "double", "rounded", "solid", 'shadow' or table
   border = 'rounded' --{' ', '', ' ', ' ', ' ', ' ', ' ', ' '},
}
