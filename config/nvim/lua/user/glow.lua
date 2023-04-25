local status_ok, glow = pcall(require, 'glow')
if not status_ok then
  print 'Glow not loaded'
	return
end

glow.setup ({
  install_path = vim.env.HOME .. "/.local/bin", -- default path for installing glow binary
  border = "rounded", -- floating window border config
  pager = false,
  width = 120,
  --[[ height = 180, ]]
  width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
  height_ratio = 0.85,
})
