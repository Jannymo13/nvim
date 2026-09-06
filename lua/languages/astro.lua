return {
    -- Mason packages to install (LSP servers, formatters, linters, debuggers)
    mason_packages = {
        "astro-language-server",
        "html-lsp",
    },

    -- Lazy.nvim plugins specific to this language
    plugins = {
        {
            'wuelnerdotexe/vim-astro',
            config = function ()
            end
        }
    },

    -- LSP configuration (supports single or multiple servers)
    -- Multiple LSP servers:
    lsp = {
        {
            name = "astro",
            config = {

            }
        },
        {
            name = "html",
            config = {
                filetypes = { "html", "astro" }
            }
        }
    },
}
