return {
    mason_packages = { "lua-language-server", "stylua" },
    formatter = { lua = "stylua" },
    plugins = {
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            },
        },
    },
    lsp = {
        name = "lua_ls",
        config = {
            settings = {
                Lua = {
                    completion = {
                        callSnippet = 'Replace',
                    },
                },
            },
        }
    },
}
