local langs = require("languages")
langs.setup()

local lsp = {
    -- Core LSP & tools
    {
        "williamboman/mason.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-lint",
            "stevearc/conform.nvim",
        },
        lazy = false,
        keys = {
            {
                "<leader>fm",
                function()
                    require("conform").format({
                        async = true,
                        lsp_fallback = true,
                    })
                end,
                desc = "ForMat code"
            },
        },

        config = function()
            -- install mason packages
            require("mason").setup()
            local mason_registry = require("mason-registry")
            for _, tool in ipairs(langs.mason_packages) do
                if not mason_registry.is_installed(tool) then
                    mason_registry.get_package(tool):install()
                end
            end


            -- Setup linters
            local lint = require("lint")
            lint.linters_by_ft = langs.linters

            --linting on save
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })

            require("conform").setup({
                formatters_by_ft = langs.formatters,
            })

            vim.lsp.enable(langs.lsp)

            vim.diagnostic.config({
                virtual_text = { current_line = false },
                virtual_lines = {
                    current_line = true,
                },
                underline = true,
                update_in_insert = false,
            })
        end,
    },
}

if langs.plugins then
    vim.list_extend(lsp, langs.plugins)
end

return lsp
