-- BORDER
require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}

-- BUNNY
require("bunny"):setup({
  hops = {
    { key = "~", path = "~", desc = "Home" },
    { key = "p", path = "~/Pictures", desc = "Pictures" },
    { key = "c", path = "~/.config", desc = "Config" },
    { key = "r", path = "~/programming", desc = "Programming" },
  },
})

-- TELEGRAM
require("telegram-send"):setup({
	command = "telegram-send --file",
	notification = true,
})
