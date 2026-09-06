return {
	mason_packages = { "typescript-language-server", "prettier" },
	formatters = {
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		vue = { "prettier" },
	},
	plugins = {
		{
			"windwp/nvim-ts-autotag",
            event = { "BufReadPre", "BufNewFile" },
			opts = {
				opts = {
				},
			},
		},
	},

	lsp = {
		name = "ts_ls",
		config = {
			settings = {
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
			},
		},
	},
}
