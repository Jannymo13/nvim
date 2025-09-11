vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- tab changes
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true

vim.g.have_nerd_font = true

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

-- Command to open language selection menu
vim.api.nvim_create_user_command("LangMenu", function()
	require("languages.menu").select_languages()
end, { desc = "Open language selection menu" })
