-- ============================================================================
-- GENERAL KEYMAPS
-- ============================================================================
-- NOTE: Plugin-specific keymaps (Snacks, LSP, etc.) are defined in their
--       respective plugin files. See lua/plugins/snacks.lua for Snacks keymaps.

-- Save and Quit
vim.keymap.set({ "n", "i", "v" }, "<C-s>", vim.cmd.w, { desc = "Save file" })
vim.keymap.set({ "n", "i", "v" }, "<C-q>", vim.cmd.q, { desc = "Quit window" })
vim.keymap.set({ "n", "i", "v" }, "<C-A-q>", vim.cmd.qa, { desc = "Quit all" })

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })

-- Better delete (don't yank)
vim.keymap.set("n", "x", '"_x', { desc = "Delete char (no yank)" })
vim.keymap.set("n", "s", '"_s', { desc = "Substitute char (no yank)" })

-- Center search results
vim.keymap.set("n", "n", "nzz", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzz", { desc = "Previous search result (centered)" })

-- Copy file path to clipboard
vim.keymap.set("n", "yp", ":let @+ = expand('%:p')<CR>", { desc = "Yank file Path to clipboard" })

-- Better clipboard (system clipboard)
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- ============================================================================
-- VISUAL MODE
-- ============================================================================

-- Move lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Stay in indent mode
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })

-- ============================================================================
-- WINDOW NAVIGATION & MANAGEMENT
-- ============================================================================

-- Navigate windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })

-- Resize windows
vim.keymap.set({ "n", "t", "v", "i" }, "<C-.>", "<C-w>>", { desc = "Increase window width" })
vim.keymap.set({ "n", "t", "v", "i" }, "<C-,>", "<C-w><", { desc = "Decrease window width" })

-- Move windows
vim.keymap.set("n", "<C-Left>", "<C-w>H", { desc = "Move window to left" })
vim.keymap.set("n", "<C-Right>", "<C-w>L", { desc = "Move window to right" })
vim.keymap.set("n", "<C-Up>", "<C-w>K", { desc = "Move window to top" })
vim.keymap.set("n", "<C-Down>", "<C-w>J", { desc = "Move window to bottom" })

-- Split windows
vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split Vertical" })
vim.keymap.set("n", "<leader>h", "<C-w>s", { desc = "Split Horizontal" })

-- ============================================================================
-- BUFFER NAVIGATION
-- ============================================================================

vim.keymap.set("n", "<Tab>", vim.cmd.bnext, { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprevious, { desc = "Previous buffer" })

-- ============================================================================
-- TERMINAL MODE
-- ============================================================================

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- PLUGIN KEYMAPS
-- ============================================================================

-- Neotree
vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle<CR>", { desc = "Toggle Neotree" })
