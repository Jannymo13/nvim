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

vim.wo.wrap = false

vim.g.have_nerd_font = true

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 20


-- Command to open language selection menu
vim.api.nvim_create_user_command("LangMenu", function()
	require("languages.menu").select_languages()
end, { desc = "Open language selection menu" })

