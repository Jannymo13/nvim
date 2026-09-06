return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false, -- neo-tree will lazily load itself
	keys = {
		{
			"<C-n>",
			function()
				local current_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })

				if current_ft == "neo-tree" then
					-- Safely close Neo-tree without passing '%'
					vim.cmd("Neotree filesystem toggle")
				else
					-- Open Neo-tree and focus on the current normal file
					vim.cmd("Neotree filesystem toggle %")
				end
			end,
			-- ":Neotree filesystem toggle %<CR>",
			desc = "Open Neotree",
		},
	},
}
