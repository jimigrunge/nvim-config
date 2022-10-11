local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  print 'Alpha not loaded'
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  "|===========================================================|",
  "|___________________________________________________________|",
  "|---,---,---,---,---,---,---,---,---,---,---,---,---,-------|",
  "| ` | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | - | = | <-    |",
  "|---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|",
  "| ->| | Q | W | E | R | T | Y | U | I | O | P | [ | ] |  \\  |",
  "|-----',--',--',--',--',--',--',--',--',--',--',--',--'-----|",
  "| Caps | A | S | D | F | G | H | J | K | L | ; | ' |  Enter |",
  "|------'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'--------|",
  "| Shift  | Z | X | C | V | B | N | M | , | . | / |   Shift  |",
  "|------,-' ,--'--,'---'---'---'---'---'---'-,-'--',--,------|",
  "| ctrl |   | alt |                          | alt |  | ctrl |",
  "|------'   '-----'--------------------------'-----'  '------|",
  "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|",
  "|===========================================================|",
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
	return "jgrundner.com"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
