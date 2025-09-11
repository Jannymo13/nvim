return {
    mason_packages = { "typescript-language-server", "prettier" },
    -- linters = { python = { "flake8" } },
    formatters = { typescript = { "prettier" } },

    lsp = {
        name = "ts_ls",
        -- config = {
        -- }
    },

}
