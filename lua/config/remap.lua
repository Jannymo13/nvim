-- Save and Close
vim.keymap.set({ "n", "i", "v" }, "<C-s>", vim.cmd.w)
vim.keymap.set({ "n", "i", "v" }, "<C-q>", vim.cmd.q)
vim.keymap.set({ "n", "i", "v" }, "<C-A-q>", vim.cmd.qa)

-- Neotree
vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle<CR>", { desc = "Open Neotree" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "yp", ":let @+ = expand('%:p')<CR>")

-- Buffer Movement
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

vim.keymap.set('n', '<Tab>', vim.cmd.bnext)
vim.keymap.set('n', '<S-Tab>', vim.cmd.bprevious)

-- Buffer sizing and movement
vim.keymap.set({ "n", "t", "v", "i" }, "<c-.>", "<c-w>>")
vim.keymap.set({ "n", "t", "v", "i" }, "<c-,>", "<c-w><")

vim.keymap.set("n", "<C-Left>", "<C-w>H")
vim.keymap.set("n", "<C-Right>", "<C-w>L")
vim.keymap.set("n", "<C-Up>", "<C-w>K")
vim.keymap.set("n", "<C-Down>", "<C-w>J")

vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>h", "<C-w>s", { desc = "Horizontal Split" })

-- QOL
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "s", '"_s')

vim.keymap.set("v", ">", '>gv')
vim.keymap.set("v", "<", '<gv')

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch)

vim.keymap.set('n', '<Tab>', vim.cmd.bnext)
vim.keymap.set('n', '<S-Tab>', vim.cmd.bprevious)

vim.keymap.set("v", "<C-c>", '"+y')
